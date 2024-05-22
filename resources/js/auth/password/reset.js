/* ================================================================================
 * Auth: Reset
 * ===============================================================================*/

function validateEmail(email) {
    const validEmailRegex = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;

    if (email.match(validEmailRegex)) {
        return true;
    } else {
        return false;
    }
}

function initAuthResetPassword() {
    const formResetPassword = document.getElementById('formResetPassword');

    formResetPassword.addEventListener('submit', (e) => {
        e.preventDefault();

        // validate email
        const email = formResetPassword.querySelector('input[name="email"]').value;

        if (!validateEmail(email)) {
            Utility.showNotification('error', 'Por favor coloque un email válido');
            return;
        }

        // notify the user
        Utility.showNotification('reset', 'Generando link cambio de contraseña. Por favor espere...', 5000);

        // get data from form
        const formData = new FormData(formResetPassword);

        // send data from form to server
        fetch(formResetPassword.action, {
            method: formResetPassword.method,
            body: formData,
        })
        .then(response => response.json())
        .then(response => {
            // hide notification
            Utility.dismissAllNotifications();

            // error response
            if (!response.estado) {
                let message = '';

                if (response.mensaje) {
                    message += response.mensaje;
                }

                if (response.error) {
                    message += '<ul class="list-disc mx-auto pl-4 text-sm w-fit">';
                    for (let errorList in response.error) {
                        for (let error of response.error[errorList]) {
                            message += `<li>${error}</li>`;
                        }
                    }
                    message += '</ul>';
                }

                Swal.fire({
                    title: "Ops! tenemos algunos inconvenientes",
                    html: message,
                    icon: "error"
                });
            }
            // success response
            else {
                Swal.fire({
                    title: "Éxito!",
                    html: `<p class="text-sm">El link de restablecimiento de contraseña ha sido generado. <b class="block">Por favor revise su bandeja de entrada o spam. </b> Recuerde que este proceso puede demorar unos minutos. </p>`,
                    icon: "success"
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.replace('./login');
                    }
                });
            }
        })
        .catch(e => console.log(e))
    });
}

/* ================================================================================
 * Load DOM
 * ===============================================================================*/

document.addEventListener("DOMContentLoaded", function(){
    initAuthResetPassword();
});
