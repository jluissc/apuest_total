<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Suite Alvcom - Cambiar Contraseña</title>

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
                            <img src="{{ Vite::image('logo/logo-v2.svg') }}" alt="ALVCOM" class="auth__logo" />
                        </figure>
                        <p class="auth__description text-primario">Introduzca su nueva contraseña</p>
                    </header>

                    <form method="POST" action="{{ route('post.recovePassword') }}" x-data="{password1: '', password2: ''}" id="formChangePassword">
                        @csrf
                        <input type="hidden" name="token" value="{{ $token }}">
                        <input type="hidden" name="email" value="{{ $email }}">

                        <div class="form-auth__group" x-data="{ isDisplayed: false }">
                            <div class="form-auth__field">
                                <div class="form-auth__icon">
                                    <span class="block w-[18px]">
                                        <svg class="fill-primario" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><title>lock</title><path d="M12,17A2,2 0 0,0 14,15C14,13.89 13.1,13 12,13A2,2 0 0,0 10,15A2,2 0 0,0 12,17M18,8A2,2 0 0,1 20,10V20A2,2 0 0,1 18,22H6A2,2 0 0,1 4,20V10C4,8.89 4.9,8 6,8H7V6A5,5 0 0,1 12,1A5,5 0 0,1 17,6V8H18M12,3A3,3 0 0,0 9,6V8H15V6A3,3 0 0,0 12,3Z" /></svg>
                                    </span>
                                </div>
                                <input type="password" id="password1" name="password" x-model="password1" class="form-auth__input form-auth__input--icon" placeholder="Nueva contraseña" required x-bind:type="isDisplayed ? 'text' : 'password'" />
                                <span class="form-auth__icon form-auth__icon--right cursor-pointer" @click.prevent="isDisplayed = !isDisplayed">
                                    <i class="fa-solid" :class="isDisplayed ? 'fa-eye' : 'fa-eye-slash'"></i>
                                </span>
                            </div>
                        </div>

                        <div class="form-auth__group" x-data="{ isDisplayed: false }">
                            <div class="form-auth__field">
                                <div class="mb-1 relative">
                                    <div class="form-auth__icon">
                                        <span class="block w-[18px]">
                                            <svg class="fill-primario" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><title>lock-check</title><path d="M19 13C19.34 13 19.67 13.04 20 13.09V10C20 8.9 19.11 8 18 8H17V6C17 3.24 14.76 1 12 1S7 3.24 7 6V8H6C4.9 8 4 8.89 4 10V20C4 21.11 4.89 22 6 22H13.81C13.3 21.12 13 20.1 13 19C13 15.69 15.69 13 19 13M9 6C9 4.34 10.34 3 12 3S15 4.34 15 6V8H9V6M12 17C10.9 17 10 16.11 10 15S10.9 13 12 13C13.1 13 14 13.89 14 15C14 16.11 13.11 17 12 17M22.5 17.25L17.75 22L15 19L16.16 17.84L17.75 19.43L21.34 15.84L22.5 17.25Z" /></svg>
                                        </span>
                                    </div>
                                    <input type="password" id="password2" name="password_confirmation" x-model="password2" class="form-auth__input form-auth__input--icon" placeholder="Confirmar nueva contraseña" required x-bind:class="{'border-red-500': password1 !== password2}" x-bind:type="isDisplayed ? 'text' : 'password'" />
                                    <span class="form-auth__icon form-auth__icon--right cursor-pointer" @click.prevent="isDisplayed = !isDisplayed">
                                        <i class="fa-solid" :class="isDisplayed ? 'fa-eye' : 'fa-eye-slash'"></i>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <p class="text-center text-xs text-red-600" x-show="password1 !== password2">Las contraseñas no coinciden.</p>

                        <div class="form-auth__group pt-6">
                            <button type="submit" class="form-auth__submit disabled:opacity-75" x-bind:disabled="password1 !== password2"> Resetar contraseña </button>
                        </div>

                        <div id="error_messages" class="text-center text-xs text-red-600"></div>
                    </form>

                    <p class="auth__copyright">&copy; ALVCOM {{ date('Y') }} - Todos los derechos reservados.</p>
                </div>
            </div>
        </div>
    </div>
    <script>
        const urlLogin = @js(route('login'));
    </script>
    @vite(['resources/js/app.js'])
    @vite(['resources/js/auth/password/change.js'])
</body>
</html>
