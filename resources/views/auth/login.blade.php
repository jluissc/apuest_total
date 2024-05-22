<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Suite Alvcom - Login</title>

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
                        <figure class="mb-4">
                            <iframe src="{{ Vite::image('logo/logo-v2.svg') }}" alt="ALVCOM" class="auth__logo">
                            </iframe>
                        </figure>
                        <p class="auth__description text-primario">Ingrese sus credenciales</p>
                    </header>
                    <form method="POST" action="{{ route('login') }}">
                        @csrf

                        <div class="form-auth__group">
                            <div class="form-auth__field">
                                <span class="form-auth__icon"> <i class="fa-solid fa-user"></i> </span>
                                <input type="text"
                                    class="form-auth__input form-auth__input--icon"
                                    placeholder="Usuario / número de documento"
                                    value="{{ old('email') }}" name="email" required/>
                            </div>
                        </div>

                        <div class="form-auth__group" x-data="{ isDisplayed: false }">
                            <div class="form-auth__field">
                                <div class="mb-1 relative">
                                    <span class="form-auth__icon"> <i class="fa-solid fa-lock"></i></span>
                                    <input name="password" class="form-auth__input form-auth__input--icon"
                                    placeholder="Contraseña" required
                                    x-bind:type="isDisplayed ? 'text' : 'password'"/>
                                    <span class="form-auth__icon form-auth__icon--right cursor-pointer" @click.prevent="isDisplayed = !isDisplayed">
                                        <i class="fa-solid" :class="isDisplayed ? 'fa-eye' : 'fa-eye-slash'"></i>
                                    </span>
                                </div>
                                <div class="text-end">
                                    <a href="/reset" class="border-b border-dashed duration-300 text-size-12 text-slate-600  hover:text-primario">
                                        ¿Olvidaste tu contraseña?
                                    </a>
                                </div>
                            </div>
                        </div>

                        @error('email')
                            <div class="pt-2">
                                <ul class="form-auth__errors">
                                    <li> Por favor verifique correctamente sus credenciales</li>
                                </ul>
                            </div>
                        @enderror

                        @error('noactivo')
                            <div class="pt-2">
                                <ul class="form-auth__errors">
                                    <li>Su cuenta esta bloqueado temporalmente, consulte con el área de RRHH</li>
                                </ul>
                            </div>
                        @enderror

                        <div class="form-auth__group pt-6">
                            <button type="submit" class="form-auth__submit">
                                Iniciar Sesión
                            </button>
                        </div>
                    </form>

                    <p class="auth__copyright">&copy; ALVCOM {{ date('Y') }} - Todos los derechos reservados.</p>
                </div>
            </div>
        </div>
    </div>

    @vite(['resources/js/app.js'])
</body>
</html>
