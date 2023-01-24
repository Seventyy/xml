const xmlns = "http://www.w3.org/2000/svg";

class Vector {
    constructor(x = 0, y = 0) {
        this.x = x
        this.y = y
    }
}

// zmienne do wyglądu
const cell_spacing = 8;
const colors = [
    "#e79451",
    "#e76f51",
    "#e75160",
    "#e75186",
    "#e751ab",
    "#d851e7",
    "#8d51e7",
    "#516fe7",
]

// mapa na której są wszystkie operacje robione
let map = [
    [0,0,0, 0,0,0, 0,7,0],
    [1,8,5, 7,0,0, 9,2,0],
    [3,7,0, 0,0,0, 0,0,0],

    [0,0,0, 0,0,0, 0,0,0],
    [0,0,0, 0,0,0, 0,0,0],
    [0,0,0, 0,0,0, 0,0,0],

    [0,0,0, 0,0,0, 0,0,0],
    [0,0,0, 0,0,0, 0,0,0],
    [0,0,0, 0,0,0, 0,0,0],
];

let cell_selected;

function create_numpad(){
    for (let x = 0; x < 3; x++) {
        for (let y = 0; y < 3; y++){
            let pad_number = y*3+x+1;
            let pad = document.getElementById("pad").cloneNode(true);

            // tutaj się musi zgadzać liczba z svg (i tam za jakieś 30 linijek też)
            //                                  |
            //                                  \/ 
            pad.setAttributeNS(null, "x", x * (250 + cell_spacing));
            pad.setAttributeNS(null, "y", y * (250 + cell_spacing));
            
            pad.childNodes[3].textContent = pad_number;

            // jak sie kliknie numerek to wstawia go na mape, updatuje i sprawdza czy wygrałaś
            pad.addEventListener('click', ()=>{
                map[cell_selected.y][cell_selected.x] = pad_number;
                update();
                if (check_board()){
                    document.getElementById("end_screen").appendChild(document.getElementById("win_screen").cloneNode(true));
                }
            })

            document.getElementById("numpad").appendChild(pad);
        }
    }
}

function update() {
    // usuwa wszystkie dziecie jakby coś tam było
    while (document.getElementById("cells").firstChild) {
        document.getElementById("cells").removeChild(document.getElementById("cells").firstChild);
    }

    for (let y = 0; y < 9; y++) {
        for (let x = 0; x < 9; x++){
            let cell = document.getElementById("cell").cloneNode(true);

            cell.setAttributeNS(null, "x", x * (100 + cell_spacing));
            cell.setAttributeNS(null, "y", y * (100 + cell_spacing));
            
            // tutaj ustawia liczbę i kolor numerka (jeżeli liczba to zero to nie wstawia)
            cell.childNodes[3].textContent = (map[y][x] <= 0 ? "" : map[y][x]);
            cell.childNodes[3].setAttributeNS(null, "fill", colors[map[y][x]-1]);

            // tutaj jak się kliknie komórkę to ją wybiera jakby
            cell.addEventListener('click', ()=>{
                cell.childNodes[1].setAttributeNS(null, "fill", "#444444");
                cell_selected = new Vector(x,y);
            })

            document.getElementById("cells").appendChild(cell);
        }
    }
}

function has_all_numbers(arr){
    for (let i = 0; i < 9; i++) {
        if (!arr.includes(i)){
            return false;
        }
    }
    return true;
}

function check_board() {
    for (let i = 0; i < 9; i++) {
        counter = []
        for (let j = 0; j < 9; j++){
            counter.push[map[i][j]]
        }
        if (!has_all_numbers(counter)) return false;
    }
    for (let i = 0; i < 9; i++) {
        counter = []
        for (let j = 0; j < 9; j++){
            counter.push[map[j][i]]
        }
        if (!has_all_numbers(counter)) return false;
    }
    for (let i = 0; i < 3; i++) {
        for (let j = 0; j < 3; j++){
            counter = []
            for (let k = 0; k < 3; k++) {
                for (let l = 0; l < 3; l++){
                    counter = push(map[3*i+k][3*j+l])
                }
            }
            if (!has_all_numbers(counter)) return false;
        }
    }
    return true;
}

create_numpad();
update();
