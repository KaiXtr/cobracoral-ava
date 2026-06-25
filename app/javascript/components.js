function abrirElement(elementId, display) {
    let element = document.getElementById(elementId);
    if (element.style.visibility == 'visible') {
        element.style.visibility = 'hidden';
        element.style.opacity = '0%';

        if (display) {
            element.style.display = 'none';
        }
    } else {
        element.style.visibility = 'visible';
        element.style.opacity = '100%';

        if (display) {
            element.style.display = 'block';
        }
    }
}

function abrirBarraLateral() {
    abrirElement('barra-lateral', false);
}

function abrirMenuPerfil() {
    abrirElement('menu-perfil', false);
}

function abrirBarraPreferencias() {
  abrirElement('barra-lateral-preferencias', false);
}

function abrirDadosDisciplina() {
  abrirElement('dados-disciplina-conteiner', true);
}
