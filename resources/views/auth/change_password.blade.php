@extends('layouts.app', ['title' => 'Cambio Contraseña'])
{{--
@section('header')
    <header class="mb-4">
        <h2 class="text-title-md2 text-primario font-bold dark:text-white">
            @role('jef_tic|dev_tic')
                BIENVENIDO EQUIPO SISTEMAS
            @endrole
            @canany('dotacion_rrhh')
                BIENVENIDO EQUIPO RECURSOS HUMANOS
            @endcanany
        </h2>
    </header>
@endsection --}}

@section('content')
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-header">{{ __('Reset Password') }}</div>

                <div class="card-body">
                    <form method="POST" action="{{ route('fetch.cambioPassword') }}" id="formCambioPassword">
                        @csrf
 
                        <div class="row mb-3">
                            <label for="email" class="col-md-4 col-form-label text-md-end">{{ __('Email Address') }}</label>

                            <div class="col-md-6">
                                <input id="email" type="text" class="form-control @error('email') is-invalid @enderror" 
                                    name="email" value="{{ $email ?? old('email') }}" required autofocus>

                                @error('email')
                                    <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label for="password" class="col-md-4 col-form-label text-md-end">{{ __('Password') }}</label>

                            <div class="col-md-6">
                                <input id="password" type="password" class="form-control @error('password') is-invalid @enderror" name="password" required autocomplete="new-password">

                                @error('password')
                                    <span class="invalid-feedback" role="alert">
                                        <strong>{{ $message }}</strong>
                                    </span>
                                @enderror
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label for="password-confirm" class="col-md-4 col-form-label text-md-end">{{ __('Confirm Password') }}</label>

                            <div class="col-md-6">
                                <input id="password-confirm" type="password" class="form-control" name="password_confirmation" required autocomplete="new-password">
                            </div>
                        </div>

                        <div class="row mb-0">
                            <div class="col-md-6 offset-md-4">
                                <button type="submit" class="btn btn-primary">
                                    {{ __('Reset Password') }}
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

@push('js')
    <script>
        const btn_form = document.getElementById('formCambioPassword');

        btn_form.addEventListener('submit', (e) => {
            e.preventDefault();
            console.log('clickk');
            // Obtén los datos del formulario
            const formData = new FormData(btn_form);

            // Realiza una solicitud POST a la URL './change_password'
            fetch('./change_password', {
                    method: 'POST',
                    body: formData, // Envía los datos del formulario en el cuerpo de la solicitud
                })
                .then(r => r.json())
                .then(r => {
                    console.log(r);
                })
                .catch(e => console.log(e))
        })
    </script>
@endpush
@endsection