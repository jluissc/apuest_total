
@extends('app')

@section('title', 'Inicio')

@section('content')

    <div class="container mx-auto p-4">
        <h1 class="text-center text-4xl font-bold text-gray-900 dark:text-white mb-8">
            Lista de depositos modificados
        </h1>


        <div class="relative overflow-x-auto">
            <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
                <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                    <tr>
                        <th scope="col" class="px-6 py-3">
                            Cliente
                        </th>
                        <th scope="col" class="px-6 py-3">
                            Monto
                        </th>
                        <th scope="col" class="px-6 py-3">
                            Banco
                        </th>
                        <th scope="col" class="px-6 py-3">
                            Dia
                        </th>
                        <th scope="col" class="px-6 py-3">
                            Hora
                        </th>
                        <th scope="col" class="px-6 py-3">
                            Canal de atención
                        </th>
                        <th scope="col" class="px-6 py-3">
                        Fecha Modificado
                        </th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($data as $pay)
                        <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                            <td class="px-6 py-4">
                                {{ $pay->name.' '.$pay->last_pat.' '. $pay->last_mat}}                                
                            </td>
                            <th scope="row"
                                class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                S/. {{ $pay->amount }}
                            </th>
                            <th scope="row"
                                class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                                {{ $pay->bank }}
                            </th>
                            <td class="px-6 py-4">
                                {{ $pay->day }}
                            </td>
                            <td class="px-6 py-4">
                                {{ $pay->hour }}
                            </td>
                            <td class="px-6 py-4">
                                {{ $pay->channel }}
                            </td>
                            <td class="px-6 py-4">
                                {{ $pay->created_at }}
                            </td>
                        </tr>                        
                    @endforeach
                </tbody>
            </table>
        </div>

    </div>
@endsection