// create a binding object
var wizard = new Shiny.InputBinding();

$.extend(wizard, {

  find: function(scope) {
    console.log("logging score");
    console.log(scope);
     return $(scope).find(".wizard");
  },

  initialize: function(el){
    
    let args = $(el).data("configuration");

    const wizard = new Wizard(args);

    console.log("initializing wizard")

    console.log(wizard)

    wizard.init();

    console.log("wizard initialized")
    console.log(wizard)

    // expose wizard.lock function
    this.lock = function() {
      wizard.lock();
    }

    this.unlock = function() {
      wizard.unlock();
    }

    return wizard;
  },

  getValue: function(el) {
    // get value from method to server
  },

  receiveMessage: function(el, value) {
    this.setValue(el, value);
  },
  
  setValue: function(el, value) {
    
    if (value === "lock") {
      this.lock();
    }
    
    if (value === "unlock") {
      this.unlock();
    }
  },

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
        
        $(el).attr("data-active-step", next);

        // Inform Shiny about visibility changes
        $(steps[current]).trigger("hidden");
        $(steps[next]).trigger("shown");

        callback(false);
      });
    });

    // Going backward
    ["wz.btn.prev", "wz.nav.backward"].forEach(function(evt) {
      el.addEventListener(evt, function(e) {
        var steps = $(el).find(".wizard-content .wizard-step");
        var nSteps = steps.length;
        var current = steps.filter(".active").data("step");
        var next = (current === nSteps) ? 0 : (current + 1);
        $(el).attr("data-active-step", parseInt(current) - 1);

        $(steps[current]).trigger("hidden");
        $(steps[next]).trigger("shown");

        callback(false);
      });
    });
  },

  unsubscribe: function(el) {
    $(el).off("wz.update");
  },

});

Shiny.inputBindings.register(wizard, "shiny.wizardBinding");