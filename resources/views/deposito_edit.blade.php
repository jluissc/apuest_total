<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro Depósito Apuesta Total</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>

<body class="bg-gray-100 dark:bg-gray-900">
    <div class="container mx-auto p-4">
        <h1 class="text-center text-4xl font-bold text-gray-900 dark:text-white mb-8">
            Registro Depósito Apuesta Total
        </h1>
        <form class="max-w-md mx-auto bg-white p-6 rounded-lg shadow-md dark:bg-gray-800" method="POST" id="registroForm">
            @csrf
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-5">
                <div>
                    <label for="amount" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Monto depositado</label>
                    <input type="number" id="amount" name="amount" value="{{ $deposito->amount }}"
                        class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                        placeholder="Monto depositado" required />
                </div>
                <div>
                    <label for="bank" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Nombre del banco</label>
                    <input type="text" id="bank" name="bank" value="{{ $deposito->bank }}"
                        class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                        placeholder="Nombre del banco" required />
                </div>
                <div>
                    <label for="day" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Fecha de pago</label>
                    <input type="date" id="day" name="day" value="{{ $deposito->day }}"
                        class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                        required />
                </div>
                <div>
                    <label for="hour" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Hora de pago</label>
                    <input type="time" id="hour" name="hour" value="{{ $deposito->hour }}"
                        class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                        required />
                </div>
                <div>
                   {{ $deposito->url_doc }}
                </div>
                <div>
                    {{ $deposito->client_id }}
                    <label for="client" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Cliente</label>
                    <select id="client" name="client" 
                        class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                        required>
                        <option value="" disabled selected>Seleccione un cliente</option>
                        <option value="1">Cliente 1</option>
                        <option value="2">Cliente 2</option>
                        <option value="3">Cliente 3</option>
                        <!-- Agrega más opciones según sea necesario -->
                    </select>
                </div>
                <div>
                    {{ $deposito->channel_attention_id }}
                    <label for="canal" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Tipo de canal de atención</label>
                    <select id="channel" name="channel"
                        class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                        required>
                        <option value="" disabled selected>Seleccione un canal</option>
                        <option value="1">Whatsapp</option>
                        <option value="2">Messenger</option>
                        <option value="3">Instagram</option>
                        <!-- Agrega más opciones según sea necesario -->
                    </select>
                </div>
            </div>
            <button type="submit"
                class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm w-full sm:w-auto px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">Submit</button>
        </form>
    </div>
    <script>
        document.getElementById('registroForm').addEventListener('submit', async function (event) {
            event.preventDefault();

            const form = event.target;
            const formData = new FormData(form);

            try {
                const response = await fetch('/deposito', {
                    method: 'POST',
                    body: formData
                });
                
                resp = await response.json()
                if(resp.status){
                    alert('data: '+resp.message);
                    console.log(resp.data);
                    window.location.href = '/deposito';
                }else{
                    alert('error: '+resp.message);
                }
                
            } catch (error) {
                alert('Error al enviar el formulario.');
                console.error('Error: ', error);
            }
        });
    </script>

</body>

</html>
