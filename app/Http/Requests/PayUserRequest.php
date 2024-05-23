<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Http\Exceptions\HttpResponseException;

class PayUserRequest extends FormRequest
{
   
    protected function failedValidation(Validator $validator)
    {
        throw new HttpResponseException(response()->json([
            'estado' => false,
            'errors' => $validator->errors()
        ])); 
    }
    
    public function authorize()
    {
        return true;
    }
    
    public function rules()
    {
        return [
            'amount' => 'required|numeric',
            'bank' => 'required|integer',
            'day' => 'required|date',
            'hour' => 'required|date_format:H:i',
            'imagen' => 'required|mimes:pdf,png,jpg|max:4096', // máximo 4MB
            'client' => 'required|exists:client,id',
            'channel' => 'required|string|max:255',
        ];
    }

    public function messages()
    {
        return [
            'amount.required' => 'Monto necesario',
            'amount.numeric' => 'Monto invalido',
            'bank.required' => 'Nombre de banco faltante',
            'bank.integer' => 'Banco id incorrecto',
            'day.required' => 'Día necesario',
            'day.date' => 'Día incorrecto',
            'hour.required' => 'Hora requerido',
            'hour.date_format' => 'Hora invalido',
            'imagen.required' => 'File necesario',
            'imagen.mimes' => 'Solo PDF, PNG, JPG',
            'imagen.max' => 'Peso de file max. 4MB',
            'client.required' => 'Cliente necesario',
            'client.exists' => 'Cliente no existe',
            'channel.required' => 'Canal requerido',
            'channel.max' => 'Canal excede caracteres de 255',
        ];
    }
}
