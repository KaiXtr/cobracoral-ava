// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "trix"
import "@rails/actiontext"

import "./context-menu"

const header = document.getElementById('cobracoral-header');

if (header && document.referrer.includes('entrar')) {
    header.style = "padding-top: 80vw";
    header.classList.add('header-animation');
}
