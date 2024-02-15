

// close modalDialog if button with class wizard-btn btn finish is clicked
$(document).on('click', '.wizard-btn.btn.finish', function () {
    console.log("clicked finish button")
    var modal = bootstrap.Modal.getOrCreateInstance(
        document.getElementById("my_modal"),
        {},
    );
    modal.hide();
});