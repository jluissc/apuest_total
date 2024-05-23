<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Http\Exceptions\HttpResponseException;

class PayUserEditRequest extends FormRequest
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
            'modify_type' => 'required|integer|between:1,15',
        ];
    }

    public function messages()
    {
        return [
            'amount.required' => 'Monto necesario',
            'amount.numeric' => 'Monto invalido',
            'bank.required' => 'Nombre de banco faltante',
            'bank.integer' => 'Banco id incorrecto',
            'modify_type.required' => 'Tipo de modificacion requerido',
            'modify_type.integer' => 'Tipo de modificacion incorrecto de pago',
            'modify_type.between' => 'Tipo de modificacion incorrecto  de pago',
        ];
    }
}
