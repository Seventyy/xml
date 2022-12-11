var enemy = document.getElementById('enemy')
enemy.setAttribute('x', '200')

var element = document.getElementById('enemy');

element.addEventListener("mousemove",  move);

function start(e){
  console.log(e);
}

function move(e){
    element.setAttribute('x', e.clientX - 50);
    element.setAttribute('y', e.clientY - 50);
    console.log(e.clientX);
    console.log(e.clientY);
    console.log("śranie");
}

