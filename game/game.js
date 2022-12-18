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

class Vector2 {
    constructor(x, y) {
        this.x = x
        this.y = y
    }
}

const map_size = new Vector2(8, 5)
const mine_ammount = 16;

const padding = 8;

let cells = []
let mines = []

let map = []

function reset() {
    for (let i = 0; i < mine_ammount; i++) {
        mines.push(document.getElementById('m' + i));
    }

    for (let x = 0; x < map_size.x; x++) {
        cells.push([]);
        for (let y = 0; y < map_size.y; y++) {
            cells[x].push(document.getElementById('c' + x + ',' + y));
        }
    }

    for (let y = 0; y < map_size.y; y++) {
        for (let x = 0; x < map_size.x; x++) {
            cells[x][y].setAttribute('x', x * (100 + padding));
            cells[x][y].setAttribute('y', y * (100 + padding));
            document.getElementById('points').textContent = points
        }
    }

    for (let y = 0; y < map_size.y; y++) {
        map.push([]);
        for (let x = 0; x < map_size.x; x++) {
            map[y].push(0);
        }
    }



    // for (let i = 0; i < mines.length; i++) {
    //     mines[i].setAttribute('x', 120 * i);
    // }
}


console.table(cells);
reset();