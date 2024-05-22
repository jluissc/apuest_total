<?php

namespace App\Http\Controllers;

use App\Http\Requests\PayUserRequest;
use App\Models\ChannelAttention;
use App\Models\Client;
use App\Models\ClientPay;
use Illuminate\Http\Request;
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
        $channels = ChannelAttention::get();

        return view('depositar',[
            'clients' => $clients,
            'channel' => $channels
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


            $payUser = ClientPay::create([
                'client_id' => $request->post('client'),
                'amount' => $request->post('amount'),
                'bank' => $request->post('bank'),
                'day' => $request->post('day'),
                'hour' => $request->post('hour'),
                'url_img' => $nombreArchivo,
                'flag' => 1,
                'employed_id' => 1,
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
        return view('deposito_edit', compact('deposito'));
    }
    
    public function update(Request $request, $id)
    {
        //
    }
    
    public function destroy($id)
    {
        //
    }
}
