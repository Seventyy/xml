let xml_doc;

document.getElementById("submit_1").onclick = function () {
    load_table();
    update_table();
}

document.getElementById("modify_data").onclick = function () {
    load_new_data();
    update_table();
}

document.getElementById("insert_data").onclick = function () {
    add_entry();
    load_new_data(xml_doc.getElementsByTagName("plant").length - 1)
    update_table();
}

document.getElementById("delete_data").onclick = function () {
    delete_entry();
    update_table();
}

function add_entry() {
    let plants = xml_doc.getElementsByTagName("plant")
    let entry = plants[0].cloneNode(true);
    
    xml_doc.getElementsByTagName("plants")[0].appendChild(entry);
}

function delete_entry() {
    let entry = xml_doc.getElementsByTagName("plant")[document.getElementById("plant_id").value - 1]
    entry.parentNode.removeChild(entry)
}

function load_table() { 
    let xhr = new XMLHttpRequest();
    xhr.open('GET', URL.createObjectURL(document.getElementById("xml_file").files[0]), true);

    xhr.onload = function () {
        xml_doc = this.responseXML;
    }
    
    xhr.send(null);
}

function update_table() {
    let plants = xml_doc.getElementsByTagName("plant");

    let table = ""

    table += "<tr>";
    for (let i = 0;; i++) {
        let xml_element = get_plant_editables(plants[0])[i];
        if(!xml_element) break;

        table += "<td>" + xml_element.nodeName + "</td>";
    }
    table += "</tr>";

    for (let plant = 0; plant < plants.length; plant++) { 
        table += "<tr>";
        for (let i = 0;; i++) {
            let xml_element = get_plant_editables(plants[plant])[i];
            if(!xml_element) break;
    
            table += "<td>" + xml_element.textContent + "</td>";
        }
        table += "</tr>";
    }
    document.getElementById("xml_file_table").innerHTML = table;
}

function get_plant_editables(plant) {  
    let elements = [];
    elements.push(plant.attributes[0])
    elements.push(plant.getElementsByTagName("name")[0])
    elements.push(plant.getElementsByTagName("common_name")[0])
    elements.push(plant.getElementsByTagName("type")[0])
    elements.push(plant.getElementsByTagName("family")[0])
    elements.push(plant.getElementsByTagName("maintenance")[0].attributes[0])
    elements.push(plant.getElementsByTagName("sunlight")[0])
    elements.push(plant.getElementsByTagName("water")[0])

    return elements;
}

function get_input_elemnts(){
    let elements = [];

    elements.push(document.getElementById("plant_id"))
    elements.push(document.getElementById("plant_name"))
    elements.push(document.getElementById("plant_common_name"))
    elements.push(document.getElementById("plant_type"))
    elements.push(document.getElementById("plant_family"))
    elements.push(document.getElementById("plant_difficulty"))
    elements.push(document.getElementById("plant_sunlight"))
    elements.push(document.getElementById("plant_water"))

    return elements;
}

function load_new_data(plant_id = document.getElementById("plant_id").value){ 
    for (let i = 0;; i++) {
        const xml_element = get_plant_editables(xml_doc.getElementsByTagName("plant")[plant_id])[i]
        const new_element = get_input_elemnts()[i]

        if(!new_element) break;

        if(new_element.value) {
            xml_element.textContent = new_element.value
        }

    }
}
