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
function load_new_data(){ 
    var modify_id = document.getElementById("modify_id").value;
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
























// Cmentarz:

// document.getElementById("save_button").onclick = function () {
//     zapisz();
// }

// document.getElementById("btnDodajRekord").onclick = function () {
//     dodajXML();
//     updateXML();
// }
// document.getElementById("btnDodajGatunek").onclick = function () {
//     if(document.getElementById("iNowyGatunek").value  === null || document.getElementById("iNowyGatunek").value === ""
//     || document.getElementById("iNowyGatunekSkrót").value  === null || document.getElementById("iNowyGatunekSkrót").value === "") {
//         alert("Wypełnij wszystkie wymagane pola: Nazwa Gatunku, Skrót Gatunku");
//     }
//     else {
//         select = document.getElementById("iGatunek");
//         select2 = document.getElementById("sGatunekUsun");
//         select.add(new Option(document.getElementById("iNowyGatunekSkrót").value));
//         select2.add(new Option(document.getElementById("iNowyGatunekSkrót").value));


//         oldNode=xml_doc.getElementsByTagName('gatunek')[0];
//         newNode=oldNode.cloneNode(true);
//         newNode.setAttribute("typ", document.getElementById("iNowyGatunekSkrót").value);
//         newNode.textContent = document.getElementById("iNowyGatunek").value
//         xml_doc.documentElement.getElementsByTagName("gatunki")[0].appendChild(newNode);

//     }


//     // var opt = document.createElement(document.getElementById("iNowyGatunekSkrót").value);
//     // select.appendChild(opt);
// }
// document.getElementById("btnDodajPlatforme").onclick = function () {
//     if(document.getElementById("iNowaPlatforma").value  === null || document.getElementById("iNowaPlatforma").value === "") {
//         alert("Wypełnij wszystkie wymagane pola: Nazwa Platformy");
//     }
//     else {
//         document.getElementById("iPlatforma").add(new Option(document.getElementById("iNowaPlatforma").value));
//         document.getElementById("iPlatformaUsun").add(new Option(document.getElementById("iNowaPlatforma").value));

//     }
// }
// document.getElementById("btnDodajPEGI").onclick = function () {
//     if(document.getElementById("iNowePEGI").value  === null || document.getElementById("iNowePEGI").value === "") {
//         alert("Wypełnij wszystkie wymagane pola: Cyfra PEGI");
//     }
//     else {
//         var value = document.getElementById("iNowePEGI").value + "+";
//         document.getElementById("iPEGI").add(new Option(value));
//         document.getElementById("iPEGIUsun").add(new Option(value));
//     }
// }
// document.getElementById("btnUsuńGatunek").onclick = function () {
//     if(check("gatunek",document.getElementById("sGatunekUsun").value)) {
//         var tmp;
//         var x = xml_doc.getElementsByTagName("gatunek");
//         for (i = 0; i < x.length; i++) {
//             if(x[i].getAttribute("typ") === document.getElementById("sGatunekUsun").value){
//                 x[i].parentNode.removeChild(x[i]);
//                 tmp = i;
//             }
//         }
//         document.getElementById("iGatunek").remove(tmp);
//         document.getElementById("sGatunekUsun").remove(document.getElementById("sGatunekUsun").selectedIndex);
//     }
// }
// document.getElementById("btnUsunPlatfroma").onclick = function () {
//     if(checkElement("platforma", document.getElementById("iPlatformaUsun").value)) {
//         var v = document.getElementById("iPlatformaUsun").selectedIndex;
//         document.getElementById("iPlatformaUsun").remove(v);
//         document.getElementById("iPlatforma").remove(v);
//     }
// }
// document.getElementById("btnUsunPEGI").onclick = function () {
//     if(checkElement("PEGI", document.getElementById("iPEGIUsun").value)) {
//         var v = document.getElementById("iPEGIUsun").selectedIndex;
//         document.getElementById("iPEGIUsun").remove(v);
//         document.getElementById("iPEGI").remove(v);
//     }
// }
// document.getElementById("btnModyfikacjaGatunku").onclick = function () {
//     if(document.getElementById("iZmienianyGatunekSkrót").val === null || document.getElementById("iZmienianyGatunekSkrót").value === ""
//     || document.getElementById("iZmienianyGatunek").val === null || document.getElementById("iZmienianyGatunek").value === "") {
//         alert("Wypełnij wszystkie wymagane pola: Zmieniany Gatunek oraz Zmieniany Gatunek Skrót");
//     }
//     else {
//         //Zmienianie wartości gatunków w rekordach
//         var value = document.getElementById("iZmienianyGatunekSkrót").value;
//         var value2 = document.getElementById("iZmienianyGatunek").value;
//         var porownywany = document.getElementById("iGatunek").value;
//         var x = xml_doc.getElementsByTagName("gra");
//         for (i = 0; i < x.length; i++) {
//             if(x[i].getAttribute("gatunek") === porownywany) {
//                 x[i].setAttribute("gatunek", value);
//             }
//         }
//         //Us gatunku
//             var tmp;
//             var x = xml_doc.getElementsByTagName("gatunek");
//             for (i = 0; i < x.length; i++) {
//                 if (x[i].getAttribute("typ") === document.getElementById("iGatunek").value) {
//                     x[i].parentNode.removeChild(x[i]);
//                     tmp = i;
//                 }
//             }
//             document.getElementById("iGatunek").remove(tmp);
//             document.getElementById("sGatunekUsun").remove(document.getElementById("sGatunekUsun").selectedIndex);

//         //Dod gatunku
//         select = document.getElementById("iGatunek");
//         select2 = document.getElementById("sGatunekUsun");
//         select.add(new Option(document.getElementById("iZmienianyGatunekSkrót").value));
//         select2.add(new Option(document.getElementById("iZmienianyGatunekSkrót").value));


//         oldNode=xml_doc.getElementsByTagName('gatunek')[0];
//         newNode=oldNode.cloneNode(true);
//         newNode.setAttribute("typ", document.getElementById("iZmienianyGatunekSkrót").value);
//         newNode.textContent = document.getElementById("iZmienianyGatunek").value
//         xml_doc.documentElement.getElementsByTagName("gatunki")[0].appendChild(newNode);


//         updateXML();
//     }
// }
// // document.getElementById("btnValidate").onclick = function () {
// //     validateXMLAgainstXSD()
// // }


// function loadGatunkiSelect() {
//     var x = xml_doc.getElementsByTagName("gatunek");
//     select = document.getElementById('iGatunek');
//     select2 = document.getElementById('sGatunekUsun');
//     $("#iGatunek").empty();
//     $("#sGatunekUsun").empty();

//     for (var i =0; i<x.length; i++){
//         select.add(new Option(x[i].getAttribute("typ")));
//         select2.add(new Option(x[i].getAttribute("typ")));

//     }
// }

// function zapisz() {
//     //Serialize
//     const serializer = new XMLSerializer();
//     var toSave = serializer.serializeToString(xml_doc);

//     //Utwórz nowy plik
//     const blob = new Blob([toSave], { type: "text/xml" });
//     const url = URL.createObjectURL(blob);

//     //Utwórz i kliknij fałszywy tymczasowy link
//     const fakeLink = document.createElement("a");
//     fakeLink.href = url;
//     fakeLink.download = 'zmieniony.xml';
//     fakeLink.click();
// }
// function updateXML() {
//     var i;
//     var table =
//         `<tr><th>id</th><th>gatunek</th><th>tytul</th><th>producent</th>
//         <th>wydawca</th><th>dystrybutor</th>
//         <th>rokWydania</th><th>cena</th>
//         <th>czyWypozyczona</th><th>PEGI</th>
//         <th>platforma</th><th>jezyk</th>
//         </tr>`;
//     var x = xml_doc.getElementsByTagName("gra");

//     // Start to fetch the data by using TagName
//     for (i = 0; i < x.length; i++) {
//         table += "<tr><td>" +
//             x[i].getAttribute("ID") + "</td><td>" +
//             x[i].getAttribute("gatunek") + "</td><td>" +
//             x[i].getElementsByTagName("tytul")[0]
//                 .childNodes[0].nodeValue + "</td><td>" +
//             x[i].getElementsByTagName("producent")[0]
//                 .childNodes[0].nodeValue + "</td><td>" +
//             x[i].getElementsByTagName("wydawca")[0]
//                 .childNodes[0].nodeValue + "</td><td>" +
//             x[i].getElementsByTagName("dystrybutor")[0]
//                 .childNodes[0].nodeValue + "</td><td>" +
//             x[i].getElementsByTagName("rokWydania")[0]
//                 .childNodes[0].nodeValue + "</td><td>" +
//             x[i].getElementsByTagName("cena")[0]
//                 .childNodes[0].nodeValue + "</td><td>" +
//             x[i].getElementsByTagName("czyWypozyczona")[0]
//                 .childNodes[0].nodeValue + "</td><td>" +
//             x[i].getElementsByTagName("PEGI")[0]
//                 .childNodes[0].nodeValue + "</td><td>" +
//             x[i].getElementsByTagName("platforma")[0]
//                 .childNodes[0].nodeValue + "</td><td>" +
//             x[i].getElementsByTagName("jezyk")[0]
//                 .childNodes[0].nodeValue + "</td></tr>";
//     }
//     document.getElementById("aTrescPliku").innerHTML = table;
// }
// function deleteXML(position){
//     var x = xml_doc.getElementsByTagName("gra")[position];
//     x.parentNode.removeChild(x);
//     updateXML();
// }
// function dodajXML(){

//     oldNode=xml_doc.getElementsByTagName('gra')[0];
//     var count = xml_doc.getElementsByTagName("gra").length;
//     newNode=oldNode.cloneNode(true);
//     var x = xml_doc.getElementsByTagName("gra");

//     // Start to fetch the data by using TagName
//     for (i = 0; i < x.length; i++) {
//         if (parseInt(x[i].getAttribute("ID")) === count)
//             count++;
//     }

//     newNode.setAttribute("ID", count);
//     xml_doc.documentElement.getElementsByTagName("gry")[0].appendChild(newNode);

// }
// function zmien(){


// }
// function idCheck(id){
//     var x = xml_doc.getElementsByTagName("gra");
//     var result = true;
//     // Start to fetch the data by using TagName
//     for (var i = 0; i < x.length; i++) {
//         if(x[i].getAttribute("ID") === id)
//             result = false;
//     }
//     return result;
// }
// function check(nazwaAtrybutu, porownywany) {
//     var x = xml_doc.getElementsByTagName("gra");
//     for (i = 0; i < x.length; i++) {
//             if(x[i].getAttribute(nazwaAtrybutu) === porownywany) {
//                 alert("Najpierw usuń dany atrybut z rekordów tabeli by usunąć tę kategorię ogólną.")
//                 return false;
//             }
//     }
//     return true;
// }

// function checkElement(nazwaElementu, porownywany) {

//     var x = xml_doc.getElementsByTagName("gra");
//     for (i = 0; i < x.length; i++) {
//         if(x[i].getElementsByTagName(nazwaElementu)[0].childNodes[0].nodeValue === porownywany) {
//             alert("Najpierw usuń dany element z rekordów tabeli by usunąć tę kategorię ogólną.")
//             return false;
//         }
//     }
//     return true;
// }

// function validateXMLAgainstXSD(){
//     var validator = require('xsd-schema-validator');
//
//     var xmlStr = '<foo:bar />';
//
//     validator.validateXML(xml_doc, 'xmlscheme.xsd', function(err, result) {
//         if (err) {
//             alert("There's an error in validation!")
//             throw err;
//
//         }
//
//         result.valid; // true
//     });
// }


// function removeAllChildNodes(parent) {
//     while (parent.firstChild) {
//         parent.removeChild(parent.firstChild);
//     }
// }