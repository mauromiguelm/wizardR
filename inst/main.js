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

    return wizard;
  },

  getValue: function(el) {
    // get value from method to server if necessary
    cur_step = $(el).attr("data-active-step");

    if (!cur_step) {
    return "default";
    }
    return cur_step;
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