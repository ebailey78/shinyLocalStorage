function updateLocalStorage() {
  Shiny.onInputChange("localStorage", localStorage);
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
    window.setTimeout(updateLocalStorage, 100);
    $(window).bind('storage', function (e) {
      updateLocalStorage();
    });
  } else {
    console.log("No local storage found.");
  }
});
