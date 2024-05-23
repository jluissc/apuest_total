<!-- resources/views/layouts/app.blade.php -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>@yield('title', 'Mi Aplicación')</title>
    <!-- Agregar aquí tus estilos y scripts -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 text-gray-900">
    <nav class="bg-blue-600 p-4">
        <div class="container mx-auto flex space-x-4">
            <a href="{{ url('cliente') }}" class="text-white font-bold text-lg">Clientes</a>  ||
            <a href="{{ url('deposito') }}" class="text-white font-bold text-lg">Lista de pagos</a>  ||
            <a href="{{ url('pay_edition') }}" class="text-white font-bold text-lg">Lista de pagos modificados</a>  ||
            <a href="{{ url('deposito/create') }}" class="text-white font-bold text-lg">Ingresar un pago</a>  ||
            <a href="{{ url('dashboard') }}" class="text-white font-bold text-lg">Dashboard</a>  ||
        </div>
    </nav>
    

    <div class="container mx-auto mt-8">
        @yield('content')
    </div>

    <footer class="bg-blue-600 p-4 mt-8 text-white text-center">
        &copy; 2024 Mi Aplicación. Todos los derechos reservados.
    </footer>
</body>
</html>
