function updateLocalStorage() {

  var storage = {}, key,
      keys = Object.keys(localStorage);

  for(var i = 0; i < keys.length; i++) {
    key = keys[i];
    storage[key] = JSON.parse(localStorage[key]);
  }

  Shiny.onInputChange("localStorage", storage);

}

Shiny.addCustomMessageHandler("setLocalStorage", function(data) {
  var keys = Object.keys(data);
  for(var i = 0; i < keys.length; i++) {
    localStorage[keys[i]] = data[keys[i]];
  }
  updateLocalStorage();
});

$(document).ready(function() {
  if (typeof(Storage) !== "undefined") {

    var storedInputs = $(".shiny-local-storage")
      .find("[id]")
      .addBack("[id]");

    storedInputs.on("shiny:bound", function(ev) {

      var inputs,
          id = $(ev.target).attr("id");

      if(localStorage.inputs === undefined) {
        inputs = {};
      } else {
        inputs = JSON.parse(localStorage.inputs);
      }

      $(ev.target).addClass("shiny-stored-input");

      if(Object.keys(inputs).indexOf(id) > -1) {
        ev.binding.setValue(ev.target, inputs[id]);
        $(ev.target).trigger("change");
      }

      ev.binding.getValue = (
        function(old, old_binding) {
          function extendGetValue (el) {
            var x = old.bind(old_binding)(el),
                inputs;
            if($(el).hasClass('shiny-stored-input')) {
              if(localStorage.inputs === undefined) {
                inputs = {};
              } else {
                inputs = JSON.parse(localStorage.inputs);
              }
              inputs[$(el).attr("id")] = x;
              localStorage.inputs = JSON.stringify(inputs);
              updateLocalStorage();
            }
            return x;
          }
          return extendGetValue;
        }
      )(ev.binding.getValue, ev.binding);

//      ev.binding.getValue($(ev.target));

    });

    window.setTimeout(updateLocalStorage, 100);

    window.setTimeout(function() {
      Shiny.onInputChange = (
        function(old) {
          function extendInputChange (a, b) {
            old(a, b);
            console.log(a);
          }
          return extendInputChange;
        }
      )(Shiny.onInputChange);
    }, 100);

    $(window).bind('storage', function (e) {
      updateLocalStorage();
    });

  } else {
    console.log("No local storage found.");
  }
});
