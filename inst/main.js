// create a binding object
var wizard = new Shiny.InputBinding();

$.extend(wizard, {

  find: function(scope) {
     return $(scope).find(".wizard");
  },

  initialize: function(el){
    
    let args = $(el).data("configuration");

    const wizard = new Wizard(args);

    wizard.init();

    // expose wizard.lock function
    this.lock = function() {
      wizard.lock();
    }

    this.unlock = function() {
      wizard.unlock();
    }

    if (args.lock_start) {
      wizard.lock();
    }

    this.current_step = function() {
      return wizard.current_step();
    }

    this.lock = function() {
      wizard.lock();
    }

    this.reset = function() {
      wizard.reset();
    }
    

    return wizard;
  },

  getValue: function(el) {
    cur_step = $(el).attr("data-title");
  
    return cur_step;
  },

  receiveMessage: function(el, msg) {
    console.log("received message", msg)

    if (msg.type === "lock") {
      this.lock();
    } else if (msg.type === "unlock") {
      this.unlock();
    } else if (msg === "reset") {
      console.log("resetting wizard");
      this.reset();
    }
    //  else if (msg.type === "show") {
    //   var modal = bootstrap.Modal.getOrCreateInstance(
    //     document.getElementById('wizard-modal-' + el.id), {}
    //   );
    //   modal.show();
    // }
    
  },
  
  // TODO: implement update_wizard_step()
  setValue: function(el, value) {},

  subscribe: function(el, callback) {

    // Going forward
    ["wz.btn.next", "wz.nav.forward"].forEach(function(evt) {
      el.addEventListener(evt, function(e) {
        // These events fire **before** the DOM is actually updated, so
        // unfortunately we need to manually find the current step, and store it
        // in the DOM, so that we can retrieve it later (in getValue())
        var steps = $(el).find(".wizard-content .wizard-step");
        var nSteps = steps.length;
        var current = parseInt(steps.filter(".active").data("step"));
        var next = (current === nSteps) ? 0 : (current + 1);

        $(el).attr("data-active-step", parseInt(next));

        // Inform Shiny about visibility changes
        $(steps[current]).trigger("hidden");
        $(steps[next]).trigger("shown");


        var title = $(steps[next]).data("title");

        title = title || null;

        if ( title === null) {
          title = "Step " + $(steps[next]).data("step");
        }

        $(el).attr("data-title", title);

        callback(false);
      });
    });

    // Going backward
    ["wz.btn.prev", "wz.nav.backward"].forEach(function(evt) {
      el.addEventListener(evt, function(e) {
        var steps = $(el).find(".wizard-content .wizard-step");
        var nSteps = steps.length;
        var current = steps.filter(".active").data("step");
        var next = (current === nSteps) ? current : (current - 1);
        $(el).attr("data-active-step", parseInt(next));
        

        $(steps[current]).trigger("hidden");
        $(steps[next]).trigger("shown");
        

        // get data-title for next step
        var title = $(steps[next]).data("title");

        // if title is undefined, set it to "Step n"
        title = title || null;
        if (title === null) {
          title = "Step " + $(steps[next]).data("step");
        }

        $(el).attr("data-title", title);


        callback(false);
      });
    });

    // add event listener for wz.end
    el.addEventListener("wz.end", function(e) {
      callback(false);
    });
  },

  unsubscribe: function(el) {
    $(el).off("wz.update");
  },

});

Shiny.inputBindings.register(wizard, "shiny.wizardBinding");