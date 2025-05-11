let clickedElement;

function loadContextMenuOptions() {
    let contextMenuOptionGoTo = document.getElementById('context-menu-option-go-to');
    contextMenuOptionGoTo.addEventListener('click', function() {
        contextMenuSearch();
    });

    let contextMenuOptionSearch = document.getElementById('context-menu-option-search');
    contextMenuOptionSearch.addEventListener('click', function() {
        contextMenuSearch();
    });

    let contextMenuOptionOpenImage = document.getElementById('context-menu-option-open-image');
    contextMenuOptionOpenImage.addEventListener('click', function() {
        contextMenuOpenImage();
    });

    let contextMenuOptionOpenLink = document.getElementById('context-menu-option-open-link');
    contextMenuOptionOpenLink.addEventListener('click', function() {
        contextMenuSearch();
    });

    let contextMenuOptionCopy = document.getElementById('context-menu-option-copy');
    contextMenuOptionCopy.addEventListener('click', function() {
        contextMenuCopyToClipboard();
    });

    /*let contextMenuOptionPaste = document.getElementById('context-menu-option-paste');
    contextMenuOptionPaste.addEventListener('click', async(evt) => {
        contextMenuPasteFromClipboard(evt);
    });*/
}

function getSelectedText() {
    let text;

    if (clickedElement.value) {
        text = clickedElement.value;
    }
    else if (window.getSelection()) {
        text = window.getSelection().toString();
    } else if (document.selection && document.selection.type != "Control") {
        text = document.selection.createRange().text;
    }
    
    return text;
}

function contextMenuSearch() {
    if (clickedElement.baseURI) {
        window.open(clickedElement.baseURI, '_blank').focus();
    } else if (clickedElement.href) {
        window.open(clickedElement.href, '_blank').focus();
    } else if (getSelectedText) {
        window.open("https://duckduckgo.com?q=" + getSelectedText(), '_blank').focus();
    }
}

function contextMenuOpenImage() {
    window.open(clickedElement.src, '_blank').focus();
}

function contextMenuCopyToClipboard() {
    navigator.clipboard.writeText(getSelectedText());
}

async function contextMenuPasteFromClipboard(evt) {
    let text = await navigator.clipboard.readText();
    clickedElement.value += text;
}

function showContextMenu(evt) {
    clickedElement = evt.target;

    let cursor = event || window.event;
    let contextMenuComponent = document.getElementById('context-menu-component');

    contextMenuComponent.style.visibility = 'visible';
    contextMenuComponent.style.top = cursor.clientY + 'px';
    contextMenuComponent.style.left = cursor.clientX + 'px';

    let contextMenuOptions = document.getElementById('context-menu-options');
    contextMenuOptions.style.opacity = '100%';

    let contextMenuOptionGoTo = document.getElementById('context-menu-option-go-to');
    let contextMenuOptionOpenImage = document.getElementById('context-menu-option-open-image');
    let contextMenuOptionOpenLink = document.getElementById('context-menu-option-open-link');
    let contextMenuOptionSearch = document.getElementById('context-menu-option-search');
    let contextMenuOptionCopy = document.getElementById('context-menu-option-copy');
    let contextMenuOptionPaste = document.getElementById('context-menu-option-paste');
    let contextMenuOptionCut = document.getElementById('context-menu-option-cut');

    if (clickedElement.tagName == 'BUTTON') {
        contextMenuOptionOpenImage.style.display = 'none';
        contextMenuOptionOpenLink.style.display = 'none';
        contextMenuOptionSearch.style.display = 'none';
        contextMenuOptionCopy.style.display = 'none';
        contextMenuOptionPaste.style.display = 'none';
        contextMenuOptionCut.style.display = 'none';

        if (clickedElement.baseURI)
            contextMenuOptionGoTo.style.display = 'block';
        else
            contextMenuOptionGoTo.style.display = 'none';
    }
    else if (clickedElement.tagName == 'IMG') {
        contextMenuOptionOpenImage.style.display = 'block';
        contextMenuOptionOpenLink.style.display = 'none';
        contextMenuOptionSearch.style.display = 'none';
        contextMenuOptionCopy.style.display = 'block';
        contextMenuOptionPaste.style.display = 'none';
        contextMenuOptionCut.style.display = 'none';
    }
    else {
        contextMenuOptionOpenImage.style.display = 'none';

        if (clickedElement.parentElement.className == 'trix-content' &&
            clickedElement.parentElement.parentElement.className == 'conteudo-elementos'
        ) {
            contextMenuOptionCopy.style.display = 'none';
        } else {
            contextMenuOptionCopy.style.display = 'block';
        }

        if (clickedElement.tagName == 'INPUT' || clickedElement.tagName == 'TEXTAREA') {
            contextMenuOptionPaste.style.display = 'block';
            contextMenuOptionCut.style.display = 'block';
        }
        else {
            contextMenuOptionPaste.style.display = 'none';
            contextMenuOptionCut.style.display = 'none';
        }

        if (clickedElement.href) {
            contextMenuOptionOpenLink.style.display = 'block';
            contextMenuOptionSearch.style.display = 'none';
        }
        else {
            contextMenuOptionOpenLink.style.display = 'none';
            contextMenuOptionSearch.style.display = 'block';
        }
    }
}

function hideContextMenu() {
    let contextMenuComponent = document.getElementById('context-menu-component');
    contextMenuComponent.style.visibility = 'hidden';
    contextMenuComponent.style['transition-duration'] = '0s';

    let contextMenuOptions = document.getElementById('context-menu-options');
    contextMenuOptions.style.opacity = '0%';
}

if (document.addEventListener) {
    document.addEventListener('contextmenu', function(e) {
        showContextMenu(e);
        e.preventDefault();
    }, false);

    document.addEventListener('mousedown', function(e) {
        hideContextMenu();
    });

    loadContextMenuOptions();
} else {
    document.attachEvent('oncontextmenu', function() {
        showContextMenu(e);
        window.event.returnValue = false;
    });

    document.attachEvent('onmousedown', function(e) {
        hideContextMenu();
    });

    loadContextMenuOptions();
}
