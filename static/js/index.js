console.log("hello")


const addNameLabel = document.getElementById("addNameLabel")
const nameInput = document.getElementById("addName")

// const allInputs = document.getElementsByTagName("input")

// for (i = 0; i < allInputs.length; i++) {
//     allInputs[i].addEventListener("focus", makeItBold)
// }

// const makeItBold = (event)=> {
//     event.getTarget.style.fontWeight = "bold"
// }

nameInput.addEventListener("focus", ()=> {
    addNameLabel.style.fontWeight = "bold"
})

nameInput.onblur = function() {
    addNameLabel.style.fontWeight = "normal"
}

// nameInput.addEventListener("blur", ()=> {
//     addNameLabel.style.fontWeight = "normal"
// })

const agreeCheckbox = document.getElementById("agree")

agreeCheckbox.style.outline = "4px solid red"


agreeCheckbox.onchange = ()=> {
    agreeCheckbox.style.accentColor = "green"
    if (agreeCheckbox.checked) {
        agreeCheckbox.style.outline = "none"
    } else {
        agreeCheckbox.style.outline = "4px solid red"
    }
}




