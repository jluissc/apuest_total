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
        {{--  <a href="{{ route('depositar.create') }}"
            class="inline-block bg-green-500 hover:bg-green-600 text-white font-bold py-2 px-4 rounded">Nuevo registro de
            depósito</a>  --}}

        <h1 class="text-center text-4xl font-bold text-gray-900 dark:text-white mb-8">
            Lista de clientes
        </h1>


        <div class="relative overflow-x-auto">
            <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
                <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                    <tr>
                        <th scope="col" class="px-6 py-3">
                            Cliente
                        </th>                        
                        <th scope="col" class="px-6 py-3">
                            Player ID
                        </th>
                        <th scope="col" class="px-6 py-3">
                            Num. Documento
                        </th>
                        <th scope="col" class="px-6 py-3">
                            Ver depositos
                        </th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($data as $client)
                        <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                            <td class="px-6 py-4">
                                {{ $client->name.' '.$client->last_pat.' '. $client->last_mat}}
                            </td>
                            
                            <td class="px-6 py-4">
                                {{ $client->player_id }}
                            </td>
                            <td class="px-6 py-4">
                                {{ $client->num_doc }}
                            </td>
                            <td class="px-6 py-4">
                                <a href="{{ route('cliente.show', ['cliente'=>$client->id]) }}" target="_blank" rel="noopener noreferrer">
                                    Historial
                                </a>
                            </td>
                        </tr>                        
                    @endforeach
                </tbody>
            </table>
        </div>

    </div>


</body>

</html>
