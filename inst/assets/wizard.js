// create a binding object
var binding = new Shiny.InputBinding();

$.extend(binding, {

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
    
  }
});

Shiny.inputBindings.register(binding);