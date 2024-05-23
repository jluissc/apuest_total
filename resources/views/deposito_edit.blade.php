@extends('app')

@section('title', 'Inicio')

@section('content')
    <div class="container mx-auto p-4">
        <h1 class="text-center text-4xl font-bold text-gray-900 dark:text-white mb-8">
            Editar pago  de {{ $cliente->name }} -- DNI :{{ $cliente->num_doc }}
        </h1>
        <form class="max-w-md mx-auto bg-white p-6 rounded-lg shadow-md dark:bg-gray-800" method="POST" id="editForm">
            @csrf
            @method('PUT')
            <input type="hidden" name="pay_id" value="{{ $deposito->id }}">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-5">
                <div>
                    <label for="amount" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Monto depositado</label>
                    <input type="number" id="amount" name="amount" value="{{ $deposito->amount }}"
                        class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                        placeholder="Monto depositado" required />
                </div>
                <div>
                    <label for="bank" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Nombre del banco</label>
                    <select id="bank" name="bank"
                        class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                        required>
                        @foreach ($banks as $bankL)
                            <option value="{{ $bankL->id }}" @if ($bankL->id == $deposito->bank_id ) selected @endif>{{ $bankL->bank }}</option>
                        @endforeach
                    </select>
                </div>
                <div>
                    <label for="day" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Fecha de pago</label>
                    <input type="date" id="day" name="day" value="{{ $deposito->day }}" disabled
                        class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                        required />
                </div>
                <div>
                    <label for="hour" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Hora de pago</label>
                    <input type="time" id="hour" name="hour" value="{{ $deposito->hour }}" disabled
                        class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                        required />
                </div>
                <div>
                    <label for="canal" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Tipo de canal de atención</label>
                    <select id="channel" name="channel" disabled
                        class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                        required>
                        @foreach ($channelAttention as $channel)
                            <option value="{{ $channel->id }}" @if ($channel->id == $deposito->channel_attention_id ) selected @endif>{{ $channel->channel }}</option>
                        @endforeach
                    </select>
                </div>
                <div>
                    <label for="modify_type" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Tipo de canal de atención</label>
                    <select id="modify_type" name="modify_type"
                        class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                        required>
                            <option value="0"> --Escoge motivo de edición--</option>
                        @foreach ($modifityType as $modify)
                            <option value="{{ $modify->id }}" >{{ $modify->modification_type }}</option>
                        @endforeach
                    </select>
                </div>
                <div>
                    <img src="{{ asset('storage/deposito/'.$deposito->url_img) }}" alt="">
                </div>

            </div>
            <div>
                
            </div>
            <button type="submit"
                class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm w-full sm:w-auto px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">Enviar</button>
        </form>
    </div>
    <script>
        document.getElementById('editForm').addEventListener('submit', async function (event) {
            event.preventDefault();
        
            const form = event.target;
            const formData = new FormData(form);
        
            // Añadir campo oculto _method con el valor PUT
            formData.append('_method', 'PUT');
        
            try {
                const response = await fetch(`/deposito/${formData.get('pay_id')}`, {
                    method: 'POST', // Usar POST para simular PUT
                    headers: {
                        'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
                    },
                    body: formData
                });
        
                const resp = await response.json();
                console.log(resp);
        
                if (resp.status) {
                    //alert('Data: ' + resp.message);
                    window.location.href = '/deposito';
                } else {
                    
                    console.log(resp.errors)
                    let err = '';
                    let i = 0;
                    for (let key in resp.errors) {
                        if (resp.errors.hasOwnProperty(key)) {
                            const errorArray = resp.errors[key]; // Acceder al array de mensajes de error
                            errorArray.forEach(e => { // Iterar sobre el array de mensajes de error
                                err += e; // Agregar cada mensaje de error al string 'err'
                            });
                            console.log(err);
                        }
                    }
                    alert('error: ' + err);
                }
            } catch (error) {
                alert('Error al enviar el formulario.');
                console.error('Error: ', error);
            }
        });
        
    </script>
@endsection
