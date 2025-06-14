// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "@rails/actiontext"
import "trix"

import "controllers"
import "./context-menu"
import "./solicitacoes"

function openCloseOption (elementName) {
    let link = document.getElementById(elementName + '-link');
    if (link) {
        link.addEventListener('mouseover', (e) => {
            let iconOpen = document.getElementById(elementName + '-open');
            let iconClose = document.getElementById(elementName + '-close');
            
            iconOpen.style.display = "inline-block";
            iconClose.style.display = "none";
            
        })
        link.addEventListener('mouseleave', (e) => {
            let iconOpen = document.getElementById(elementName + '-open');
            let iconClose = document.getElementById(elementName + '-close');
            
            iconOpen.style.display = "none";
            iconClose.style.display = "inline-block";
        })
    }
}

function initHeader() {
    const header = document.getElementById('cobracoral-header');

    const VLibrasWidget = new window.VLibras.Widget('https://vlibras.gov.br/app');

    if (header) {
        document.addEventListener('scroll', (e) => {
            if (window.pageYOffset >= 0) {
                header.classList.add('header-compacto');
            } else if (header.classList.contains('header-compacto')) {
                header.classList.remove('header-compacto');
            }
        })
        
        openCloseOption('menu-perfil-email');
        openCloseOption('menu-perfil-sair');
    }

	let elementMensagemFormFocus = document.getElementById('mensagem-input-form-textarea');
    if (elementMensagemFormFocus)
        elementMensagemFormFocus.focus();
}

const header = document.getElementById('cobracoral-header');

if ((header)&&(document.referrer.includes('entrar'))) {
    header.style = "padding-top: 80vw";
    header.classList.add('header-animation');
}

window.addEventListener('turbo:load', initHeader);
