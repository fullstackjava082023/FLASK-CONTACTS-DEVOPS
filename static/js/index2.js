const deleteRow = (el) => {
    
    el.parentNode.parentNode.style.display='none'
}


function addEmptyRow() {
    const table = document.querySelector('table')
    const newRow = document.createElement('tr')
    newRow.innerHTML = `<td></td> 
                        <td></td> 
                        <td></td>   
                        <td></td> 
                        <td></td> 
                        <td><button onclick=deleteRow(this)>Delete</button> <br/>
                            <button>Edit</button></td>`
    table.appendChild(newRow)                        
}


function addDeynerysRow() {
    const table = document.querySelector('table')
    const newRow = document.createElement('tr')
    newRow.innerHTML = `<td>4</td> 
                        <td>Daenerys</td> 
                        <td>054054054</td>   
                        <td>dragon@fire.com</td> 
                        <td>
                            <img src="/static/images/daenerys.jpg" height="50px">
                        </td> 
                        <td><button onclick=deleteRow(this)>Delete</button> <br/>
                            <button>Edit</button></td>`
    table.appendChild(newRow)                        
}