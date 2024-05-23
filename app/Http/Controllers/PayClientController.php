<?php

namespace App\Http\Controllers;

use App\Http\Requests\PayUserEditRequest;
use App\Http\Requests\PayUserRequest;
use App\Models\Bank;
use App\Models\ChannelAttention;
use App\Models\Client;
use App\Models\ClientPay;
use App\Models\ClientPayLog;
use App\Models\ModificationType;
use App\Models\PayModify;
use Illuminate\Support\Facades\DB;

class PayClientController extends Controller
{
    public function index()
    {
        $data = DB::select('CALL clientPayData(?)', [0]);
        return view('depositos',[
            'data' => $data,
        ]);
    }
    
    public function create()
    {
        $clients = Client::get();
        $channels = ChannelAttention::where('flag', 1)->get();
        $banks = Bank::where('flag', 1)->get();

        return view('depositar',[
            'clients' => $clients,
            'channel' => $channels,
            'banks' => $banks,
        ]);
    }
    // request the form 
    public function store(PayUserRequest $request)
    {
        // paso request validation
        try {
            // save doc of client

            $pdf_file = $request->file('imagen');
            $nombreArchivo = 'EVEDENCIA_' .$request->post('client').'_'.now()->timestamp.'.'.$pdf_file->extension();
            $pdf_file->storeAs('deposito', $nombreArchivo);


            // cada insercion se pondria en un file service asi no ensucia el codigo de este controllador
            // las disculpas del caso, ya me queda corto el tiempo pero lo menciono porque haria mas legible el codigo
            $payUser = ClientPay::create([
                'client_id' => $request->post('client'),
                'amount' => $request->post('amount'),
                'bank_id' => $request->post('bank'),
                'day' => $request->post('day'),
                'hour' => $request->post('hour'),
                'url_img' => $nombreArchivo,
                'flag' => 1,
                'employed_id' => 1,
                'channel_attention_id' => $request->post('channel'),
            ]);
            ClientPayLog::create([
                'client_id' => $request->post('client'),
                'amount' => $request->post('amount'),
                'bank_id' => $request->post('bank'),
                'day' => $request->post('day'),
                'hour' => $request->post('hour'),
                'url_img' => $nombreArchivo,
                'flag' => 1,
                'employed_id' => 1,
                'type_log' => 'CREATE',
                'channel_attention_id' => $request->post('channel'),
            ]);

            return response()->json([
                'status' => true,
                'data' => $payUser->id,
                'message' => 'Insertado'
            ]);
            
        } catch (\Throwable $th) {
            return response()->json([
                'status' => false,
                'mensaje' => $th->getMessage()
            ]);
        }
    }
    
    public function show($deposito)
    {
        try {
            $url = ClientPay::find($deposito);

            $rutaPdf = storage_path('app/deposito/'.$url->url_img);
            
            $nombreArchivo = basename($rutaPdf);

            return response()->file($rutaPdf, [
                'Content-Disposition' => 'inline; filename="' . $nombreArchivo . '"',
            ]);
        } catch (\Throwable $th) {
            return response()->json([
                'mensaje' => 'No existe archivo en el servidor',
                'tipo' => 'File',
                'error' => $th->getMessage(),
            ]);
        }
    }
    
    public function edit(ClientPay $deposito)
    {
        $channelAttention = ChannelAttention::where('flag', 1)->get();
        $modifityType = ModificationType::where('flag', 1)->get();
        $banks = Bank::where('flag', 1)->get();
        $cliente = Client::find($deposito->client_id);
        return view('deposito_edit', [
            'deposito' => $deposito,
            'channelAttention' => $channelAttention,
            'modifityType' => $modifityType,
            'banks' => $banks,
            'cliente' => $cliente,
        ]);
    }
    
    public function update(PayUserEditRequest $request, $id)
    {
        try {
            $clientPay = ClientPay::find($id);
            $monto_old = $clientPay->amount;
            $bank_old = $clientPay->bank_id;
            $clientPay->update([
                'amount' => $request->post('amount'),
                'bank_id' => $request->post('bank'),
            ]);

            // cada insercion se pondria en un file service asi no ensucia el codigo de este controllador
            // las disculpas del caso, ya me queda corto el tiempo pero lo menciono porque haria mas legible el codigo
            ClientPayLog::create([
                'client_id' => $clientPay->client_id,
                'amount' => $monto_old,
                'bank_id' => $bank_old,
                'day' => $clientPay->day,
                'hour' => $clientPay->hour,
                'url_img' => $clientPay->url_img,
                'flag' => 1,
                'employed_id' => $clientPay->employed_id,
                'type_log' => 'UPDATE',
                'channel_attention_id' => $clientPay->channel_attention_id,
            ]);


            $edit = PayModify::create([
                'client_pay_id' => $id,
                'modification_type_id' => $request->post('modify_type'),
            ]);
            return response()->json([
                'status' => true,
                'data' => $edit->id,
                'message' => 'Insertado'
            ]);
            
        } catch (\Throwable $th) {
            return response()->json([
                'status' => false,
                'mensaje' => $th->getMessage()
            ]);
        }
    }
    
    public function destroy($id)
    {
        //
    }
}
