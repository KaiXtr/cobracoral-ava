// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "@rails/actiontext"
import "trix"

import "controllers"
import "./context-menu"

function initHeader() {
    const header = document.getElementById('cobracoral-header');

    if (header) {
        document.addEventListener('scroll', (e) => {
            if (window.pageYOffset >= 0) {
                header.classList.add('header-compacto');
            } else if (header.classList.contains('header-compacto')) {
                header.classList.remove('header-compacto');
            }
        })
    
        let linkSair = document.getElementById('menu-perfil-sair-link');
        if (linkSair) {
            linkSair.addEventListener('mouseover', (e) => {
                let iconOpen = document.getElementById('menu-perfil-sair-open');
                let iconClose = document.getElementById('menu-perfil-sair-close');
                
                iconOpen.style.display = "inline-block";
                iconClose.style.display = "none";
                
            })
            linkSair.addEventListener('mouseleave', (e) => {
                let iconOpen = document.getElementById('menu-perfil-sair-open');
                let iconClose = document.getElementById('menu-perfil-sair-close');
                
                iconOpen.style.display = "none";
                iconClose.style.display = "inline-block";
            })
        }
    }
}

const header = document.getElementById('cobracoral-header');

if ((header)&&(document.referrer.includes('entrar'))) {
    header.style = "padding-top: 80vw";
    header.classList.add('header-animation');
}

window.addEventListener('turbo:load', initHeader);
