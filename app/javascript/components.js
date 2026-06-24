function abrirElement(elementId) {
    let element = document.getElementById(elementId);
    if (element.style.visibility == 'visible') {
        element.style.visibility = 'hidden';
        element.style.opacity = '0%';
    } else {
        element.style.visibility = 'visible';
        element.style.opacity = '100%';
    }
}

function abrirBarraLateral() {
    abrirElement('barra-lateral');
}

function abrirMenuPerfil() {
    abrirElement('menu-perfil');
}

function abrirBarraPreferencias() {
  abrirElement('barra-lateral-preferencias');
}
