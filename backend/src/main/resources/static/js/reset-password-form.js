function getPathVariable() {
    const path = window.location.pathname;
    const segments = path.split('/');
    return segments[2];
}

window.onload = function() {
    const resetPasswordFormId = getPathVariable();
    if (resetPasswordFormId) {
        document.getElementById('reset_password_form_id').value = resetPasswordFormId;
    }
};

function resetPassword(event) {
    event.preventDefault();
    const formData = new FormData(document.getElementById('reset_password_form'));

    fetch('/reset-password/reset', {
        method: 'POST',
        body: formData
    })
        .then(response => {
            if (!response.ok) {
                return response.text().then(text => {
                    throw new Error(text);
                });
            }
            return response.text();
        })
        .then(message => {
            alert(message);
            document.getElementById('reset_password_form').reset();
        })
        .catch(error => {
            alert(error.message);
        });
}
