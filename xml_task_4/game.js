const xmlns = "http://www.w3.org/2000/svg";

class Vector2 {
    constructor(x = 0, y = 0) {
        this.x = x
        this.y = y
    }
}

const map_size = new Vector2(11, 6);
const mine_ammount = 10;

const cell_size = 100;
const cell_spacing = 8;
const board_offset = new Vector2(50,50);
const fall_hight = 10;
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

let map = [];
let covers = [];
let free_cell_count = map_size.x * map_size.y - mine_ammount;

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
            let cell = document.getElementById("cell").cloneNode(true);

            cell.setAttributeNS(null, "x", x * (cell_size + cell_spacing) + board_offset.x);
            cell.setAttributeNS(null, "y", y * (cell_size + cell_spacing) + board_offset.y);
            
            cell.childNodes[3].textContent = (map[x][y] <= 0 ? "" : map[x][y]);
            cell.childNodes[3].setAttributeNS(null, "fill", colors[map[x][y]-1]);

            document.getElementById("cells").appendChild(cell);
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

            cover.addEventListener('click', ()=>{
                propagate(new Vector2(x, y));
                if (map[x][y] == -1){
                let screen = document.getElementById("game_over_screen").cloneNode(true);
                screen.addEventListener('click', ()=>{
                    location.reload()
                })
                document.getElementById("end_screen").appendChild(screen);
                } else {
                    console.log(free_cell_count)
                    if (free_cell_count == 0) {
                        let screen = document.getElementById("win_screen").cloneNode(true);
                        screen.addEventListener('click', ()=>{
                            location.reload()
                        })
                        document.getElementById("end_screen").appendChild(screen);
                    }
                }
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
    free_cell_count--;

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

function animate_covers() {
    for (let y = 0; y < map_size.y; y++) {
        for (let x = 0; x < map_size.x; x++) {
            covers[x][y].childNodes[5].setAttributeNS(null, "from", y * (cell_size + cell_spacing) + board_offset.y - fall_hight);
            covers[x][y].childNodes[5].setAttributeNS(null, "to", y * (cell_size + cell_spacing) + board_offset.y - fall_hight);
            covers[x][y].childNodes[5].setAttributeNS(null, "dur", ((x+y) * 0.1 + 0.1 + "s"));
            
            covers[x][y].childNodes[7].setAttributeNS(null, "begin", (x+y) * 0.1 + "s");
            covers[x][y].childNodes[7].setAttributeNS(null, "from", y * (cell_size + cell_spacing) + board_offset.y - fall_hight);
            covers[x][y].childNodes[7].setAttributeNS(null, "to", y * (cell_size + cell_spacing) + board_offset.y);

            covers[x][y].childNodes[9].setAttributeNS(null, "dur", (x+y) * 0.1 + 0.1 + "s");
            covers[x][y].childNodes[11].setAttributeNS(null, "begin", (x+y) * 0.1 + "s");
        }
    }
}

init();
generate_map();
spawn_geometry();
spawn_covers();
animate_covers();
