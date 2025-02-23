// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"

function checarCaps(event) {
    let campoCaps = document.getElementById("campo-caps");

    if (event.getModifierState("CapsLock"))
        campoCaps.style.visibility = "visible";  
    else
        campoCaps.style.visibility = "hidden"; 
}

addEventListener("keyup", function(event) { 
    checarCaps(event);
});
