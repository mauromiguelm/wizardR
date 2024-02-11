// create a binding object
var wizard = new Shiny.InputBinding();

$.extend(wizard, {

  find: function(scope) {
     return $(scope).find(".wizard");
  },

  initialize: function(el){
    let wz_class = ".wizard";
    let wz_ori = $(el).data("orientation");
    let wz_nav_style = $(el).data("style"); 
    let buttons = $(el).data("show-buttons");
    
    let args = {
      wz_class: wz_class,
      wz_nav_style: wz_nav_style, // dots, tabs, progress
      wz_ori: wz_ori, // horizontal, vertical
      buttons: buttons,
      navigation: "all" // buttons, nav, all
    }
    
    const wizard = new Wizard(args);

    wizard.init();

    // TODO: populate active-step to get the right active step on load (better to do this in R)?
    return wizard;
  },

  getValue: function(el) {
    // get value from method to server
  },

  setValue: function(el, value) {
    // TODO: for this to actually work, I think we'd need to include all the
    // wizard's configuration. This would be a lot better/easier if wizardJS
    // offered a method specifically for updating the current step (instead of
    // this hacky way of doing it via re-initialization) 
    //
    //var w = this.initialize(el); 
    //w.update({"current_step": value});
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

  receiveMessage: function(el, data) {
    // update method from the server
  },


});

Shiny.inputBindings.register(wizard, "shiny.wizardBinding");