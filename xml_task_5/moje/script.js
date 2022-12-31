let xml_doc; // xml załadowany na stornie i wyświetalany, na nim prowarze wszlkie operacje

document.getElementById("load_button").onclick = function () {
    load_table();
    update_table(); // tu wywala blad za pierwsyzm razem (może await pomoże (jak będize mi się chciało go dodać :P))
}

document.getElementById("test_button").onclick = function () {
    // for testin', does nothin'
}

document.getElementById("modify_button").onclick = function () {
    load_new_data();
    update_table();
}

document.getElementById("add_button").onclick = function () {
    add_entry();
    load_new_data(xml_doc.getElementsByTagName("games:game").length)
    update_table();
}

document.getElementById("delete_button").onclick = function () {
    delete_entry();
    update_table();
}

function add_entry(){
    let entry = xml_doc.getElementsByTagName("games:game")[0].cloneNode(true); 
    xml_doc.getElementsByTagName("games")[0].appendChild(entry);
}

function delete_entry(){
    let entry = xml_doc.getElementsByTagName("games:game")[document.getElementById("modify_id").value - 1]
    entry.parentNode.removeChild(entry)
}

// ładuje dane z wybranego wcześniej pliku xml na stronę do zmiennej xml_doc
// (nie wiem do końca co się tu w środku odwala, ale działa)
function load_table() { 
    let xhr = new XMLHttpRequest();
    xhr.open('GET', URL.createObjectURL(document.getElementById("file_name").files[0]), true);

    xhr.onload = function () {
        xml_doc = this.responseXML;
    }
    
    xhr.send(null);
}

// ładuje dane ze zmiennej xml_doc do tabelki na stronie
function update_table() {
    let games = xml_doc.getElementsByTagName("games:game"); // array referencji do elementów gier

    let table = ""

    // nagówki kolumn
    table += "<tr>";
    for (let i = 0;; i++) {
        let xml_element = get_editable_game_childen(games[0])[i];
        if(!xml_element) break;

        table += "<td>" + xml_element.nodeName + "</td>";
    }
    table += "</tr>";

    // zawarość komórek tabelki
    for (let game = 0; game < games.length; game++) { 
        table += "<tr>";
        for (let i = 0;; i++) {
            let xml_element = get_editable_game_childen(games[game])[i];
            if(!xml_element) break;
    
            table += "<td>" + xml_element.textContent + "</td>";
        }
        table += "</tr>";
    }
    document.getElementById("operating_file").innerHTML = table;
}

// zwraca array referencji do atrybutów argumentu, elementów będących jego dziećmi i atrybutów tych elementów 
function get_editable_game_childen(game) {
    let stuff = [];
    stuff.push(game.attributes[0])
    stuff.push(game.attributes[1])
    for (let i = 0; i < game.children.length; i++) {
        const element = game.children[i];
        if(element.innerHTML){
            stuff.push(element);
        }
        if(element.attributes.length > 0){
            stuff.push(element.attributes[0]);
        }
    }
    return stuff;
}

// zwraca array referencji do podelementów "new_values" w htmlu, które nie są tekstem ani <br>
// (czyli inputy i selecty)
// output pasuje koresomnduje jeden do jednego z get_editable_game_childen()
function get_new_velues_childen(){
    let stuff = [];
    for (let i = 0; i < document.getElementById("new_values").childNodes.length; i++) {
        const element = document.getElementById("new_values").childNodes[i];
        if (element.nodeType == 1 && element.nodeName != "BR"){
            stuff.push(element);
        }
    }
    return stuff;
}

// ładuje dane z sekcji "Data modification" do xml_doc, jeżeli coś zostało wpisane (to ostatnie nie działa dla selectów)
function load_new_data(modify_id = document.getElementById("modify_id").value){ 
    if (!modify_id) return; 

    for (let i = 0;; i++) {

        const xml_element = get_editable_game_childen(xml_doc.getElementsByTagName("games:game")[modify_id-1])[i]
        const new_element = get_new_velues_childen()[i]

        if(!new_element) break;

        if(new_element.value) {
            xml_element.textContent = new_element.value
        }
    }
}
