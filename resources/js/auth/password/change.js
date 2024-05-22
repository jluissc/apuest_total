/* ================================================================================
 * Auth: Confirm
 * ===============================================================================*/

function initAuthConfirmNewPassword() {
    const formChangePassword = document.getElementById('formChangePassword');

    formChangePassword.addEventListener('submit', (e) => {
        e.preventDefault();

        // notify the user
        Utility.showNotification('reset', 'Procesando cambio de contraseña. Por favor espere...', 5000);

        // get data from form
        const formData = new FormData(formChangePassword);

        // send data from form to server
        fetch(formChangePassword.action, {
            method: formChangePassword.method,
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
                    message += '<ul class="list-disc list-inside mx-auto pl-4 text-sm w-fit">';
                    for (let errorList in response.error) {
                        for (let error of response.error[errorList][0]) {
                            message += `<li>${error}</li>`;
                        }
                    }
                    message += '</ul>';
                }

                if (document.getElementById('error_messages')) {
                    const errorMessages = document.getElementById('error_messages');
                    errorMessages.innerHTML = message;
                }
            }
            // success response
            else {
                Swal.fire({
                    title: "Éxito!",
                    html: `<p class="text-sm">Su contraseña ha sido restablecida</p>`,
                    icon: "success"
                }).then((result) => {
                    if (result.isConfirmed) {
                        
                        window.location.replace(urlLogin);
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
    initAuthConfirmNewPassword();
});
