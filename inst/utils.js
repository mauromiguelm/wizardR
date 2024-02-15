$(document).on('click', '.wizard-btn.btn.finish', function () {
    
    // get the modal id from the button that was clicked
    var modalId = $(this).closest('.modal').attr('id');
    
    var modal = bootstrap.Modal.getOrCreateInstance(
        document.getElementById(modalId),
        {},
    );

    modal.hide();
});