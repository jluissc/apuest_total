<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Suite Alvcom - Reseteo Contraseña</title>

    <link rel="icon" type="image/png" href="{{ Vite::image('favicon.png') }}" />
    @vite(['resources/css/app.css'])
</head>
<body>

    <div class="auth-container">
        <div class="auth-wrapper flex flex-wrap">
            <div class="hidden lg:block lg:w-5/12">
                <img src="{{ Vite::image('auth/bgimage.jpg') }}" alt="main" class="auth__bgimage" />
            </div>

            <div class="lg:w-7/12">
                <div class="auth-content">
                    <header class="mb-6 flex flex-col items-center">
                        <figure class="mb-7">
                            <img src="{{ Vite::image('logo/logo-v2.svg') }}" alt="ALVCOM" class="auth__logo" />
                        </figure>
                        <h2 class="text-xl font-bold text-primario">¿Olvidaste tu contraseña?</h2>
                        <p class="auth__description text-center text-primario">
                            Introduzca su dirección de correo electrónico para restablecer su cuenta
                        </p>
                    </header>

                    <form method="POST" action="{{ route('post.sendResetLinkEmail') }}" id="formResetPassword">
                        @csrf

                        <div class="form-auth__group">
                            <div class="form-auth__field">
                                <span class="form-auth__icon"> <i class="fa-solid fa-envelope"></i> </span>
                                <input type="email"
                                    class="form-auth__input form-auth__input--icon"
                                    placeholder="Correo electrónico"
                                    value="{{ old('email') }}" name="email" required/>
                            </div>
                        </div>

                        <div class="form-auth__group pt-6">
                            <div class="flex flex-wrap gap-5 items-center justify-center lg:gap-10">
                                <a href="{{ route('login') }}" class="text-primario text-xs">
                                    <i class="fa-solid fa-chevron-left"></i>
                                    Volver a inicio de sesión
                                </a>
                                <button type="submit" class="bg-primario py-3 px-5 rounded-md text-xs text-white" data-ripplet="">
                                    Enviar link de reseteo
                                </button>
                            </div>
                        </div>
                    </form>

                    <p class="auth__copyright">&copy; ALVCOM {{ date('Y') }} - Todos los derechos reservados.</p>
                </div>
            </div>
        </div>
    </div>
    @vite(['resources/js/app.js'])
    @vite(['resources/js/auth/password/reset.js'])
</body>
</html>
