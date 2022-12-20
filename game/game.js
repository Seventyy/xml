const xmlns = "http://www.w3.org/2000/svg";

class Vector2 {
    constructor(x = 0, y = 0) {
        this.x = x
        this.y = y
    }
}

const map_size = new Vector2(10, 5);
const mine_ammount = 8;

const cell_size = 100;
const cell_spacing = 8;
const board_offset = new Vector2(50,50);
const colors = [
    "#C455A8", 
    "#C455A8", 
    "#C455A8", 
    "#C455A8", 
    "#C455A8", 
    "#C455A8", 
    "#C455A8", 
    "#C455A8"
]

// let cells = [];
// let mines = [];

let map = [];
let covers = [];

function init() {
    document.addEventListener('contextmenu', event => event.preventDefault());

    for (let x = 0; x < map_size.x; x++) {
        map.push([]);
        covers.push([]);
        for (let y = 0; y < map_size.y; y++) {
            map[x].push(0);
            covers[x].push(null);
        }
    }
}

function generate_map(){
    // place mines
    for (let i = 0; i < mine_ammount; i++) {
        let position = new Vector2(
            Math.floor(Math.random() * map_size.x),
            Math.floor(Math.random() * map_size.y));
        if (map[position.x][position.y] == -1) {
            i--;
            continue;
        }
        map[position.x][position.y] = -1;
    }

    // generate hints
    for (let y = 0; y < map_size.y; y++) {
        for (let x = 0; x < map_size.x; x++) {
            if (map[x][y] == -1) 
                continue;
            let count = 0;
            for (let i = -1; i <= 1; i++) {
                for (let j = -1; j <= 1; j++) {
                    check_position = new Vector2(x + i, y + j);
                    if (check_position.x >= 0 && check_position.x < map_size.x &&
                        check_position.y >= 0 && check_position.y < map_size.y &&
                        map[check_position.x][check_position.y] == -1)
                        count++;
                }
            }
            map[x][y] = count;
        }
    }
}

function spawn_geometry() {
    for (let y = 0; y < map_size.y; y++) {
        for (let x = 0; x < map_size.x; x++) {
            if (map[x][y] == -1) {
                let mine = document.getElementById("mine").cloneNode(true);

                mine.setAttributeNS(null, "x", x * (cell_size + cell_spacing) + 10 + board_offset.x);
                mine.setAttributeNS(null, "y", y * (cell_size + cell_spacing) + 10 + board_offset.y);
                
                document.getElementById("mines").appendChild(mine);
            }
            else {
                let cell = document.getElementById("cell").cloneNode(true);

                cell.setAttributeNS(null, "x", x * (cell_size + cell_spacing) + board_offset.x);
                cell.setAttributeNS(null, "y", y * (cell_size + cell_spacing) + board_offset.y);
                
                cell.childNodes[3].textContent = (map[x][y] == 0 ? "" : map[x][y]);
                cell.childNodes[3].setAttributeNS(null, "fill", colors[map[x][y]-1]);

                document.getElementById("cells").appendChild(cell);
            }
        }
    }
}

function spawn_covers() {
    for (let y = 0; y < map_size.y; y++) {
        for (let x = 0; x < map_size.x; x++) {
            let cover = document.getElementById("cover").cloneNode(true);
            covers[x][y] = cover;

            cover.setAttributeNS(null, "x", x * (cell_size + cell_spacing) + board_offset.x);
            cover.setAttributeNS(null, "y", y * (cell_size + cell_spacing) + board_offset.y);

            cover.addEventListener('click', (event)=>{
                event.preventDefault();
                propagate(new Vector2(x, y));
            })
            cover.addEventListener('contextmenu', ()=>{
                cover.appendChild(document.getElementById("flag").cloneNode(true));
            })

            document.getElementById("covers").appendChild(cover);
        }
    }
}

function propagate(vec){
    if (!covers[vec.x][vec.y]) return;

    document.getElementById("covers").removeChild(covers[vec.x][vec.y]);
    covers[vec.x][vec.y] = null;

    if (map[vec.x][vec.y] == 0) {
        for (let i = -1; i <= 1; i++) {
            for (let j = -1; j <= 1; j++) {
                adjacent = new Vector2(vec.x + i, vec.y + j);
                if (adjacent.x < 0 || adjacent.x >= map_size.x ||
                    adjacent.y < 0 || adjacent.y >= map_size.y )
                    continue;
                propagate(adjacent);
            }
        }
    }
}

init();
generate_map();
spawn_geometry();
spawn_covers();
// console.table(map);



















// var enemy = document.getElementById('enemy')
// enemy.setAttribute('x', '200')

// var element = document.getElementById('enemy');

// element.addEventListener("mousemove",  move);

// function start(e){
//   console.log(e);
// }

// function move(e){
//     element.setAttribute('x', e.clientX - 50);
//     element.setAttribute('y', e.clientY - 50);
//     console.log(e.clientX);
//     console.log(e.clientY);
//     console.log("śranie");
// }

// var test = document.getElementById('')




// function reset() {
//     for (let i = 0; i < mine_ammount; i++) {
//         mines.push(document.getElementById('m' + i));
//     }

//     for (let x = 0; x < map_size.x; x++) {
//         cells.push([]);
//         for (let y = 0; y < map_size.y; y++) {
//             cells[x].push(document.getElementById('c' + x + ',' + y));
//         }
//     }

//     for (let y = 0; y < map_size.y; y++) {
//         for (let x = 0; x < map_size.x; x++) {
//             cells[x][y].setAttribute('x', x * (100 + padding));
//             cells[x][y].setAttribute('y', y * (100 + padding));
//             // console.log(cells[x][y])
//         }
//     }

//     for (let y = 0; y < map_size.y; y++) {
//         map.push([]);
//         for (let x = 0; x < map_size.x; x++) {
//             map[y].push(0);
//         }
//     }



//     // for (let i = 0; i < mines.length; i++) {
//     //     mines[i].setAttribute('x', 120 * i);
//     // }
// }







// function test() {
//     let test_cell = document.createElementNS(xmlns, "g");
//     let test_rect = document.createElementNS(xmlns, "rect");
//     let test_text = document.createElementNS(xmlns, "text");

//     test_rect.setAttributeNS(null, "width", "100");
//     test_rect.setAttributeNS(null, "height", "100");
//     test_rect.setAttributeNS(null, "fill", "gray");
    
//     test_text.setAttributeNS(null, "x", "30");
//     test_text.setAttributeNS(null, "y", "80");
//     test_text.setAttributeNS(null, "font-size", "80");
//     test_text.setAttributeNS(null, "font-family", "impact");

//     test_text.textContent = 7;

//     test_cell.appendChild(test_rect);
//     test_cell.appendChild(test_text);
//     document.getElementById("test_group").appendChild(test_cell);
// }

// function test2() {
//     let test_cell = document.createElementNS(xmlns, "g");

//     let test_mine = document.getElementById("mine");
//     console.log(test_mine.childNodes);

//     test_mine.setAttributeNS(null, "x", "30");
//     test_mine.setAttributeNS(null, "y", "80");
    
//     document.getElementById("test_group").appendChild(test_mine);
// }

// test()
// test2()

// console.table(cells);
// reset();
// console.log(cells[1][2])
// cells[1][3].childNodes[3].textContent = 5
// console.log(cells[1][3].childNodes[3].textContent)
// console.log(cells[1][2].lastElementChild.textContent)