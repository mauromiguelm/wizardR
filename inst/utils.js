$(document).on('click', '.wizard-btn.btn.finish', function () {
    
    //listen to close modal, best is to move this inputBinding
    var modalId = $(this).closest('.modal').attr('id');
    
    var modal = bootstrap.Modal.getOrCreateInstance(
        document.getElementById(modalId),
        {},
    );

    modal.hide();

    //send message to shiny server, best is to move this to getValue
    modalId = modalId.replace("wizard-modal-", "");
    Shiny.setInputValue(modalId, "wizard_finished", {priority: "event"});
    
});


Shiny.addCustomMessageHandler('wizard-modal', (msg) => {
    var modal = bootstrap.Modal.getOrCreateInstance(
      document.getElementById(msg.id),
      {},
    );

    modal.show();

  });


Shiny.addCustomMessageHandler('wizard-modal-', (msg) => {
  var modal = bootstrap.Modal.getOrCreateInstance(
    document.getElementById(msg.id),
    {},
  );

  modal.show();

});