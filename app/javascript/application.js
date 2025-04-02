// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "trix"
import "@rails/actiontext"

function showContextMenu() {
    let cursor = event || window.event;
    let contextMenuComponent = document.getElementById('context-menu-component');

    if (contextMenuComponent.style.visibility == 'visible')
        contextMenuComponent.style['transition-duration'] = '.2s';

    contextMenuComponent.style.visibility = 'visible';
    contextMenuComponent.style.top = cursor.clientY + 'px';
    contextMenuComponent.style.left = cursor.clientX + 'px';

    let contextMenuOptions = document.getElementById('context-menu-options');
    contextMenuOptions.style.opacity = '100%';
}

function hideContextMenu() {
    let contextMenuComponent = document.getElementById('context-menu-component');
    contextMenuComponent.style.visibility = 'hidden';
    contextMenuComponent.style['transition-duration'] = '0s';

    let contextMenuOptions = document.getElementById('context-menu-options');
    contextMenuOptions.style.opacity = '0%';
}

const header = document.getElementById('cobracoral-header');
if (header && document.referrer.includes('entrar')) {
    header.style = "padding-top: 80vw";
    header.classList.add('header-animation');
}

if (document.addEventListener) {
    document.addEventListener('contextmenu', function(e) {
        showContextMenu();
        e.preventDefault();
    }, false);
    document.addEventListener('mousedown', function(e) {
        hideContextMenu();
    });
  } else {
    document.attachEvent('oncontextmenu', function() {
        showContextMenu();
        window.event.returnValue = false;
    });
    document.attachEvent('onmousedown', function(e) {
        hideContextMenu();
    });
  }