let start_board1 = [
  [0, 0, 0, 2, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 6, 0, 0, 0],
  [0, 0, 0, 3, 5, 0, 0, 7, 8],
  [0, 0, 1, 0, 0, 0, 0, 0, 0],
  [7, 0, 0, 5, 0, 0, 0, 2, 0],
  [0, 6, 9, 0, 4, 8, 0, 0, 0],
  [0, 4, 0, 7, 0, 1, 0, 0, 9],
  [1, 3, 0, 6, 0, 0, 4, 0, 2],
  [0, 0, 0, 0, 0, 4, 0, 0, 3]
];

let end_board1 = [
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0]
];

let start_board2 = [
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0]
];

let end_board2 = [
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0]
];

let start_board3 = [
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0]
];

let end_board3 = [
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0]
];

let now_board = [];

//assign numbers and stuff
let num1 = document.getElementById("num1").cloneNode(true);
numbers.appendChild(num1);
num1.setAttribute("x",123);
num1.setAttribute("y",123);
let num2 = document.getElementById("num2").cloneNode(true);
let num3 = document.getElementById("num3").cloneNode(true);
let num4 = document.getElementById("num4").cloneNode(true);
let num5 = document.getElementById("num5").cloneNode(true);
let num6 = document.getElementById("num6").cloneNode(true);
let num7 = document.getElementById("num7").cloneNode(true);
let num8 = document.getElementById("num8").cloneNode(true);
let num9 = document.getElementById("num9").cloneNode(true);
let cell_no = document.getElementById("cell_no")[0];
let value = document.getElementById("value")[0];

//for now it's just for one board (apply more)
function prepare_board() {
  for(let i = 0; i < 81; i++) {
    now_board[i] = start_board1[i];
  }
}

function display_board() {
	display_grid();
	for (let i = 0; i < 81; i++) {
	  display_value(now_board[i], i);
	}
}

function display_grid() {
  //display grid (maybe with use of one cell)
}

function display_value(value, cell_no) {
	//add coordinates to paste a number (cell_no)
	switch(value) {
    case 0:
      break;

		case 1:
		  //display img
		  break;
		
		case 2:
		  //display img
		  break;
		
		case 3:
		  //display img
		  break;
		
		case 4:
		  //display img
		  break;
		
		case 5:
		  //display img
		  break;
		
		case 6:
		  //display img
		  break;
		
		case 7:
		  //display img
		  break;
		
		case 8:
		  //display img
		  break;
		
		case 9:
		  //display img
		  break;

    default:
      //error message "wrong board input"
      break;
	}
}

var game=0; //0 - in game, 1 - solved

function in_game() {
  while(game == 0) {
    //waiting for click (when click - insert_value)
    game = is_solved();
  }
}

function is_solved() {
  var all_solved=1; //0 - in progress, 1 - solved
  for(let i = 0; i < 81; i++) {
    if(now_board[i] == 0) {
    all_solved = 1;
    }
  }
  return all_solved;
}

//still in progress
function insert_value() {
  display_value(value, cell_no);
	now_board[cell_no] = value;
}

function main() {
  prepare_board();
  display_board();
  //waiting for user input till finished
  //winning animation
}

//also add searching for errors
//and minus points for errors while solving