const select_value = document.getElementById("solicitacao_assunto")

const atendimento_view = document.getElementById("atendimento")
const denuncia_view = document.getElementById("denuncia")
const utilizacao_view = document.getElementById("utilizacao")
const cadastro_view = document.getElementById("cadastro")
const atividades_view = document.getElementById("atividades")

const solicitacao_anexos = document.getElementById("solicitacao_anexos")
const anexo_atividades = document.getElementById("anexo_atividades")
const anexo_atendimentos = document.getElementById("anexo_atendimentos")
const checkbox_denuncia1 = document.getElementById("solicitacao_denuncium_termo1")
const checkbox_denuncia2 = document.getElementById("solicitacao_denuncium_termo2")
const denuncia_submit = document.getElementById("denuncia_submit")
const main_submit = document.getElementById("main_submit")

denuncia_submit.onclick = () => {
  main_submit.click()
}

if (checkbox_denuncia1 !== null) checkbox_denuncia1.onchange = () => {
  if(checkbox_denuncia1.checked && checkbox_denuncia2.checked) {
    denuncia_submit.disabled = false
  } else {
    denuncia_submit.disabled = true
  }
}

if (checkbox_denuncia2 !== null) checkbox_denuncia2.onchange = () => {
  if(checkbox_denuncia1.checked && checkbox_denuncia2.checked) {
    denuncia_submit.disabled = false
  } else {
    denuncia_submit.disabled = true
  }
}

function swapDisplay (value) {
  switch(value) {
    case "Atendimento psicopedagógico":
      atendimento_view.style.display = "block"
      break;
    case "Denúncia": 
      denuncia_view.style.display = "block"
      break;
    case "Utilização sala de aula":
      utilizacao_view.style.display = "block"
      break;
    case "Cadastro disciplina":
      cadastro_view.style.display = "block"
      break;
    case "Atividades complementares": 
      atividades_view.style.display = "block"
      break;
  }
}

document.addEventListener("DOMContentLoaded", () => {
  swapDisplay(select_value.value)
  denuncia_submit.disabled = true
  if (checkbox_denuncia1 && checkbox_denuncia2) {
    checkbox_denuncia1.checked = false
    checkbox_denuncia2.checked = false
  }
})

select_value.addEventListener("change", (e) => {
  atendimento_view.style.display = "none"
  denuncia_view.style.display = "none"
  utilizacao_view.style.display = "none"
  cadastro_view.style.display = "none"
  atividades_view.style.display = "none"
  swapDisplay(e.target.value)
})

anexo_atividades.addEventListener("click", () => {
  solicitacao_anexos.click()
  solicitacao_anexos.addEventListener("change", () => {
    const arquivo = solicitacao_anexos.files[0]

    anexo_atividades.innerHTML = arquivo.name
  })
})

anexo_atendimentos.addEventListener("click", () => {
  solicitacao_anexos.click()
  solicitacao_anexos.addEventListener("change", () => {
    const arquivo = solicitacao_anexos.files[0]

    anexo_atendimentos.innerHTML = arquivo.name
  })
})