const board = document.getElementById('board')

class Player {
    constructor() {
        this.health = 3
        this.immune = false
        this.body = document.getElementById('player')
        this.width = +this.body.getAttribute('width')/2
        this.height = +this.body.getAttribute('height')/2
    }
    updatePosition(x, y) {
        var prevX = this.body.getAttribute("x")
        this.body.setAttribute("x",prevX*0.9 + x*0.1)
        var prevY = this.body.getAttribute("y")
        this.body.setAttribute("y",prevY*0.9 + y*0.1)
    }
    isCollidingWith(name) {
        /*
        console.log(+name.body.getAttribute("x"))
        console.log(+name.body.getAttribute("x") + +name.width)
        console.log(+name.body.getAttribute("y"))
        console.log(+name.body.getAttribute("y")+ +name.height)

        console.log(this.centerX)
        console.log(this.centerY)
        */

        if( +this.body.getAttribute("x") + this.width > +name.body.getAttribute("x") && 
            +this.body.getAttribute("x") + this.width < +name.body.getAttribute("x") + +name.width &&
            +this.body.getAttribute("y") + this.height > +name.body.getAttribute("y") &&
            +this.body.getAttribute("y") + this.height < +name.body.getAttribute("y") + +name.height){
                return(true)
            }
        else {return(false)}
            
    }
}

class Projectile {
    constructor({position, velocity}){
        this.speed
    }
    draw() {
        c.beginPath()
        c.arc(this.position.x, this.position.y, )
    }
}

class Enemy {
    constructor(id, speed, targetX, targetY, tick) { 
        this.body = document.getElementById(id)
        this.width = +this.body.getAttribute('width')
        this.height = +this.body.getAttribute('height')
        this.speed = +speed
        this.angleX = +targetX
        this.angleY = +targetY
        this.tick = +tick
        this.canSpawn = true
    }
    async updatePosition(){
        var prevX = +this.body.getAttribute("x")
        this.body.setAttribute("x", prevX + this.speed*this.angleX)
        var prevY = +this.body.getAttribute("y")
        this.body.setAttribute("y",prevY + this.speed*this.angleY)
    }
}


var trackingPointX = 0
var trackingPointY = 0
var timer = 0
var gameLoop = false
var gameOver = false
var clockPause = false

var points = 0

var difficultyMod = 1
var entryError = true


const boardWidth = +document.getElementById('board').getAttribute('width') //1300
const boardHeight = +document.getElementById('board').getAttribute('height') //1800
const boardMarginX = +document.getElementById('board').getAttribute('x')
const boardMarginY = +document.getElementById('board').getAttribute('y')

var hpMeterWidth = +document.getElementById('lives').getAttribute('width')

const playerShip = new Player()
const enemies = []

////////////(element_name, speed, targetX, targetY, spawn_tick)
const leftZoomer = new Enemy('enemy1', 12, 1, 1, 200)
const bottomZoomer = new Enemy('enemy3', 8, 1, -2, 333)
const rightZoomer = new Enemy('enemy2', 12, -1, 1, 250)
const topBlocker = new Enemy('enemy4', 9, 0, 1, 600)

enemies.push(leftZoomer)
enemies.push(bottomZoomer)
enemies.push(rightZoomer)
enemies.push(topBlocker)


while(true){
    var difficultyLevel = prompt("Choose the difficulty. Type 'normal', 'hard', or 'insane' to begin: ")
    switch (difficultyLevel) {
        case 'normal':
            entryError = false
            break
        case 'hard':
            entryError = false
            difficultyMod = 2
            break
        case 'insane':
            entryError = false
            difficultyMod = 6
            break
        case 'debug':
            entryError = false
            break
    }
    if(entryError) alert("There is no difficulty lavel with this name. Please choose again.")
    else break
}

// Difficulty Setting---------------------------------------------------
{
    for (let i = 0; i < enemies.length; i++) {
        enemies[i].tick = Math.floor(enemies[i].tick / Math.sqrt(difficultyMod))
        enemies[i].speed = Math.floor(enemies[i].speed * difficultyMod)
    }

    if (difficultyLevel == 'debug'){
        console.log("Debug Mode On")
        playerShip.body.setAttribute("x", 200)
        playerShip.body.setAttribute("y", 200)
        
        leftZoomer.body.setAttribute("x", 200)
        leftZoomer.body.setAttribute("y", 400)

        bottomZoomer.body.setAttribute("x", 350)
        bottomZoomer.body.setAttribute("y", 400)

        rightZoomer.body.setAttribute("x", 500)
        rightZoomer.body.setAttribute("y", 400)

        topBlocker.body.setAttribute("x", 650)
        topBlocker.body.setAttribute("y", 400)

        window.stop()
    }
}
// Game Events --------------------------------------------------------- 
{
    window.addEventListener('mousemove', (event)=>{
        if(event.clientX < boardMarginX + playerShip.width) {trackingPointX = boardMarginX} else
        if(event.clientX > boardMarginX + boardWidth - playerShip.width) {trackingPointX = boardMarginX + boardWidth - 2*playerShip.width} else
        trackingPointX = event.clientX - playerShip.width

        if(event.clientY < boardMarginY + playerShip.height) {trackingPointY = boardMarginY} else
        if(event.clientY > boardMarginY + boardHeight - playerShip.height) {trackingPointY = boardMarginY + boardHeight - 2*playerShip.height} else
        trackingPointY = event.clientY - playerShip.height
    } )

    window.addEventListener('click', ()=>{
        gameLoop = true})
        

    function collisionEvent(){
        playerShip.health --;
        playerShip.immune = true
        gameLoop=false
        setTimeout(() => gameLoop = true, 1000)
        setTimeout(() => playerShip.immune = false, 2000)
    }

    function decreaseLife() {
        document.getElementById('lives').setAttribute('width', (hpMeterWidth -200))
        hpMeterWidth -= 200
    }

    function addPoints() {
        if(!clockPause){
            points += 10
            clockPause = true
            document.getElementById('points').textContent = points
            setTimeout(() => clockPause = false, 500)
        }
    }
    

}
//Board Preparation ----------------------------------------------------
{
    if (difficultyLevel != 'debug'){
        playerShip.body.setAttribute("x", (boardWidth + boardMarginX) / 2 )
        playerShip.body.setAttribute("y", (boardHeight + boardMarginY) / 2 )

        for (let i = 0; i < enemies.length; i++) {
            enemies[i].body.setAttribute("x", 100000)
            enemies[i].body.setAttribute("y", 103000)
        }
    }
    

}


console.log(enemies[0].tick, enemies[1].tick, enemies[2].tick, enemies[3].tick)

// GAME LOOP: ==========================================================


async function Mainloop(timestamp) {
    if (gameLoop)
    {
        timer ++
        //console.log(timer)
        if (timer == 1000) timer = 0

        if (!(timer % leftZoomer.tick) && timer != 0) {
            leftZoomer.body.setAttribute("x", 0)
            leftZoomer.body.setAttribute("y", Math.floor(Math.random() * 1500)-300)
            console.log("Eenemy 1 respawn on tick: ", timer)
        }

        if (!(timer % bottomZoomer.tick)) {
            bottomZoomer.body.setAttribute("x", Math.floor(Math.random() * 1100)-100)
            bottomZoomer.body.setAttribute("y", 2000)
            console.log("Eenemy 2 respawn on tick: ", timer)
        }
        
        if (!(timer % rightZoomer.tick)) {
            rightZoomer.body.setAttribute("x", 1400)
            rightZoomer.body.setAttribute("y", 1000 - Math.floor(Math.random() * 1300))
            console.log("Eenemy 3 respawn on tick: ", timer)
        }

        if ((timer == topBlocker.tick)) {
            topBlocker.body.setAttribute("x", playerShip.body.getAttribute("x") - 200)
            topBlocker.body.setAttribute("y", -210)
            console.log("Eenemy 4 respawn on tick: ", timer)
        }
        
        playerShip.updatePosition(trackingPointX, trackingPointY)

        leftZoomer.updatePosition()
        bottomZoomer.updatePosition()
        rightZoomer.updatePosition()
        topBlocker.updatePosition()

        addPoints()

        if(playerShip.isCollidingWith(leftZoomer) && playerShip.immune == false) {
            collisionEvent()
            console.log("Collision!")
            decreaseLife()
            if(playerShip.health <= 0) {gameOver = true}
        }
        if(playerShip.isCollidingWith(bottomZoomer) && playerShip.immune == false) {
            collisionEvent()
            console.log("Collision!")
            decreaseLife()
            if(playerShip.health <= 0) {gameOver = true}
        }
        if(playerShip.isCollidingWith(rightZoomer) && playerShip.immune == false) {
            collisionEvent()
            console.log("Collision!")
            decreaseLife()
            if(playerShip.health <= 0) {gameOver = true}
        }
        if(playerShip.isCollidingWith(topBlocker) && playerShip.immune == false) {
            collisionEvent()
            console.log("Collision!")
            decreaseLife()
            if(playerShip.health <= 0) {gameOver = true}
        }
        if(gameOver){
            document.getElementById('hpState').textContent = "Game Over"
            return
        }
    }
    lastRender = timestamp;
    window.requestAnimationFrame(Mainloop);

}
let lastRender = 0;
window.requestAnimationFrame(Mainloop);

