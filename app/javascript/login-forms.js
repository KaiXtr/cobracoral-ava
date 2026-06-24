const isChrome = !!window.chrome && (!!window.chrome.webstore || !!window.chrome.runtime);

const isOpera = (!!window.opr && !!opr.addons) || !!window.opera || navigator.userAgent.indexOf(' OPR/') >= 0;

const isFirefox = typeof InstallTrigger !== 'undefined';

const isSafari = /constructor/i.test(window.HTMLElement) || (function (p) { return p.toString() === "[object SafariRemoteNotification]"; })(!window['safari'] || (typeof safari !== 'undefined' && window['safari'].pushNotification));

const isIE = /*@cc_on!@*/false || !!document.documentMode;

const isEdge = !isIE && !!window.StyleMedia;

function submitForm() {
    let form = document.getElementById('login-form');
    form.submit();
}

function triggerLoginSubmit() {
    let el = document.getElementById('login-form-container')
    el.classList.remove('form-login-submit-in');
    el.classList.add('form-login-submit-out');

    let deviceInput = document.getElementById('input-device');
    if (deviceInput)
        deviceInput.value = "Notebook"
    
    let SOInput = document.getElementById('input-so');
    if (SOInput)
        SOInput.value = window.navigator.oscpu;

    let browserAtual;
    if (isChrome)	{ browserAtual = 'Chrome'; }
    if (isOpera) 	{ browserAtual = 'Opera'; }
    if (isFirefox)	{ browserAtual = 'Firefox'; }
    if (isSafari)	{ browserAtual = 'Safari'; }
    if (isEdge)		{ browserAtual = 'Edge'; }

    let browserInput = document.getElementById('input-browser');
    if (browserInput)
        browserInput.value = browserAtual;

    setTimeout(submitForm, 1500);
}

function checarCaps(event) {
    let campoCaps = document.getElementById("campo-caps");

    if (campoCaps) {
        if (event.getModifierState("CapsLock"))
            campoCaps.style.visibility = "visible";  
        else
            campoCaps.style.visibility = "hidden";
    }
}

function checarSenha(event) {
    let campoSenha = document.getElementById("campo-senha");
    let campoSenhaErros = document.getElementById("campo-senha-erros");

    if (campoSenha && campoSenha.value && campoSenhaErros) {
        if (campoSenha.value.length < 8)
            campoSenhaErros.innerHTML = "Senha precisa conter no mínimo 8 caracteres"
        else if (!/\d/.test(campoSenha.value))
            campoSenhaErros.innerHTML = "Senha precisa conter no mínimo um número"
        else if (!/[a-z]/.test(campoSenha.value))
            campoSenhaErros.innerHTML = "Senha precisa conter no mínimo uma letra minúscula"
        else if (!/[A-Z]/.test(campoSenha.value))
            campoSenhaErros.innerHTML = "Senha precisa conter no mínimo uma letra maiúscula"
        else
            campoSenhaErros.innerHTML = ""
    } else if (campoSenhaErros) {
        campoSenhaErros.innerHTML = ""
    }
}

addEventListener("keyup", function(event) { 
    checarCaps(event);
    checarSenha(event);
});