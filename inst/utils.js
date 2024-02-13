

// close modalDialog if button with class wizard-btn btn finish is clicked
$(document).on('click', '.wizard-btn.btn.finish', function () {
    $('.modalDialog').hide();
});