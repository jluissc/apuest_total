@extends('app')

@section('title', 'Inicio')

@section('content')
    <div class="container mx-auto p-4">
        <h1 class="text-center text-4xl font-bold text-gray-900 dark:text-white mb-8">
            Dashboard
        </h1>
        <p>Canal de atencion por recarga</p>
        @foreach ($channelXPays as $channelXPay)
            <li>{{ $channelXPay->channel }} -- {{ $channelXPay->quant_pays }}</li>
        @endforeach


        <p>Tipo de banco por recarga</p>
        @foreach ($bankXPays as $bankXPay)
            <li>{{ $bankXPay->bank }} -- {{ $bankXPay->quant_pays }}</li>
        @endforeach
    </div>
@endsection
