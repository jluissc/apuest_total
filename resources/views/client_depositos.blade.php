<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de clientes</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-100 dark:bg-gray-900">
    <div class="container mx-auto p-4">

        <h1 class="text-center text-4xl font-bold text-gray-900 dark:text-white mb-8">
            Lista de depositos de  {{ $client->name }}
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
                            Ver doc
                        </th>
                        <th scope="col" class="px-6 py-3">
                            Atentido por 
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
                                <a href="{{ route('deposito.show', ['deposito'=>$pay->id]) }}" target="_blank" rel="noopener noreferrer">
                                    Ver Doc
                                </a>
                            </td>
                            <td class="px-6 py-4">
                                {{ $pay->names }}
                            </td>
                        </tr>                        
                    @endforeach
                </tbody>
            </table>
        </div>

    </div>


</body>

</html>
