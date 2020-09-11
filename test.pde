var killLag = true;








//BEGIN CODE
frameRate(60);

//x, y, xvel, yvel, left open, right open, down open, up open
var player = [50, 325, 0.01, 0, true, true, true, true];

//is dead? how long until alive?
var death = [false, 0];

//for the dying animation
var dying = [false, -10];

//big, invincible, fireflower
var powerups = [false, false, false];

//a variable which is 25 when mario is bigger, in order to keep from haveing too much code (ifs)
var yInc = 0;

//a timer for how long mario is invincible
var invincible = 0;

//a timer for the few frames mario has to recover
var recover = 0;

//whether or not he is jumping (used for the sprites)
var jump = false;

//the directional mario faces
var goingLeft = false;

//a currently empty array of blocks which will later hold a list of all the walls
var blocks = [];

//a currently empty array for the items inn the background
var bkgrdBlocks = [];

//an array of the different types of enemies
var enemy = [];

//an array for all the coins
var coins = [];

//an array for all the pipes
var pipes = [];

//current level
var levelNum = 0;

//for underground parts of a level or things like
var lvlStage = 0;

//used to set up at the beginning of a level
var first = true;

//where the flag is (starts out way far, so that if you don't define it, you can't finish!)
var endX = 10000000;

//whether or not the player has crossed the flag
var endLevel = false;

//whether or not the player is going between tubes
var pipeMov = [false, 0, 0, 0, 0, 0, false];

//where you translate it
var translatePos = 0;

//the score you currently have (high score purposes)
var score = 0;

//the score when you finished a level or something
var savedScore = 0;

//text version of the score (to be displayed)
var scoreText;

//the time until you automatically die
var timeLeft = 400;

//text version
var timeLeftText;

//how many coins you have
var coin = 0;

//when after player dies, this is run once!
var playerReset = false;

//how many lives mario has remaining
var lives = 3;

//how many consecutive jumps that are earned
var enemyCount = 0;

//how much the flag has come down
var flagY = 0;

//variable for when you click keys
var keys = [];

//a variable for only the first frame that you click
var firstClick = [];

//an array of all the items that are bouning up from question blocks
var qAnimation = [];

//array for the animation (or still sprite) of a goomba after it dies
var deadGoomba = [];

//a timer for mario's movements
var timer = 0;

//stores images of all the bkgrd values
var bkgrdImage = [];

//stored images for all of the brick types, including the 3 different color schemes
var blockImage = [[], [], [], [], []];

//text font (ITS EXACT!!!!)
var txt = function (message, x, y) {

    //setup
    pushMatrix ();
    stroke(255, 255, 255); //stroke to keep away from gaps
    strokeWeight(0.1);
    fill (255, 255, 255);
    translate (x, y);
    scale (25 / 16);

    for (var a = 0; a < message.length; a ++) {//actual letters

        var letter = message.charAt(a);

        if (letter === "A") {
            rect (2, 0, 3, 1);
            rect (1, 1, 2, 1);
            rect (4, 1, 2, 1);
            rect (0, 2, 2, 5);
            rect (5, 2, 2, 5);
            rect (2, 4, 3, 1);
        }
        else if (letter === "B") {
            rect (0, 0, 2, 7);
            rect (2, 0, 4, 1);
            rect (2, 3, 4, 1);
            rect (2, 6, 4, 1);
            rect (5, 1, 2, 2);
            rect (5, 4, 2, 2);
        }
        else if (letter === "C") {
            rect (2, 0, 4, 1);
            rect (1, 1, 2, 1);
            rect (5, 1, 2, 1);
            rect (0, 2, 2, 3);
            rect (1, 5, 2, 1);
            rect (5, 5, 2, 1);
            rect (2, 6, 4, 1);
        }
        else if (letter === "D") {
            rect (0, 0, 2, 7);
            rect (2, 0, 3, 1);
            rect (2, 6, 3, 1);
            rect (4, 1, 2, 1);
            rect (4, 5, 2, 1);
            rect (5, 2, 2, 3);
        }
        else if (letter === "E") {
            rect (0, 0, 2, 7);
            rect (2, 0, 5, 1);
            rect (2, 6, 5, 1);
            rect (2, 3, 4, 1);
        }
        else if (letter === "F") {
            rect (0, 0, 2, 7);
            rect (2, 0, 5, 1);
            rect (2, 3, 4, 1);
        }
        else if (letter === "G") {
            rect (2, 0, 5, 1);
            rect (1, 1, 2, 1);
            rect (0, 2, 2, 3);
            rect (1, 5, 2, 1);
            rect (2, 6, 3, 1);
            rect (5, 4, 2, 3);
            rect (4, 3, 3, 1);
        }
        else if (letter === "H") {
            rect (0, 0, 2, 7);
            rect (2, 3, 3, 1);
            rect (5, 0, 2, 7);
        }
        else if (letter === "I") {
            rect (1, 0, 6, 1);
            rect (1, 6, 6, 1);
            rect (3, 1, 2, 5);
        }
        else if (letter === "J") {
            rect (5, 0, 2, 6);
            rect (1, 6, 5, 1);
            rect (0, 4, 2, 2);
            rect (3, 0, 2, 1);
        }
        else if (letter === "K") {
            rect (0, 0, 2, 7);
            rect (2, 3, 2, 2);
            rect (3, 2, 2, 1);
            rect (4, 1, 2, 1);
            rect (5, 0, 2, 1);
            rect (3, 5, 3, 1);
            rect (4, 6, 3, 1);
            rect (4, 4, 1, 1);
        }
        else if (letter === "L") {
            rect (1, 0, 2, 7);
            rect (3, 6, 4, 1);
        }
        else if (letter === "M") {
            rect (0, 0, 2, 7);
            rect (5, 0, 2, 7);
            rect (2, 1, 1, 3);
            rect (4, 1, 1, 3);
            rect (3, 2, 1, 3);
        }
        else if (letter === "N") {
            rect (0, 0, 2, 7);
            rect (5, 0, 2, 7);
            rect (2, 1, 1, 3);
            rect (4, 3, 1, 3);
            rect (3, 2, 1, 3);
        }
        else if (letter === "O") {
            rect (0, 1, 2, 5);
            rect (5, 1, 2, 5);
            rect (1, 0, 5, 1);
            rect (1, 6, 5, 1);
        }
        else if (letter === "P") {
            rect (0, 0, 2, 7);
            rect (2, 0, 4, 1);
            rect (5, 1, 2, 3);
            rect (2, 4, 4, 1);
        }
        else if (letter === "Q") {
            rect (1, 0, 5, 1);
            rect (0, 1, 2, 5);
            rect (1, 6, 4, 1);
            rect (5, 1, 2, 3);
            rect (3, 4, 4, 1);
            rect (4, 5, 2, 1);
            rect (6, 6, 1, 1);
        }
        else if (letter === "R") {
            rect (0, 0, 2, 7);
            rect (2, 0, 4, 1);
            rect (5, 1, 2, 3);
            rect (4, 3, 1, 1);
            rect (2, 4, 3, 1);
            rect (3, 5, 3, 1);
            rect (4, 6, 3, 1);
        }
        else if (letter === "S") {
            rect (1, 0, 4, 1);
            rect (4, 1, 2, 1);
            rect (0, 1, 2, 2);
            rect (1, 3, 5, 1);
            rect (5, 4, 2, 2);
            rect (1, 6, 5, 1);
            rect (0, 5, 2, 1);
        }
        else if (letter === "T") {
            rect (1, 0, 6, 1);
            rect (3, 1, 2, 6);
        }
        else if (letter === "U") {
            rect (0, 0, 2, 6);
            rect (1, 6, 5, 1);
            rect (5, 0, 2, 6);
        }
        else if (letter === "V") {
            rect (0, 0, 1, 4);
            rect (1, 0, 1, 5);
            rect (2, 3, 1, 3);
            rect (3, 4, 1, 3);
            rect (4, 3, 1, 3);
            rect (5, 0, 1, 5);
            rect (6, 0, 1, 4);
        }
        else if (letter === "W") {
            rect (0, 0, 2, 7);
            rect (5, 0, 2, 7);
            rect (2, 3, 1, 3);
            rect (3, 2, 1, 3);
            rect (4, 3, 1, 3);
        }
        else if (letter === "X") {
            rect (0, 0, 2, 1);
            rect (5, 0, 2, 1);
            rect (0, 1, 3, 1);
            rect (4, 1, 3, 1);
            rect (1, 2, 5, 1);
            rect (2, 3, 3, 1);
            rect (1, 4, 5, 1);
            rect (0, 5, 3, 1);
            rect (4, 5, 3, 1);
            rect (0, 6, 2, 1);
            rect (5, 6, 2, 1);
        }
        else if (letter === "Y") {
            rect (1, 0, 2, 3);
            rect (5, 0, 2, 3);
            rect (2, 3, 4, 1);
            rect (3, 4, 2, 3);
        }
        else if (letter === "Z") {
            rect (0, 0, 7, 1);
            rect (4, 1, 3, 1);
            rect (3, 2, 3, 1);
            rect (2, 3, 3, 1);
            rect (1, 4, 3, 1);
            rect (0, 5, 3, 1);
            rect (0, 6, 7, 1);
        }
        else if (letter === "0") {
            rect (0, 2, 2, 3);
            rect (1, 1, 1, 1);
            rect (1, 5, 2, 1);
            rect (2, 0, 3, 1);
            rect (2, 6, 3, 1);
            rect (4, 1, 2, 1);
            rect (5, 2, 2, 3);
            rect (5, 5, 1, 1);
        }
        else if (letter === "1") {
            rect (1, 6, 6, 1);
            rect (2, 1, 1, 1);
            rect (3, 0, 2, 6);
        }
        else if (letter === "2") {
            rect (0, 1, 2, 1);
            rect (0, 5, 2, 1);
            rect (0, 6, 7, 1);
            rect (1, 0, 5, 1);
            rect (1, 4, 4, 1);
            rect (2, 3, 4, 1);
            rect (4, 2, 3, 1);
            rect (5, 1, 2, 1);
        }
        else if (letter === "3") {
            rect (1, 0, 6, 1);
            rect (0, 5, 2, 1);
            rect (1, 6, 5, 1);
            rect (2, 3, 4, 1);
            rect (3, 2, 2, 1);
            rect (4, 1, 2, 1);
            rect (5, 4, 2, 2);
        }
        else if (letter === "4") {
            rect (0, 3, 2, 1);
            rect (0, 4, 7, 1);
            rect (1, 2, 2, 1);
            rect (2, 1, 4, 1);
            rect (3, 0, 3, 1);
            rect (4, 2, 2, 2);
            rect (4, 5, 2, 2);
        }
        else if (letter === "5") {
            rect (0, 0, 6, 1);
            rect (0, 1, 2, 1);
            rect (0, 2, 6, 1);
            rect (0, 5, 2, 1);
            rect (1, 6, 5, 1);
            rect (5, 3, 2, 3);
        }
        else if (letter === "6") {
            rect (2, 0, 4, 1);
            rect (1, 1, 2, 1);
            rect (0, 2, 2, 4);
            rect (2, 3, 4, 1);
            rect (5, 4, 2, 2);
            rect (1, 6, 5, 1);
        }
        else if (letter === "7") {
            rect (0, 0, 7, 1);
            rect (0, 1, 2, 1);
            rect (2, 4, 2, 3);
            rect (3, 3, 2, 1);
            rect (4, 2, 2, 1);
            rect (5, 1, 2, 1);
        }
        else if (letter === "8") {
            rect (1, 0, 5, 1);
            rect (0, 1, 2, 2);
            rect (5, 1, 2, 2);
            rect (1, 3, 5, 1);
            rect (0, 4, 2, 2);
            rect (5, 4, 2, 2);
            rect (1, 6, 5, 1);
        }
        else if (letter === "9") {
            rect (0, 1, 2, 2);
            rect (1, 0, 5, 1);
            rect (1, 3, 4, 1);
            rect (1, 6, 4, 1);
            rect (4, 5, 2, 1);
            rect (5, 1, 2, 4);
        }
        else if (letter === "!") {
            rect (3, 0, 2, 6);
            rect (2, 1, 4, 3);
            rect (3, 7, 2, 1);
        }
        else if (letter === "-") {
            rect (1, 3, 6, 2);
        }
        else if (letter === "©") {
            rect (2, 0, 4, 1);
            rect (1, 1, 1, 1);
            rect (0, 2, 1, 4);
            rect (1, 6, 1, 1);
            rect (2, 7, 4, 1);
            rect (6, 6, 1, 1);
            rect (7, 2, 1, 4);
            rect (6, 1, 1, 1);
            rect (3, 2, 2, 1);
            rect (2, 3, 1, 2);
            rect (3, 5, 2, 1);
        }
        else if (letter === "×") {
            rect (1, 2, 1, 1);
            rect (2, 3, 1, 1);
            rect (3, 4, 1, 1);
            rect (4, 5, 1, 1);
            rect (5, 6, 1, 1);
            rect (5, 2, 1, 1);
            rect (4, 3, 1, 1);
            rect (2, 5, 1, 1);
            rect (1, 6, 1, 1);
        }

        translate (8, 0);

    }

    popMatrix ();

    noStroke();

};

//mario in his SMALL phase
var smallMario = function(type, x, y, turn) {

    pushMatrix();

    var color1 = color(106, 107, 4);
    var color2 = color(177, 52, 37);
    var color3 = color(227, 157, 37);

    noStroke (); //gets rid of stroke

    if (turn) {

        translate (x + 25, y); //moves to designated x and y, but 25 more
        scale(-25/16, 25/16); //after flipping, it returns to proper x and y - also scaled

    } else {

        translate (x, y); //moves to designated x and y
        scale(25/16); //no flip, just scaled to proper size

    }

    //variable specifying how much to movee the head, initially none
    var headPos = 0;

    if (type === 2 | type === 5) { //for the first running sequence animation (legs close) and jumping

        headPos = 1; //changes translate amount to 1

    }

    if (type !== 6) {

        //the head (basically the same for all the sprites
        pushMatrix();

        translate (headPos, headPos); //unless headPos = 0, it goes down 1 and to the right 1

        //hair and eyes
        fill (color1); // draws the green at the back bc it minimizes the number of rect()
        rect (3, 3, 10, 3); //green everywhere else
        rect (4, 2, 6, 1); //top of hair and top of eye (green right under hat)

        //hat
        fill (color2); //red
        rect (5, 0, 5, 1); //top
        rect (4, 1, 9, 1); //bottom

        //skin
        fill (color3);
        rect (4, 3, 1, 2); //ear (at the very left)
        rect (5, 5, 2, 2); //back of chin (bottom left)
        rect (7, 2, 2, 5); //entire middle of face (direct left of eye)
        rect (6, 3, 1, 1); //little one by one between ear and middle of face
        rect (9, 4, 1, 1); //little one by one to the direct right of the middle of face
        rect (9, 6, 3, 1); //front of chin (bottom right)
        rect (10, 2, 1, 1); //top of nose, right under front of hat
        rect (10, 3, 3, 1); //middle of nose
        rect (11, 4, 3, 1); //bottom of nose

        popMatrix();

    }

    //draws the different bodies, different each time
    //NOTE: left and right is from OUR perspective not mario's!

    //standing still
    if (type === 1) {

        //green non overall clothes
        fill (color1);
        rect (4, 7, 6, 1); //draws the top part
        rect (3, 8, 10, 1);
        rect (2, 9, 12, 2);
        rect (3, 14, 3, 2); //left shoe top
        rect (2, 15, 1, 1); //left shoe bottom
        rect (10, 14, 3, 2); //right shoe top
        rect (13, 15, 1, 1); //right shoe bottom

        //red overalls
        fill (color2);
        rect (4, 12, 3, 2); //the pants part, right above the left shoe
        rect (9, 12, 3, 2); //other pants part, right above the right shoe
        rect (5, 10, 6, 2); //main overalls, about at hand height
        rect (7, 9, 2, 4); //middle of overalls, goes all the way from top to bottom
        rect (6, 7, 1, 3); //left overalls strap
        rect (9, 8, 1, 2); //right overalls strap

        //tan hands and buttons on overalls
        fill (color3);
        rect (2, 10, 2, 3); //left hand
        rect (4, 11, 1, 1); //left thumb
        rect (6, 10, 1, 1); //left button
        rect (9, 10, 1, 1); //right button
        rect (11, 11, 1, 1); //right tjumb
        rect (12, 10, 2, 3); //right hand

    } else if (type === 2) { //beginning running, with feet fairly close together

        //green non overalls part
        fill (color1);
        rect (2, 13, 1, 2); //top of shoe on VERY left
        rect (3, 11, 2, 3); //main part of shoe on very left
        rect (5, 8, 6, 3); //main part of body in the middle top
        rect (7, 14, 3, 2); //main right shoe
        rect (10, 15, 1, 1); //tip of right shoe

        //red overalls and part of the strap
        fill (color2);
        rect (9, 8, 1, 1); //little square - probably the strap, but not completely shown
        rect (5, 10, 1, 1); //top of the overalls near left hand
        rect (5, 11, 7, 2); //main overalls in middle
        rect (4, 12, 3, 2); //left part, near left shoe
        rect (8, 12, 3, 2); //right part, near right shoe

        fill (color3);
        rect (3, 10, 2, 1);
        rect (4, 9, 1, 1);
        rect (11, 9, 2, 2);
        rect (12, 8, 1, 1);
        rect (13, 9, 1, 1);

    } else if (type === 3) { //another in running sequence, but his legs are completely together, touching

        //non overalls part and shoes
        fill (color1);
        rect (4, 7, 6, 1); //very top
        rect (3, 8, 8, 4); //middle of overalls
        rect (5, 12, 4, 4); //left shoe and a part of shirt sleev
        rect (9, 13, 2, 2); //right shoe, main
        rect (11, 14, 1, 1); //right shoe, top

        //overalls
        fill (color2);
        rect (6, 7, 1, 1); //very top, overalls strap
        rect (7, 8, 2, 1); //overalls strap, main
        rect (6, 9, 1, 1); //overalls in middle, near left arm
        rect (11, 10, 1, 2); //overalls at the VERY right
        rect (7, 9, 4, 4); //main overalls
        rect (5, 13, 3, 1); //overalls at bottom
        rect (4, 12, 1, 1); //overalls at the VERY left
        rect (3, 11, 1, 1);

        //hands and button
        fill (color3);
        rect (6, 11, 2, 2); //main part of left hand
        rect (8, 11, 1, 1); //left hand finger
        rect (8, 9, 1, 1); //left button
        rect (11, 9, 1, 1); //right button

    } else if (type === 4) { //legs WIDE apart

        //green sleeves and shoes
        fill (color1);
        rect (2, 7, 8, 2); //top of the sleeves
        rect (4, 8, 9, 2); //bottom of the sleeves (overlaps top a little)
        rect (12, 11, 2, 3); //main right shoe
        rect (13, 10, 1, 1); //tip of right shoe
        rect (1, 13, 3, 2); //main left shoe
        rect (2, 15, 3, 1); //tip of left shoe

        //red overalls
        fill (color2);
        rect (6, 7, 2, 1); //middle top of overalls
        rect (6, 8, 3, 5); //main overalls in middle
        rect (9, 9, 2, 5); //overalls on right
        rect (11, 11, 1, 3); //overalls on VERY right, next to shoe
        rect (4, 10, 2, 3); //main overalls on right
        rect (3, 11, 3, 3); //main overalls on left
        rect (2, 12, 1, 1); //tip of overalls, VERY left

        //hands and button
        fill (color3);
        rect (0, 8, 2, 3); //left hand
        rect (2, 9, 1, 1); //left thumb
        rect (7, 9, 1, 1); //right thumb
        rect (13, 8, 2, 2); //right hand
        rect (12, 8, 1, 1); //button

    } else if (type === 5) { //jumping!

        //sleeves and shoes and shirt
        fill (color1);
        rect (13, 3, 3, 2); //top left, sleeve
        rect (14, 6, 1, 1); //arm, not all drawn because the head covers it
        rect (15, 5, 1, 1);
        rect (13, 7, 1, 1);
        rect (2, 8, 11, 1); //top of the body, near neck
        rect (1, 9, 12, 2); //draws the rest of the sleeves
        rect (4, 11, 12, 3); //draws parts of the shoes
        rect (15, 9, 1, 2); //tip of right shoe
        rect (3, 12, 1, 3); //left shoe
        rect (2, 13, 1, 2);
        rect (1, 14, 1, 2);

        //red overalls
        fill (color2);
        rect (7, 8, 1, 1); //top of the overall straps
        rect (11, 8, 1, 1);
        rect (8, 9, 1, 2); //overalls strap
        rect (12, 9, 1, 2);
        rect (9, 10, 3, 1); //overalls top
        rect (7, 11, 7, 3); //main overalls
        rect (4, 11, 2, 2); //overalls near left shoe
        rect (5, 12, 6, 3); //main overalls on left side
        rect (4, 14, 4, 2); //overalls at bottom left

        //hands and buttons
        fill (color3);
        rect (13, 0, 3, 2); //right hand
        rect (14, 2, 2, 1); //right thumb
        rect (0, 10, 2, 2); //left hand
        rect (1, 12, 1, 1); //left finger
        rect (2, 11, 1, 1); //left thumb
        rect (9, 11, 1, 1); //left button
        rect (12, 11, 1, 1); //right button

    } else if (type === 6) { //thumbs UP! (dead!!!!)

        fill(color1); //hat and overalls
        rect(3, 2, 10, 4);
        rect(4, 6, 8, 3);
        rect(2, 9, 12, 4);
        rect(3, 13, 10, 1);

        fill(color2); //face and hands
        rect(6, 0, 4, 1);
        rect(5, 1, 6, 1);
        rect(3, 8, 3, 1);
        rect(4, 9, 2, 1);
        rect(5, 10, 2, 4);
        rect(7, 11, 2, 3);
        rect(9, 10, 2, 4);
        rect(10, 9, 2, 1);
        rect(10, 8, 3, 1);

        fill(color3); //hair and clothes
        rect(1, 2, 2, 3);
        rect(3, 1, 1, 2);
        rect(12, 1, 1, 2);
        rect(13, 2, 2, 3);
        rect(5, 2, 1, 2);
        rect(7, 2, 2, 4);
        rect(10, 2, 1, 2);
        rect(6, 4, 4, 1);
        rect(5, 6, 1, 1);
        rect(5, 7, 6, 1);
        rect(6, 8, 4, 1);
        rect(10, 6, 1, 1);
        rect(6, 11, 1, 1);
        rect(9, 11, 1, 1);

    }

    popMatrix();

};

//mario in his BIG phase
var bigMario = function (type, x, y, flip) {

    pushMatrix();

    if (flip) {

        translate(x + 25, y);
        scale(-25/16, 25/16);

    } else {

        translate(x, y);
        scale(25/16);

    }

    var color1 = color (106, 107, 4);
    var color2 = color (177, 52, 37);
    var color3 = color (227, 157, 37);

    if (type !== 6) {

        var a = 0;
        var b = 0;

        if (type === 2) {

            b = 2;
            a = 1;

        }
        if (type === 3) {

            b = 1;

        }
        if (type === 5) {

            b = 2;

        }

        pushMatrix ();
        translate (a, b);

        fill (color1);
        rect (4, 4, 8, 7);//hair and eyes
        rect (2, 5, 12, 5);
        if (type !== 5) {

            rect (1, 7, 2, 2);

        }
        rect (3, 4, 2, 1);
        if (type === 1 | type === 4) {

            rect (1, 7, 2, 3);

        }
        if (type === 1 | type === 3 | type === 4) {

            rect (3, 9, 1, 2);
            rect (3, 10, 2, 1);

        }

        fill (color2);
        rect (3, 3, 11, 1);//hat
        rect (3, 2, 8, 2);
        rect (4, 1, 7, 3);
        rect (6, 0, 5, 4);

        fill (color3);
        rect (3, 5, 2, 4);//ear
        rect (4, 8, 4, 2);//face
        rect (5, 9, 4, 2);
        rect (6, 4, 2, 2);
        rect (7, 4, 1, 6);
        rect (8, 6, 6, 1);
        rect (7, 6, 3, 2);
        rect (8, 10, 5, 1);
        rect (9, 4, 3, 1);
        rect (10, 4, 2, 2);
        rect (10, 5, 4, 2);//nose
        rect (11, 6, 4, 2);
        rect (9, 2, 2, 1);//yellow on hat
        rect (10, 1, 1, 2);

        popMatrix ();

    }

    if (type === 1) {

        fill (color1);
        rect (4, 11, 7, 2);//arms and chest
        rect (4, 10, 1, 2);
        rect (4, 12, 8, 2);
        rect (3, 13, 10, 2);
        rect (2, 14, 12, 5);
        rect (1, 15, 14, 3);
        rect (0, 17, 16, 3);
        rect (0, 30, 6, 2);//left shoe
        rect (2, 28, 4, 4);
        rect (10, 30, 6, 2);//right shoe
        rect (10, 28, 4, 4);

        fill (color2);
        rect (5, 12, 1, 4);//overalls
        rect (4, 16, 2, 2);
        rect (4, 18, 8, 6);
        rect (10, 12, 1, 4);
        rect (10, 16, 2, 2);
        rect (3, 23, 10, 2);//pants
        rect (2, 24, 12, 1);
        rect (1, 25, 6, 1);
        rect (1, 25, 5, 3);
        rect (9, 25, 6, 1);
        rect (10, 25, 5, 3);
        rect (2, 24, 5, 2);
        rect (9, 24, 5, 2);

        fill (color3);
        rect (5, 10, 5, 2);//neck
        rect (0, 20, 4, 2);//left hand
        rect (1, 21, 3, 2);
        rect (1, 22, 2, 2);
        rect (12, 20, 4, 2);//right hand
        rect (12, 21, 3, 2);
        rect (13, 22, 2, 2);
        rect (5, 19, 1, 1);//buttons
        rect (10, 19, 1, 1);

    }
    if (type === 2) {

        fill (color1);
        rect (4, 13, 6, 14);//shirt
        rect (4, 13, 1, 2);
        rect (3, 14, 7, 13);
        rect (2, 15, 10, 3);
        rect (9, 14, 2, 2);
        rect (0, 24, 4, 5);//left shoe
        rect (0, 24, 2, 6);
        rect (0, 24, 1, 7);
        rect (3, 16, 10, 11);//more shirt
        rect (9, 26, 4, 6);//right shoe
        rect (9, 30, 6, 2);

        fill (color2);
        rect (5, 13, 3, 1);//overalls
        rect (4, 14, 1, 4);
        rect (3, 16, 2, 8);
        rect (4, 18, 2, 9);
        rect (5, 20, 2, 7);
        rect (6, 21, 3, 5);
        rect (6, 25, 2, 2);
        rect (8, 22, 3, 3);
        rect (8, 22, 4, 2);
        rect (8, 22, 5, 1);
        rect (12, 21, 1, 2);
        rect (8, 14, 1, 1);
        rect (9, 15, 1, 1);
        rect (10, 16, 2, 1);
        rect (9, 26, 4, 2);
        rect (11, 25, 2, 3);
        rect (12, 24, 2, 2);

        fill (color3);
        rect (8, 12, 3, 2);//hand
        rect (12, 16, 2, 3);
        rect (13, 17, 3, 4);

    }
    if (type === 3) {

        fill (color1);
        rect (3, 13, 8, 10);//shirt
        rect (2, 14, 9, 9);
        rect (4, 15, 8, 11);
        rect (11, 24, 2, 1);//top shoe
        rect (5, 25, 6, 3);
        rect (10, 27, 2, 2);
        rect (5, 27, 4, 4);//bottom shoe
        rect (4, 29, 2, 2);
        rect (6, 30, 5, 2);

        fill (color2);
        rect (4, 12, 4, 1);//overalls
        rect (4, 12, 1, 2);
        rect (7, 12, 1, 2);
        rect (7, 13, 2, 1);
        rect (8, 13, 1, 2);
        rect (8, 14, 2, 3);
        rect (9, 16, 2, 1);
        rect (3, 14, 1, 6);
        rect (2, 19, 2, 4);
        rect (3, 20, 2, 4);
        rect (4, 21, 2, 5);
        rect (4, 22, 3, 3);
        rect (4, 22, 4, 2);
        rect (5, 22, 1, 5);
        rect (5, 26, 2, 1);
        rect (6, 26, 1, 2);
        rect (6, 27, 3, 1);
        rect (10, 20, 4, 3);
        rect (11, 19, 2, 5);

        fill (color3);
        rect (8, 11, 2, 2);//hand
        rect (8, 18, 3, 4);
        rect (9, 17, 2, 3);
        rect (9, 18, 3, 3);

    }
    if (type === 4) {

        fill (color1);
        rect (5, 11, 5, 16);//shirt
        rect (3, 13, 9, 6);
        rect (2, 14, 12, 5);
        rect (13, 14, 2, 4);
        rect (14, 14, 2, 3);
        rect (1, 15, 2, 5);
        rect (0, 18, 9, 2);
        rect (0, 26, 6, 3);//left shoe
        rect (1, 26, 3, 5);
        rect (2, 31, 3, 1);
        rect (2, 30, 2, 2);
        rect (2, 25, 2, 2);
        rect (3, 24, 3, 2);
        rect (11, 23, 5, 5);//right shoe
        rect (14, 22, 2, 2);
        rect (15, 21, 1, 2);

        fill (color2);
        rect (4, 12, 4, 1);//overalls
        rect (7, 12, 1, 2);
        rect (7, 13, 2, 1);
        rect (8, 13, 1, 2);
        rect (8, 14, 2, 13);
        rect (8, 18, 3, 9);
        rect (10, 12, 1, 1);
        rect (11, 13, 1, 2);
        rect (4, 19, 9, 4);
        rect (12, 15, 1, 5);
        rect (7, 17, 2, 2);
        rect (6, 18, 2, 2);
        rect (4, 22, 6, 2);
        rect (5, 23, 5, 2);
        rect (6, 24, 4, 2);
        rect (3, 24, 1, 3);
        rect (3, 25, 2, 2);
        rect (4, 26, 2, 2);
        rect (5, 27, 1, 2);
        rect (5, 27, 3, 1);

        fill (color3);
        rect (8, 10, 2, 2);//left hand
        rect (0, 20, 5, 2);
        rect (0, 20, 4, 3);
        rect (1, 20, 3, 4);
        rect (13, 13, 3, 3);//right hand
        rect (14, 12, 1, 5);
        rect (12, 18, 1, 1);//buttons
        rect (9, 18, 1, 1);

    }
    if (type === 5) {

        fill (color1);
        rect (1, 10, 2, 2);//hair correction
        rect (3, 11, 2, 2);
        rect (11, 1, 5, 4);
        rect (14, 1, 2, 7);
        rect (12, 6, 3, 1);
        rect (15, 6, 1, 4);
        rect (14, 10, 1, 4);
        rect (13, 12, 2, 2);
        rect (13, 12, 1, 4);
        rect (4, 13, 10, 3);
        rect (1, 14, 12, 7);
        rect (0, 15, 2, 5);
        rect (0, 25, 2, 6);//left shoe
        rect (0, 25, 7, 5);
        rect (3, 24, 1, 2);
        rect (6, 26, 2, 1);
        rect (12, 23, 4, 5);//right shoe
        rect (14, 22, 2, 2);
        rect (15, 21, 1, 2);

        fill (color2);
        rect (6, 2, 5, 4);//hat correction
        rect (4, 13, 4, 1);//overalls
        rect (7, 13, 1, 2);
        rect (7, 14, 2, 1);
        rect (8, 14, 1, 3);
        rect (8, 16, 2, 3);
        rect (7, 18, 4, 2);
        rect (6, 19, 7, 4);
        rect (10, 13, 1, 2);
        rect (11, 15, 1, 2);
        rect (12, 17, 1, 2);
        rect (3, 20, 9, 4);
        rect (4, 23, 2, 2);
        rect (6, 23, 2, 3);
        rect (8, 23, 2, 4);
        rect (10, 23, 2, 5);
        rect (3, 25, 1, 3);
        rect (3, 26, 3, 4);
        rect (3, 27, 4, 3);
        rect (3, 27, 5, 2);

        fill (color3);
        rect (9, 6, 1, 3);//face correction (plastic surgery?)
        rect (13, 11, 1, 1);
        rect (0, 19, 1, 3);//left hand
        rect (0, 19, 5, 2);
        rect (1, 18, 4, 3);
        rect (2, 17, 2, 5);
        rect (2, 17, 1, 6);
        rect (1, 22, 2, 1);
        rect (11, 1, 2, 3);//right hand
        rect (12, 0, 3, 1);
        rect (12, 0, 1, 2);
        rect (14, 0, 1, 2);
        rect (14, 1, 2, 1);
        rect (15, 1, 1, 3);
        rect (11, 3, 5, 1);
        rect (9, 19, 1, 1);//buttons
        rect (12, 18, 1, 1);

    }

    //Colors:
    //color2 - red
    //color3 - yellow
    //color1 - brownish greenish

    popMatrix ();

};

//a function for powerups like coins and mushrooms
var powerUp = function (x, y, type) {

    pushMatrix();

    translate(x, y); //moves to x and y pos
    scale (25/16); //scales to 25 by 25

    if (type === 1) { //mushroom

        fill (230, 156, 33);
        for (var x = 0; x < 6; x ++) {

            rect (6 - x, x, 4 + 2 * x, 1);

        }

        rect (1, 6, 14, 6);
        rect (0, 7, 16, 4);

        fill (181, 49, 33);
        rect (2, 6, 5, 3);
        rect (3, 5, 3, 5);
        rect (2, 11, 3, 1);
        rect (12, 7, 2, 2);
        rect (13, 8, 2, 2);
        rect (8, 2, 1, 2);
        rect (9, 1, 2, 4);
        rect (11, 2, 1, 3);
        rect (12, 3, 1, 1);
        rect (11, 11, 3, 1);

        fill (252, 252, 252);
        rect (4, 12, 8, 3);
        rect (5, 11, 6, 5);

        fill (230, 156, 33);
        rect (10, 13, 1, 2);
        rect (9, 15, 1, 1);

    }

    if (type === 2) { //fireflower

        fill (16, 148, 0);
        rect (0, 9, 3, 1);
        rect (1, 10, 3, 2);
        rect (2, 11, 3, 3);
        rect (3, 12, 3, 3);
        rect (6, 14, 4, 2);
        rect (7, 8, 2, 8);
        rect (10, 12, 3, 3);
        rect (11, 11, 3, 3);
        rect (12, 10, 3, 2);
        rect (13, 9, 3, 1);

        fill (252, 252, 252);
        rect (0, 3, 16, 2);
        rect (1, 2, 14, 4);
        rect (2, 1, 12, 6);
        rect (4, 0, 8, 8);

        fill (230, 156, 33);
        rect (2, 3, 12, 2);
        rect (4, 2, 8, 4);

        fill (181, 49, 33);
        rect (5, 3, 6, 2);

    }

    if (type === 3) { //star

        fill (230, 156, 33);
        rect (7, 0, 2, 13);
        rect (6, 2, 4, 11);
        rect (5, 4, 6, 9);
        rect (1, 5, 14, 2);
        rect (2, 7, 12, 1);
        rect (3, 8, 10, 1);
        rect (4, 9, 8, 2);
        rect (3, 11, 4, 3);
        rect (9, 11, 4, 3);
        rect (3, 14, 2, 1);
        rect (11, 14, 2, 1);
        rect (2, 14, 2, 2);
        rect (12, 14, 2, 2);

        fill (181, 49, 33);
        rect (6, 6, 1, 3);
        rect (9, 6, 1, 3);

    }

    if (type === 4) { //coin

        fill (230, 156, 33);
        rect (3, 5, 8, 8);
        rect (4, 3, 6, 12);
        rect (5, 2, 4, 14);

        fill (156, 74, 0);
        rect (6, 4, 2, 1);
        rect (5, 5, 1, 8);

        fill (0, 0, 0);
        rect (8, 5, 1, 8);
        rect (6, 13, 2, 1);
        rect (9, 2, 2, 1);
        rect (10, 3, 2, 2);
        rect (11, 5, 2, 8);
        rect (10, 13, 2, 2);
        rect (9, 15, 2, 1);

    }

    popMatrix();

};

//a function for an animated coin as it comes out of the Q block
var bounceCoin = function(x, y, type) {

    pushMatrix();

    if (type > 4) {

        translate(x + 25, y);
        scale(-25/16, 25/16);

    } else {

        translate(x, y);
        scale(25/16);

    }


    noStroke ();

    if (type%4 === 0) {

        fill (181, 49, 33);
        rect (7, 1, 2, 14);
        rect (9, 3, 1, 10);

        fill (230, 156, 33);
        rect (7, 1, 1, 2);
        rect (6, 3, 1, 10);
        rect (7, 13, 1, 2);

        fill (252, 252, 252);
        rect (6, 7, 1, 2);

    } else if (type%4 === 1) {

        fill (230, 156, 33);
        rect (7, 1, 2, 14);
        rect (6, 2, 4, 12);
        rect (5, 3, 6, 10);
        rect (4, 5, 8, 6);

        fill (252, 252, 252);
        rect (6, 5, 1, 6);
        rect (7, 4, 1, 1);
        rect (7, 11, 1, 1);

        fill (181, 49, 33);
        rect (8, 4, 1, 1);
        rect (8, 11, 1, 1);
        rect (9, 5, 1, 6);

    } else if (type%4 === 2) {

        fill (252, 252, 252);
        rect (7, 1, 2, 14);
        rect (6, 3, 1, 10);

        fill (181, 49, 33);
        rect (8, 1, 1, 2);
        rect (9, 3, 1, 10);
        rect (8, 13, 1, 2);

    } else if (type%4 === 3) {

        fill (230, 156, 33);
        rect (8, 1, 1, 14);

        fill (252, 252, 252);
        rect (8, 7, 1, 2);

    }

    popMatrix();

};

//a function for drawing the different enemies
var enemyDraw = function(x, y, enemy, flip, type) {

    pushMatrix();

    if (flip) {

        translate(x + 25, y); //translates 25 farther to right
        scale(-25/16, 25/16); //x flips, scales to 25 by 25

    } else {

        translate(x, y); //normal x y position
        scale(25/16); //scales to 25 by 25

    }

    noStroke ();

    if (enemy === 1) { //draws a goomba

        var color1 = color (156, 74, 0);
        var color2 = color (255, 206, 198);
        var color3 = color (0, 0, 0);

        if (type === 0) {

            fill (color1);
            for (var x = 0; x < 6; x ++) {

                rect (6 - x, x, 4 + 2 * x, 1);

            }
            rect (1, 6, 14, 5);
            rect (0, 7, 16, 3);

            fill (color2);
            rect (5, 10, 6, 1);
            rect (4, 11, 8, 4);
            rect (4, 5, 2, 4);
            rect (6, 7, 1, 2);
            rect (9, 7, 1, 2);
            rect (10, 5, 2, 4);

            fill (color3);
            rect (3, 4, 2, 1);
            rect (5, 5, 1, 3);
            rect (5, 6, 6, 1);
            rect (10, 5, 1, 3);
            rect (11, 4, 2, 1);
            rect (3, 13, 2, 2);
            rect (4, 14, 2, 2);
            rect (6, 15, 1, 1);
            rect (9, 14, 5, 2);
            rect (10, 13, 5, 2);
            rect (12, 12, 2, 1);

        } else if (type === 1) {

            fill (color1);
            rect (0, 11, 16, 2);
            rect (1, 10, 14, 1);
            rect (3, 9, 10, 1);
            rect (6, 8, 4, 1);

            fill (color2);
            rect (2, 11, 12, 1);
            rect (3, 13, 10, 1);
            rect (4, 14, 8, 1);

            fill (color3);
            rect (3, 10, 3, 1);
            rect (6, 11, 4, 1);
            rect (10, 10, 3, 1);
            rect (1, 15, 5, 1);
            rect (10, 15, 5, 1);

        }

    }

    popMatrix();

};

//drawing for blocks (get() images)
{

///color1 = color(38, 123, 139);        color2 = color(187, 239, 238);

pushMatrix();

noStroke();

scale(25/16); //makes the blocks 25 by 25

//basic ground block in overworld
fill (156, 74, 0);
rect (0, 0, 16, 16); //background, brown

fill (255, 206, 198); //light shadow parts
rect (1, 0, 8, 1);
rect (0, 1, 1, 14);
rect (1, 11, 1, 1);
rect (2, 12, 2, 1);
rect (4, 13, 3, 1);
rect (11, 0, 4, 1);
rect (10, 1, 1, 4);
rect (10, 6, 1, 4);
rect (10, 6, 5, 1);
rect (9, 10, 1, 2);
rect (8, 12, 1, 4);

fill (0, 0, 0); //dark shadow parts
rect (9, 0, 1, 10);
rect (8, 10, 1, 2);
rect (0, 10, 2, 1);
rect (2, 11, 2, 1);
rect (4, 12, 4, 1);
rect (7, 12, 1, 3);
rect (1, 15, 6, 1);
rect (9, 15, 6, 1);
rect (15, 1, 1, 4);
rect (11, 4, 1, 2);
rect (11, 5, 4, 1);
rect (15, 6, 1, 9);
rect (14, 14, 1, 1);

blockImage[0].push(get(0, 0, 25, 25));

//basic ground block in underworld
fill (38, 123, 139);
rect (0, 0, 16, 16); //background, blue

fill (187, 239, 238); //light shadow parts
rect (1, 0, 8, 1);
rect (0, 1, 1, 14);
rect (1, 11, 1, 1);
rect (2, 12, 2, 1);
rect (4, 13, 3, 1);
rect (11, 0, 4, 1);
rect (10, 1, 1, 4);
rect (10, 6, 1, 4);
rect (10, 6, 5, 1);
rect (9, 10, 1, 2);
rect (8, 12, 1, 4);

fill (0, 0, 0); //dark shadow parts
rect (9, 0, 1, 10);
rect (8, 10, 1, 2);
rect (0, 10, 2, 1);
rect (2, 11, 2, 1);
rect (4, 12, 4, 1);
rect (7, 12, 1, 3);
rect (1, 15, 6, 1);
rect (9, 15, 6, 1);
rect (15, 1, 1, 4);
rect (11, 4, 1, 2);
rect (11, 5, 4, 1);
rect (15, 6, 1, 9);
rect (14, 14, 1, 1);

blockImage[0].push(get(0, 0, 25, 25));

//basic brick with light on it and without light on it
fill (156, 74, 0); //brown brick backgorund
rect (0, 0, 16, 16);

fill (0, 0, 0); //black space between bricks
rect (0, 3, 16, 1);
rect (0, 7, 16, 1);
rect (0, 11, 16, 1);
rect (0, 15, 16, 1);
rect (7, 0, 1, 3);
rect (15, 0, 1, 3);
rect (3, 4, 1, 3);
rect (11, 4, 1, 3);
rect (7, 8, 1, 3);
rect (15, 8, 1, 3);
rect (3, 12, 1, 3);
rect (11, 12, 1, 3);

blockImage[3].push(get(0, 0, 25, 25));

//basic brick with light on it and without light on it
fill (38, 123, 139); //brown brick backgorund
rect (0, 0, 16, 16);

fill (0, 0, 0); //black space between bricks
rect (0, 3, 16, 1);
rect (0, 7, 16, 1);
rect (0, 11, 16, 1);
rect (0, 15, 16, 1);
rect (7, 0, 1, 3);
rect (15, 0, 1, 3);
rect (3, 4, 1, 3);
rect (11, 4, 1, 3);
rect (7, 8, 1, 3);
rect (15, 8, 1, 3);
rect (3, 12, 1, 3);
rect (11, 12, 1, 3);

blockImage[3].push(get(0, 0, 25, 25));

//stairs block
fill (156, 74, 0);
rect (0, 0, 16, 16);

fill (255, 206, 198);
rect (1, 0, 14, 1);
rect (2, 0.4, 12, 1.6);
rect (3, 2, 10, 1.4);
rect (4, 2.4, 8, 1.6);
rect (0, 1, 1, 14);
rect (0.4, 2, 1.6, 12);
rect (2, 3, 1.4, 10);
rect (2.4, 4, 1.6, 8);

fill(0, 0, 0);
rect (15, 0, 1.6, 15);
rect (14, 1, 1.6, 13);
rect (13, 2, 1.6, 11);
rect (12, 3, 1.6, 9);
rect (0, 15, 15, 1.6);
rect (1, 14, 13, 1.6);
rect (2, 13, 11, 1.6);
rect (3, 12, 9, 1.6);

blockImage[1].push(get(0, 0, 25, 25));

//stairs block
fill (38, 123, 139);
rect (0, 0, 16, 16);

fill (187, 239, 238);
rect (1, 0, 14, 1);
rect (2, 0.4, 12, 1.6);
rect (3, 2, 10, 1.4);
rect (4, 2.4, 8, 1.6);
rect (0, 1, 1, 14);
rect (0.4, 2, 1.6, 12);
rect (2, 3, 1.4, 10);
rect (2.4, 4, 1.6, 8);

fill(0, 0, 0);
rect (15, 0, 1.6, 15);
rect (14, 1, 1.6, 13);
rect (13, 2, 1.6, 11);
rect (12, 3, 1.6, 9);
rect (0, 15, 15, 1.6);
rect (1, 14, 13, 1.6);
rect (2, 13, 11, 1.6);
rect (3, 12, 9, 1.6);

blockImage[1].push(get(0, 0, 25, 25));

background(0, 0, 0, 0);

//used question mark block (extremely plain)
fill (156, 74, 0); //brown background
rect (1, 1, 14, 14);

fill (0, 0, 0); //black outside and dots
rect (1, 0, 14, 1);
rect (0, 1, 1, 14);
rect (1, 15, 14, 1);
rect (15, 1, 1, 14);
rect (2, 2, 1, 1);
rect (2, 13, 1, 1);
rect (13, 2, 1, 1);
rect (13, 13, 1, 1);

blockImage[2].push(get(0, 0, 25, 25)); //same for overworld and underworld
blockImage[2].push(get(0, 0, 25, 25));

popMatrix();

}

//drawings for all the background images!
{

noStroke();

pushMatrix();
scale(25 / 16);

background(0, 0, 0, 0);//1

fill (140, 214, 0);
rect (9, 13, 7, 3);
rect (11, 10, 5, 4);
rect (13, 9, 3, 2);

fill (0, 0, 0);
rect (8, 13, 1, 2);
rect (9, 15, 1, 1);
rect (9, 12, 2, 1);
rect (11, 10, 1, 1);
rect (12, 9, 1, 1);
rect (13, 8, 3, 1);

bkgrdImage.push(get(0, 0, 25, 25));

background(0, 0, 0, 0);//2

fill (140, 214, 0);
rect (0, 7, 15, 9);
rect (15, 8, 1, 8);
rect (2, 3, 10, 4);
rect (5, 1, 6, 3);
rect (11, 4, 4, 4);
rect (14, 8, 3, 8);

fill (0, 0, 0);
rect (0, 7, 1, 1);
rect (1, 6, 1, 1);
rect (2, 3, 1, 3);
rect (3, 2, 2, 1);
rect (5, 1, 1, 1);
rect (6, 0, 4, 1);
rect (10, 1, 1, 1);
rect (11, 2, 1, 2);
rect (12, 4, 1, 1);
rect (13, 3, 1, 1);
rect (14, 4, 1, 1);
rect (15, 5, 1, 3);

fill (16, 148, 0);
rect (4, 7, 1, 1);
rect (5, 6, 2, 1);
rect (9, 5, 1, 1);
rect (10, 6, 1, 1);

bkgrdImage.push(get(0, 0, 25, 25));

background(0, 0, 0, 0);//3

fill (140, 214, 0);
rect (0, 10, 5, 6);
rect (3, 9, 1, 1);
rect (5, 12, 2, 4);
rect (0, 13, 6, 3);

fill (0, 0, 0);
rect (0, 8, 1, 2);
rect (1, 10, 1, 1);
rect (2, 9, 1, 1);
rect (3, 8, 1, 1);
rect (4, 9, 1, 3);
rect (5, 12, 1, 1);
rect (6, 11, 1, 1);
rect (7, 12, 1, 3);
rect (6, 15, 1, 1);

bkgrdImage.push(get(0, 0, 25, 25));

background(0, 0, 0, 0);//4

fill (255, 255, 255);
rect (9, 13, 7, 3);
rect (11, 10, 5, 4);
rect (13, 9, 3, 2);

fill (0, 0, 0);
rect (8, 13, 1, 2);
rect (9, 15, 1, 1);
rect (9, 12, 2, 1);
rect (11, 10, 1, 1);
rect (12, 9, 1, 1);
rect (13, 8, 3, 1);

bkgrdImage.push(get(0, 0, 25, 25));

background(0, 0, 0, 0);//5

fill (255, 255, 255);
rect (0, 7, 15, 9);
rect (15, 8, 1, 8);
rect (2, 3, 10, 4);
rect (5, 1, 6, 3);
rect (11, 4, 4, 4);
rect (14, 8, 3, 8);

fill (0, 0, 0);
rect (0, 7, 1, 1);
rect (1, 6, 1, 1);
rect (2, 3, 1, 3);
rect (3, 2, 2, 1);
rect (5, 1, 1, 1);
rect (6, 0, 4, 1);
rect (10, 1, 1, 1);
rect (11, 2, 1, 2);
rect (12, 4, 1, 1);
rect (13, 3, 1, 1);
rect (14, 4, 1, 1);
rect (15, 5, 1, 3);

fill (99, 173, 255);
rect (4, 7, 1, 1);
rect (5, 6, 2, 1);
rect (9, 5, 1, 1);
rect (10, 6, 1, 1);

bkgrdImage.push(get(0, 0, 25, 25));

background(0, 0, 0, 0);//6

fill (255, 255, 255);
rect (0, 10, 5, 6);
rect (3, 9, 1, 1);
rect (5, 12, 2, 4);
rect (0, 13, 6, 3);

fill (0, 0, 0);
rect (0, 8, 1, 2);
rect (1, 10, 1, 1);
rect (2, 9, 1, 1);
rect (3, 8, 1, 1);
rect (4, 9, 1, 3);
rect (5, 12, 1, 1);
rect (6, 11, 1, 1);
rect (7, 12, 1, 3);
rect (6, 15, 1, 1);

bkgrdImage.push(get(0, 0, 25, 25));

background(0, 0, 0, 0);//7

fill (255, 255, 255);
rect (11, 0, 5, 2);
rect (13, 0, 3, 4);

fill (0, 0, 0);
rect (10, 0, 1, 1);
rect (11, 1, 1, 1);
rect (12, 2, 1, 2);
rect (13, 4, 3, 1);

fill (99, 173, 255);
rect (13, 0, 1, 1);
rect (14, 1, 1, 1);
rect (15, 2, 1, 1);

bkgrdImage.push(get(0, 0, 25, 25));

background(0, 0, 0, 0);//8

fill (255, 255, 255);
rect (0, 0, 16, 6);
rect (3, 5, 3, 2);
rect (10, 5, 4, 2);

fill (0, 0, 0);
rect (0, 5, 1, 1);
rect (1, 6, 2, 1);
rect (3, 7, 3, 1);
rect (6, 6, 1, 1);
rect (7, 5, 1, 1);
rect (8, 6, 2, 1);
rect (10, 7, 4, 1);
rect (14, 6, 2, 1);

fill (99, 173, 255);
rect (0, 2, 3, 1);
rect (1, 1, 1, 1);
rect (2, 3, 6, 1);
rect (4, 4, 2, 1);
rect (6, 2, 4, 1);
rect (8, 1, 1, 1);
rect (9, 0, 1, 1);
rect (9, 3, 5, 1);
rect (10, 4, 3, 1);
rect (14, 2, 1, 1);

bkgrdImage.push(get(0, 0, 25, 25));

background(0, 0, 0, 0);//9

fill (255, 255, 255);
rect (0, 0, 5, 6);
rect (0, 0, 6, 5);
rect (5, 1, 2, 3);

fill (0, 0, 0);
rect (0, 5, 1, 1);
rect (1, 6, 2, 1);
rect (3, 5, 2, 1);
rect (5, 4, 2, 1);
rect (5, 0, 1, 1);
rect (6, 1, 1, 1);
rect (7, 2, 1, 1);

bkgrdImage.push(get(0, 0, 25, 25));

background(0, 0, 0, 0);//10

for (var a = 0; a < 16; a ++) {

fill (0, 173, 0);
rect (a, 15 - a, 16 - a, 15 - a);

fill (0, 0, 0);
rect (a, 15 - a, 1, 1);
}

bkgrdImage.push(get(0, 0, 25, 25));

background(0, 0, 0, 0);//11

for (var a = 0; a < 16; a ++) {

fill (0, 173, 0);
rect (0, a, a, 16 - a);

fill (0, 0, 0);
rect (a, a, 1, 1);
}

bkgrdImage.push(get(0, 0, 25, 25));

background(0, 0, 0, 0);//12

fill (0, 173, 0);
rect (0, 0, 16, 16);

bkgrdImage.push(get(0, 0, 25, 25));

background(0, 0, 0, 0);//13

fill (0, 173, 0);
rect (0, 0, 16, 16);

fill (0, 0, 0);
rect (9, 4, 2, 4);
rect (12, 1, 3, 4);
rect (13, 0, 1, 6);

bkgrdImage.push(get(0, 0, 25, 25));

background(0, 0, 0, 0);//14

fill (0, 173, 0);
rect (0, 0, 16, 16);

fill (0, 0, 0);
rect (4, 1, 3, 4);
rect (5, 0, 1, 6);
rect (1, 4, 2, 4);

bkgrdImage.push(get(0, 0, 25, 25));

background(0, 0, 0, 0);//15

fill (0, 173, 0);
rect (2, 14, 12, 2);

fill (0, 0, 0);
rect (0, 15, 2, 1);
rect (2, 14, 3, 1);
rect (5, 13, 6, 1);
rect (11, 14, 3, 1);
rect (14, 15, 2, 1);

bkgrdImage.push(get(0, 0, 25, 25));

background(0, 0, 0, 0);//16

fill (156, 74, 0);
rect (0, 0, 16, 16);

fill (0, 0, 0);
rect (0, 3, 16, 1);
rect (0, 7, 16, 1);
rect (0, 11, 16, 1);
rect (0, 15, 16, 1);
rect (7, 0, 1, 3);
rect (15, 0, 1, 3);
rect (3, 4, 1, 3);
rect (11, 4, 1, 3);
rect (7, 8, 1, 3);
rect (15, 8, 1, 3);
rect (3, 12, 1, 3);
rect (11, 12, 1, 3);

bkgrdImage.push(get(0, 0, 25, 25));

background(0, 0, 0, 0);//17

fill (156, 74, 0);
rect (0, 0, 3, 16);
rect (3, 8, 9, 8);
rect (12, 0, 4, 16);

fill (0, 0, 0);
rect (0, 7, 16, 1);
rect (0, 11, 16, 1);
rect (0, 15, 16, 1);
rect (7, 8, 1, 3);
rect (15, 8, 1, 3);
rect (3, 12, 1, 3);
rect (11, 12, 1, 3);

fill (255, 206, 198);
rect (0, 0, 4, 1);
rect (3, 0, 1, 8);
rect (3, 7, 9, 1);
rect (11, 0, 1, 8);
rect (11, 0, 5, 1);

bkgrdImage.push(get(0, 0, 25, 25));

background(0, 0, 0, 0);//18

fill (156, 74, 0);
rect (0, 0, 3, 16);
rect (3, 8, 9, 8);
rect (12, 0, 4, 16);
rect (3, 0, 8, 8);

fill (0, 0, 0);
rect (0, 7, 16, 1);
rect (0, 11, 16, 1);
rect (0, 15, 16, 1);
rect (7, 8, 1, 3);
rect (15, 8, 1, 3);
rect (3, 12, 1, 3);
rect (11, 12, 1, 3);
rect (4, 3, 7, 1);
rect (7, 0, 1, 3);

fill (255, 206, 198);
rect (0, 0, 4, 1);
rect (3, 0, 1, 8);
rect (3, 7, 9, 1);
rect (11, 0, 1, 8);
rect (11, 0, 5, 1);

bkgrdImage.push(get(0, 0, 25, 25));

background(0, 0, 0, 0);//19

fill (156, 74, 0);
rect (0, 0, 16, 16);

fill (0, 0, 0);
rect (8, 0, 8, 16);
rect (7, 0, 2, 4);
rect (7, 7, 2, 5);
rect (0, 3, 8, 1);
rect (0, 7, 7, 1);
rect (0, 11, 7, 1);
rect (0, 15, 8, 1);
rect (3, 3, 1, 5);
rect (3, 12, 1, 4);

bkgrdImage.push(get(0, 0, 25, 25));

background(0, 0, 0, 0);//20

fill (156, 74, 0);
rect (0, 0, 16, 16);

fill (0, 0, 0);
rect (0, 0, 8, 16);
rect (8, 3, 8, 1);
rect (8, 7, 8, 1);
rect (8, 11, 8, 1);
rect (8, 15, 8, 1);
rect (15, 0, 1, 3);
rect (15, 8, 1, 3);
rect (11, 4, 1, 3);
rect (11, 12, 1, 3);

bkgrdImage.push(get(0, 0, 25, 25));

background(0, 0, 0, 0);//21

fill (156, 74, 0);
rect (0, 0, 16, 16);

fill (0, 0, 0);
rect (0, 6, 16, 10);
rect (1, 3, 14, 4);
rect (0, 3, 16, 1);
rect (2, 2, 12, 1);
rect (3, 1, 10, 2);
rect (5, 0, 6, 2);
rect (15, 0, 1, 4);

bkgrdImage.push(get(0, 0, 25, 25));

background(0, 0, 0, 0);//22

fill (0, 0, 0);
rect (0, 0, 16, 16);

bkgrdImage.push(get(0, 0, 25, 25));

popMatrix();

}

//function for the question block (separate because it always changes colors)
var question = function(type, x, y) {

    pushMatrix();

    translate (x, y); //moves into position
    scale(25/16); //scales to 25 by 25
    noStroke ();

    var colors = color (231, 156, 33); //variable for inside color
    if (type < 2) { //stage 1

        colors = color (153, 78, 0);

    } else if (type < 4) {//stage 2

        colors = color (86, 29, 0);

    }

    //question mark block
    fill (colors);
    rect (1, 1, 14, 14);

    fill (0, 0, 0);
    rect (2, 2, 1, 1);
    rect (13, 2, 1, 1);
    rect (2, 13, 1, 1);
    rect (13, 13, 1, 1);
    rect (15, 1, 1, 15);
    rect (0, 15, 15, 1);
    rect (5, 4, 2, 4);
    rect (5, 4, 4, 1);
    rect (10, 5, 2, 4);
    rect (8, 8, 2, 3);
    rect (8, 12, 2, 2);

    fill (156, 74, 0);
    rect (1, 0, 14, 1);
    rect (0, 1, 1, 14);
    rect (4, 4, 2, 3);
    rect (5, 3, 5, 1);
    rect (9, 4, 2, 3);
    rect (8, 7, 3, 1);
    rect (7, 8, 2, 2);
    rect (7, 11, 2, 2);

    popMatrix();

};

//draws a pipe
var pipe = function (type, x, y) {

    pushMatrix();

    noStroke ();
    translate (x, y);
    scale(25/16);

    //vertical pipe top
    if (type === 1) {

        fill (0, 0, 0);
        rect (0, 0, 32, 1);
        rect (0, 0, 1, 15);
        rect (31, 0, 1, 15);
        rect (0, 14, 32, 1);
        rect (2, 15, 28, 1);

        fill (140, 214, 0);//light green
        rect (1, 1, 30, 13);

        fill (16, 148, 0);//dark green
        rect (1, 2, 5, 1);
        rect (4, 2, 2, 12);
        rect (12, 2, 19, 1);
        rect (12, 2, 1, 12);
        rect (15, 2, 10, 12);

        for (var b = 25; b < 29; b += 2) {//grid of dark green squares

            for (var a = 2; a < 14; a += 2) {

                rect (b, a, 1, 1);

            }

        }

        for (var b = 26; b < 29; b += 2) {

            for (var a = 3; a < 15; a += 2) {

            rect (b, a, 1, 1);

            }

        }

    }
    //vertical pipe bottom
    if (type === 2) {

        fill (0, 0, 0);
        rect (2, 0, 1, 16);
        rect (29, 0, 1, 16);

        fill (140, 214, 0);//light green
        rect (3, 0, 26, 16);

        fill (16, 148, 0);//dark green
        rect (6, 0, 2, 16);
        rect (13, 0, 1, 16);
        rect (16, 0, 8, 16);

        for (var b = 24; b < 28; b += 2) {//grid of dark green squares

            for (var a = 1; a < 16; a += 2) {

                rect (b, a, 1, 1);

            }

        }

        for (var a = 0; a < 16; a += 2) {

            rect (25, a, 1, 1);

        }

    }
    //horizontal pipe top
    if (type === 3) {

        fill (0, 0, 0);
        rect (0, 0, 14, 1);
        rect (0, 0, 1, 32);
        rect (0, 31, 14, 1);
        rect (14, 0, 1, 32);
        rect (15, 1, 1, 30);

        fill (140, 214, 0);//light green
        rect (1, 1, 13, 30);

        fill (16, 148, 0);//dark green
        rect (1, 5, 13, 2);
        rect (1, 12, 13, 1);
        rect (1, 17, 13, 9);

        for (var b = 26; b < 29; b += 2) {//grid of dark green squares

            for (var a = 1; a < 15; a += 2) {

                rect (a, b, 1, 1);

            }

        }

        for (var a  = 2; a < 14; a += 2) {

            rect (a, 27, 1, 1);

        }

    }
    //horizontal pipe bottom
    if (type === 4) {

        fill (0, 0, 0);
        rect (0, 1, 16, 1);
        rect (0, 30, 16, 1);

        fill (140, 214, 0);//light green
        rect (0, 2, 16, 28);

        fill (16, 148, 0);//dark green
        rect (0, 6, 16, 2);
        rect (0, 13, 16, 1);
        rect (0, 16, 16, 9);

        for (var b = 25; b < 29; b += 2) {//grid of dark green squares

            for (var a = 0; a < 15; a += 2) {

                rect (a, b, 1, 1);

            }

        }

        for (var a = 1; a < 16; a += 2) {

            rect (a, 26, 1, 1);

        }

    }
    if (type === 5) {

        pushMatrix();

        //draws another pipe horizontal
        for (var i = 0; i < 2; i ++) { //accounts for a 50 by 50 square!

            translate(0, i*16); //moves down second time

            fill (0, 0, 0);
            rect (2, 0, 1, 16);
            rect (29, 0, 1, 16);

            fill (140, 214, 0);//light green
            rect (3, 0, 26, 16);

            fill (16, 148, 0);//dark green
            rect (6, 0, 2, 16);
            rect (13, 0, 1, 16);
            rect (16, 0, 8, 16);

            for (var b = 24; b < 28; b += 2) {//grid of dark green squares

                for (var a = 1; a < 16; a += 2) {

                    rect (b, a, 1, 1);

                }

            }

            for (var a = 0; a < 16; a += 2) {

                rect (25, a, 1, 1);

            }

        }

        popMatrix();

        fill (140, 214, 0);//light green
        rect (2, 0, 14, 32);
        rect (0, 2, 2, 28);

        fill (16, 148, 0);//dark green
        rect (6, 0, 2, 32);
        rect (13, 0, 1, 32);
        rect (0, 6, 6, 2);
        rect (0, 13, 6, 1);
        rect (0, 16, 6, 9);

        for (var b = 25; b < 29; b += 2) {//grid of dark green squares

            for (var a = 0; a < 6; a += 2) {

                rect (a, b, 1, 1);

            }

        }

        for (var a = 1; a < 6; a += 2) {

            rect (a, 26, 1, 1);

        }

        fill (0, 0, 0);
        rect (2, 0, 1, 1);
        rect (0, 1, 4, 1);
        rect (4, 2, 1, 3);
        rect (5, 5, 1, 5);
        rect (6, 10, 1, 12);
        rect (5, 22, 1, 5);
        rect (4, 27, 1, 3);
        rect (2, 31, 1, 1);
        rect (0, 30, 4, 1);

    }

    //Colors:
    //16, 148, 0 - dark
    //140, 214, 0 - light

    popMatrix();

};

keyPressed = function() {

    if (keys[keyCode]) {

        firstClick[keyCode] = false; //makes it false so that it is only one

    } else {

        firstClick[keyCode] = true; // first time you click

    }

    keys[keyCode] = true; //adds into the keys array as true

};

keyReleased = function() {

    keys[keyCode] = false; //gets rid of value from keys array by setting it as false
    firstClick[keyCode] = false; //makes it false so that it is only one

};

//IMPLEMENT PIPES LAST, THEY MESS UP ALIGNMENT
/**
0       empty
1       ground block
2       stone block
3       plain block
4       plain brick block
5       question block with coin (add 0 to draw like brick) add 1 to hide
6       question block with coins (add 0 to draw like brick)
7       question block with one up mushroom (add 0 to draw like brick)
8       question block with star powerup (add 0 to draw like brick)
9       question block with fireflower/mushroom powerup (add 0 to draw like brick)
100 + rotation plain pipe segment EX: 101 for down or 103 for right
[lvlStage, x, y, direction to go, rotation] pipe movable EX: [1,10,-25,1,0]
12      pipe holding enemy
13      coin
14      flag
*/

//an array of the different blocks in a level / part of lvl
var maps = [

    [

        [

            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 60, 60, 60, 60, 60, 60, 60, 60, 0, 0, 0, 60, 60, 60, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 60, 60, 60, 0, 0, 0, 0, 60, 6, 6, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 60, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6,0, 60, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 60, 60, 60, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 60, 60, 60, 60, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6, 0, 0, 0, 60, 9, 60, 6, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,[1,50,50,1,0], 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 60, 9, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,60, 0, 0, 0, 0, 0, 60,80, 0, 0, 0, 0, 6, 0, 0, 6, 0, 0, 6, 0, 0, 0, 0, 0, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 60, 60, 0, 0, 0, 0, 0, 0, 60, 0, 0, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 60, 60, 0, 0, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 60, 60, 6, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 60, 60, 60, 60, 60, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,100, 0, 0, 0, 0, 0, 0, 0,100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 60, 60, 0, 0, 60, 60, 0, 0, 0, 0, 0, 0, 0, 0, 60, 60, 60, 0, 0, 60, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 60, 60, 60, 60, 60, 60, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,100, 0, 0, 0, 0, 0, 0, 0, 0,100, 0, 0, 0, 0, 0, 0, 0,100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 60, 60, 60, 0, 0, 60, 60, 60, 0, 0, 0, 0, 0, 0, 60, 60, 60, 60, 0, 0, 60, 60, 60, 0, 0, 0, 0, 0,100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,100, 0, 0, 60, 60, 60, 60, 60, 60, 60, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,100, 0, 0, 0, 0, 0, 0, 0, 0,100, 0, 0, 0, 0, 0, 0, 0,100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 2, 2, 2, 2, 0, 0, 0, 0, 2, 2, 2, 2, 2, 0, 0, 2, 2, 2, 2, 0, 0, 0, 0,100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,100, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0,14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]

        ],

        [

            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [4, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0, 0,100],
            [4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,100],
            [4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,100],
            [4, 0, 0, 0, 0,13,13,13,13,13, 0, 0, 0, 0, 0,100],
            [4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,100],
            [4, 0, 0, 0,13,13,13,13,13,13,13, 0, 0, 0, 0,100],
            [4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,100],
            [4, 0, 0, 0,13,13,13,13,13,13,13, 0, 0, 0, 0,100],
            [4, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0, 0,100],
            [4, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4, 0, 0,[0,4037.5,300,0,2],102,100],
            [4, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0, 0,100],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],

        ]

    ], //level 1

    [

        [

            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,100, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,100, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,[1,75,50,1,2],102,100, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,100, 0, 0],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],

        ],

		[

            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [4, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4],
            [4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,14, 0, 0],
            [4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,60, 0, 0, 0, 0],
            [4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9, 5, 5, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0],
            [4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 2, 0, 2, 0, 0, 0, 2, 0, 0],
            [4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 0, 0, 2, 0, 2],
            [4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 2, 0, 0, 0, 2, 0, 2],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],

        ]

    ] //level 2

];

//an array for the different things in the background (clouds hills etc.)
var bkgrdArray = [

    [

        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 5, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 5, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 5, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 5, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 8, 9, 0, 0, 0, 0, 0, 4, 5, 5, 5, 6, 0, 0, 0, 7, 8, 8, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 5, 6, 0, 0, 0, 0, 0, 0, 0, 0, 7, 8, 9, 0, 0, 0, 0, 4, 5, 5, 5, 6, 0, 0, 0, 0, 7, 8, 8, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 5, 6, 0, 0, 0, 0, 0, 0, 0, 0, 7, 8, 9, 0, 0, 0, 0, 0, 4, 5, 5, 5, 6, 0, 0, 0, 0, 7, 8, 8, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 5, 6, 0, 0, 0, 0, 0, 0, 0, 0, 7, 8, 9, 0, 0, 0, 0, 0, 4, 5, 5, 5, 6, 0, 0, 0, 0, 7, 8, 8, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 5, 6],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 8, 8, 8, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 8, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 8, 8, 8, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 8, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 8, 8, 8, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 8, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 8, 8, 8, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 8, 9],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
       [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 17, 17, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 19, 16, 20, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, 0, 0, 0, 0, 0, 0, 17, 18, 18, 18, 17, 0, 0, 0, 0, 0],
        [0, 10, 13, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 13, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 13, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 13, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 13, 11, 0, 0, 0, 0, 0, 0, 16, 16, 21, 16, 16, 0, 0, 15, 0, 0],
        [10, 13, 12, 14, 11, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, 10, 13, 11, 0, 0, 0, 0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 3, 0, 0, 0, 10, 13, 12, 14, 11, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, 10, 13, 11, 0, 0, 0, 0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 3, 0, 0, 0, 10, 13, 12, 14, 11, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, 10, 13, 11, 0, 0, 0, 0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 0, 0, 0, 10, 13, 12, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 10, 13, 11, 0, 0, 0, 0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 13, 12, 14, 11, 0, 0, 0, 0, 0, 16, 16, 22, 16, 16, 3, 10, 13, 11, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],

    ], //level 1

    [

        [0],
        [0],
        [0],
        [0],
        [0],
        [0],
        [0],
        [0],
        [0],
        [0],
        [0],
        [0],
        [0],
        [0],
        [0],
        [0],

    ] //level 2

];

//a function for deleting a value from the maps array (changing it to a specific value, usually 0)
var valueDelete = function(x, y, value) {

    maps[levelNum][lvlStage][floor(y/25)][floor(x/25)] = value;

};

draw = function() {

    //first variable used to initialize a level
    if (death[0]) {

        background(0, 0, 0);
        txt("WORLD 1-" + (levelNum + 1), 125, 125);

        smallMario(1, 150, 187.5);

        txt("×  " + lives, 187.5, 200);

        if (death[1] > 0) {

            death[1] --;

        } else {

            death[0] = false;
            timeLeft = 400;

        }

    } else if (first) {

        background(107, 140, 255);

        fill(161, 127, 58);
        noStroke();
        rect(0, 350, 400, 50);

        translatePos = 0; //resets translatePos to the very beginning
        flagY = 0; //resets flag height

        //empties all arrays storing level info

        for (var i = blocks.length; i > 0; i --) {

            blocks.pop();

        }
        for (var i = pipes.length; i > 0; i --) {

            pipes.pop();

        }
        for (var i = coins.length; i > 0; i --) {

            coins.pop();

        }
        for (var i = bkgrdBlocks.length; i > 0; i --) {

            bkgrdBlocks.pop();

        }

        //x, y, xvel, yvel, left open, right open, down open, up open, type, active?
        //not many enemies, so enemies are added manually!
        if (levelNum === 0 & lvlStage === 0) { //level 1

            enemy = [[550, 325, -1, 0, true, true, true, true, 1, false], [975, 325, -1, 0, true, true, true, true, 1, false], [1250, 325, -1, 0, true, true, true, true, 1, false], [1300, 325, -1, 0, true, true, true, true, 1, false], [1950, 125, -1, 0, true, true, true, true, 1, false], [2000, 125, -1, 0, true, true, true, true, 1, false]];

        } else { //if level isnt given, there are no enemies

            //empty array of enemies
            for (var i = enemy.length; i > 0; i --) {

                enemy.pop();

            }

        }

        //goes through maps array at specific level and stage
        for (var i = 0; i < maps[levelNum][lvlStage].length; i ++) {

            for (var j = 0; j < maps[levelNum][lvlStage][i].length; j ++) {

                //if it is a pipe that is plain (greater than or equal to 100)
                if (maps[levelNum][lvlStage][i][j] >= 100) {

                    //100 or 101 is vertical (facing up or down)
                    if (maps[levelNum][lvlStage][i][j] <= 101) {

                        pipes.push([j*25, i*25, maps[levelNum][lvlStage][i][j]]); //adds a value to pipe array
                        blocks.push([j*25, i*25, 0]); //add a block at x and y and to the right
                        blocks.push([j*25 + 25, i*25, 0]);

                    } else { //102 or 103 is horizontal (facing left or right)

                        pipes.push([j*25, i*25, maps[levelNum][lvlStage][i][j]]); //adds a value to pipe array
                        blocks.push([j*25, i*25, 0]); //add a block at x and y and to the bottom
                        blocks.push([j*25, i*25 + 25, 0]);

                    }

                } else if (maps[levelNum][lvlStage][i][j].length > 1) { //pipe thats an array

                    if (maps[levelNum][lvlStage][i][j][4] <= 1) { //facing up or down

                        pipes.push([j*25, i*25, maps[levelNum][lvlStage][i][j]]); //adds value to pipe array
                        blocks.push([j*25, i*25, 0]); //add a block at x and y and to the right
                        blocks.push([j*25 + 25, i*25, 0]);

                    } else { //facing left or right

                        pipes.push([j*25, i*25, maps[levelNum][lvlStage][i][j]]); //adds a value to pipe array
                        blocks.push([j*25, i*25, 0]); //add a block at x and y and to the bottom
                        blocks.push([j*25, i*25 + 25, 0]);

                    }

                } else if ((maps[levelNum][lvlStage][i][j] > 0 & maps[levelNum][lvlStage][i][j] < 10) | maps[levelNum][lvlStage][i][j] >= 50) { //if it will act as a normal block

                    //x, y, type, y bounce height, isBouncing?, bounce y velocity, times to be hit
                    blocks.push([j*25, i*25, maps[levelNum][lvlStage][i][j], 0, false, 0]);

                    //adds a 7th value (times to be hit)
                    if (maps[levelNum][lvlStage][i][j] === 6 | maps[levelNum][lvlStage][i][j] === 60 | maps[levelNum][lvlStage][i][j] === 61) { //coin block - 10 coins

                        blocks[blocks.length - 1].push(10);

                    } else { //otherwise one hit finishes it

                        blocks[blocks.length - 1].push(1);

                    }

                } else if (maps[levelNum][lvlStage][i][j] === 13) { //a coin

                    coins.push([j*25, i*25]); //adds a value to the coins array

                } else if (maps[levelNum][lvlStage][i][j] === 14) { //the end

                    endX = j*25; //sets the endX to the corresponding x value
                    blocks.push([j*25, 325, 2]); //a stone block at the end

                }

            }

        } //end of going through maps array

        //only the original stage needs backgrounds
        if (lvlStage === 0) {

            //goes through background array at specific level
            for (var i = 0; i < bkgrdArray[levelNum].length; i ++) {

                for (var j = 0; j < bkgrdArray[levelNum][i].length; j ++) {

                    if (bkgrdArray[levelNum][i][j] !== 0) {

                        //x, y, type
                        bkgrdBlocks.push([j*25, i*25, bkgrdArray[levelNum][i][j]]); //adds value to background blocks array

                    }

                }

            }

        }

        //first set to false so that this only occurs once!
        first = false;

    } else { //if not first (to keep from any drawing errors)

        //begins the major game code
        pushMatrix();

        //Change -0 to -translatePos to only be able to move forward!

        //if he is not on the very left 200 or the vvery right 200
        //EXCEPTIONS: level 1, underground (the pipe is cut off, but still needs to be there)
        if (player[0] >= (-0 + 200) & player[0] < (25*maps[levelNum][lvlStage][0].length - 200) & (!(levelNum === 0 & lvlStage === 1))) {

            translatePos = -player[0] + 200; //moves the translateX to 200 more than the negative of player x to have him mario in the middle of the screen

        }

        translate(translatePos, 0); //translate to translate pos (no y change in the real game!)

        //usually a bright blue background
        background(107, 140, 255);

        //goes through the array of background blocks
        for (var i = 0; i < bkgrdBlocks.length; i ++) {

            //if the block is in the screen (accoringing to x translate amt)
            if (bkgrdBlocks[i][0] >= (-translatePos - 25) & bkgrdBlocks[i][0] < (-translatePos + 400)) {

                image(bkgrdImage[bkgrdBlocks[i][2] - 1], bkgrdBlocks[i][0], bkgrdBlocks[i][1]);

            }

        }

        //black background in some scenarios
        if ((lvlStage === 1 & levelNum === 0) | (lvlStage === 1 & levelNum === 1)) { //level 1, underground

            background(0, 0, 0); // the underworld has a black background (covering up all else);

        }

        for (var j = 0; j < enemy.length; j ++) {

            //goes through blocks array to see if there is movement anywhere
            for (var i = 0; i < blocks.length; i ++) {

                if (!endLevel & blocks[i][0] > (enemy[j][0] - 30) & blocks[i][0] < (enemy[j][0] + 30) & blocks[i][1] > (enemy[j][1] - 30) & blocks[i][1] < (enemy[j][1] + 30)) { //if the level has not ended and if mario isnt going through pipes and he is close enough to the block

                    //begins collision

                    //if either the block is less than 20 or doesnt have a units digit of one (units digit of one means invisible question until hit from bottom)
                    if (blocks[i][2]%10 !== 1 | blocks[i][2] < 20) {

                        //checks if something is to the left

                        //if x is between 2.5 inside the right side and just outside the right side
                        //y pos from way above to way below
                        if (enemy[j][0] <= (blocks[i][0] + 25) & enemy[j][0] >= (blocks[i][0] + 20) & (enemy[j][1] > (blocks[i][1] - 20) & enemy[j][1] < (blocks[i][1] + 25))) {

                            enemy[j][2] = 1;//sets x vel to be 1 (goes in opposite direction)

                        }

                        //if x is between 2.5 inside the left side and just outside the left side
                        //y pos from way above to way below
                        if (enemy[j][0] <= (blocks[i][0] - 20) & enemy[j][0] >= (blocks[i][0] - 25) & (enemy[j][1] > (blocks[i][1] - 25) & enemy[j][1] < (blocks[i][1] + 25))) {

                            enemy[j][2] = -1;//sets x vel to be -1 (goes in the opposite direction)

                        }

                        //x is way to left or way to right
                        //y is a block above to 8.5 inside the block (yvel gets up to 7.5!!!)
                        if (enemy[j][1] >= (blocks[i][1] - 25 - enemy[j][3]) & enemy[j][1] <= (blocks[i][1] - 17.5) & enemy[j][0] > (blocks[i][0] - 25) & enemy[j][0] < (blocks[i][0] + 25)) {

                            enemy[j][1] = blocks[i][1] - 25;//y is just outside (remember that huge 8.5 gap?)
                            enemy[j][3] = 0;//sets yvel to 0

                        }

                    } //end of the not invisible if statement

                } //ends collision

            } //end of going through blocks array

            //established gravity for the goomba!
            enemy[j][3] += 0.2;

            //if he is within a good distance from the screen
            if (enemy[j][0] > (-translatePos - 50) & enemy[j][0] < (-translatePos + 425)) {

                enemy[j][5] = true; //WELL GET MOVING YOU DON'T HAVE ALL DAY (sets moving? to true)

            }

            if (enemy[j][1] > 400) { //if the goomba fell off the screen

                //deletes
                enemy[j] = false; //get rid of the specific enemy

            }

            if (enemy[j][0] < 0) { //if it reaches the left side of the screen

                enemy[j][2] = 1; //send it the other way
                enemy[j][0] = 0; //move it back onto the screen

            }

            //moving?
            if (enemy[j][5]) {

                enemy[j][0] += enemy[j][2]; //change x by xvel
                enemy[j][1] += enemy[j][3]; //change y by yvel

            }

            //10 frames of each type of goomba drawing
            if (frameCount%20 < 10) {

                enemyDraw(enemy[j][0], enemy[j][1], 1, true, 0); //left foot out

            } else if (enemy[j]) { //only displys if it isnt dead

                enemyDraw(enemy[j][0], enemy[j][1], 1, false, 0); //right foot out

            }

            //if player has hit goomba from any angle
            if (player[0] > (enemy[j][0] - 25) & player[0] < (enemy[j][0] + 25) & player[1] > (enemy[j][1] - 25 - yInc) & player[1] < (enemy[j][1] + 25) & !dying[0]) {

                if (player[1] < (enemy[j][1] - 17.5 - yInc)) { //if he hits the goomba from above

                    player[3] = -5; //bounce the player up

                    if (keys[UP]) {

                        player[3] = -8;

                    }

                    enemyCount ++; //increase teh count for how many times he bounced an an enemy falling

                    var power = 1; //variable for the power of two a score increases by
                    for (var i = 0; i < (enemyCount - 1); i ++) { //starts at 2^0

                        power *= 2; //multiplies by 2 every time

                    }
                    if (enemyCount <= 4) {

                        score += 100*power; //power multiplied by 100

                    } else if (enemyCount <= 8) {

                        score += 1000*(power/16); //power resets back to 1 and starts over, but the multiplier is 1000

                    } else {

                        lives ++; //1 UP!

                    } //score increase is 100 200 400 800 1000 2000 4000 8000 1UP 1UP 1UP 1UP

                    //x, y, non moving goomba
                    deadGoomba.push([enemy[j][0], enemy[j][1], 1, 40]);
                    enemy[j] = false; //sets enemy as false

                } else if (recover === 0) { //player hits goomba from sides or bottom

                    if (powerups[0]) {

                        powerups[0] = false;
                        player[1] += 25;
                        yInc = 0;
                        recover = 50;

                    } else if (recover === 0) {

                        dying = [true, -10, 0];

                    }

                }

            }

        }

        //resets player values to there is space everywhere (left right up down)
        player[4] = true; //left
        player[5] = true; //right
        player[6] = true; //down
        player[7] = true; //up

        //goes through blocks array
        for (var i = 0; i < blocks.length; i ++) {

            if (!dying[0] & !endLevel & !pipeMov[0]) { //if the level has not ended and if mario isnt going through pipes

                //begins collision

                //if either the block is less than 20 or doesnt have a units digit of one (units digit of one means invisible question until hit from bottom)
                if (blocks[i][2]%10 !== 1 | blocks[i][2] < 20) {

                    //checks if something is to the left

                    //if x is between 2.5 inside the right side and just outside the right side
                    //y pos from way above to way below
                    if (player[0] <= (blocks[i][0] + 25) & player[0] >= (blocks[i][0] + 20) & (player[1] > (blocks[i][1] - 20 - yInc) & player[1] < (blocks[i][1] + 25))) {

                        player[4] = false; //something to the left
                        player[0] = blocks[i][0] + 25;//moves it to the outside so thats its never inside
                        player[2] = 0;//sets x vel to be 0

                    }

                    //if x is between 2.5 inside the left side and just outside the left side
                    //y pos from way above to way below
                    if (player[0] <= (blocks[i][0] - 20) & player[0] >= (blocks[i][0] - 25) & (player[1] > (blocks[i][1] - 25 - yInc) & player[1] < (blocks[i][1] + 25))) {

                        player[5] = false;//something to the right
                        player[0] = blocks[i][0] - 25;//moves outside
                        player[2] = 0;//sets x vel to be 0

                    }

                    //x is way to left or way to right
                    //y is a block above to 8.5 inside the block (yvel gets up to 7.5!!!)
                    if (player[1] >= (blocks[i][1] - 25 - player[3] - yInc) & player[1] <= (blocks[i][1] - 17.5) & player[0] > (blocks[i][0] - 25) & player[0] < (blocks[i][0] + 25)) {

                        player[6] = false;//something below
                        player[1] = blocks[i][1] - 25 - yInc;//y is just outside (remember that huge 8.5 gap?)
                        player[3] = 0;//sets yvel to 0
                        jump = false;//end of a jump
                        enemyCount = 0; //resets streak to 0

                    }

                } //end of the not invisible if statement

                //up is special because when there are a lot of blocks in a row, you ma hit multiple
                //this is system makes sure you only hit one and its the right one

                var openLeft = true, openRight = true; //variables to see if there is a block to the left or right, initially says no block

                //if x is all the way to all the way right
                //y is just below to inside 7.5, taking yvel into account
                if (player[1] >= (blocks[i][1] + 17.5) & player[1] <= (blocks[i][1] + 25 - player[3]) & player[0] > (blocks[i][0] - 23) & player[0] < (blocks[i][0] + 23)) {

                    //goes through array of the blocks
                    for (var j = 0; j < blocks.length; j ++) {

                        //same y, x a block to the left
                        if (blocks[j][1] === blocks[i][1] &  blocks[j][0] === (blocks[i][0] - 25)) {

                            openLeft = false;//block to left

                        }
                        //same y, x a block to the right
                        if (blocks[j][1] === blocks[i][1] &  blocks[j][0] === (blocks[i][0] + 25)) {

                            openRight = false;//block to right

                        }

                    }

                    //if left is open then x can be all the way left
                    //if left is closed then x can only be 10 to the left (hat hits block)

                    //if right is open then x can be all the way right
                    //if right is closed then x can only be 15 to the right (hat still hits block)
                    if ((openLeft | (!openLeft & player[0] > (blocks[i][0] - 10))) & (openRight | (!openRight & player[0] <= (blocks[i][0] + 15)))) {

                        player[7] = false; //sets space above to false (something is above)
                        player[1] = blocks[i][1] + 25; //moves outside
                        player[3] = 1.5; //bounces off (y vel becomes 1)

                        //goes through the array to check if you hit any enemies from below!
                        for (var k = 0; k < enemy.length; k ++) {

                            //x is within and y is just on top the block
                            if ((enemy[k][0] - blocks[i][0]) > -25 & (enemy[k][0] - blocks[i][0]) < 25 & (enemy[k][1] - blocks[i][1]) > -27 & (enemy[k][1] - blocks[i][1]) < -23) {

                                //x, y, flies off the screen
                                deadGoomba.push([enemy[k][0], enemy[k][1], 2]);
                                enemy[k] = false; //delete the enemy

                            }

                        }

                        //if the block is less than 10, one of the non invisible question blocks
                        //player must be going up and adn it cannot be a plain square or unbreakable one
                        if (((blocks[i][2] > 0 & blocks[i][2] < 10) | (blocks[i][2] >= 50 & blocks[i][2] < 100)) & blocks[i][2] !== 3 & blocks[i][2] !== 2 & player[3] === 1.5) {

                            blocks[i][4] = true; //bouncing
                            blocks[i][5] = -2; //yvel is -2 (going up)
                            blocks[i][3] = 0; //resets offset

                        }

                        if (blocks[i][2] === 9 | blocks[i][2] === 90 | blocks[i][2] === 91) {

                            //x, y, xvel, yvel, type, origHeight
                            qAnimation.push([blocks[i][0], blocks[i][1] - 5, 0.75, 0, 2, blocks[i][1], false]);

                        } else if ((blocks[i][2] >= 5 & blocks[i][2] <= 8) | (blocks[i][2] >= 50 & blocks[i][2] <= 80) | (blocks[i][2] >= 51 & blocks[i][2] <= 81)) {

                            coin ++; //increases amount of coins

                            //x, y, xvel, yvel, type
                            qAnimation.push([blocks[i][0], blocks[i][1] - 5, 0, -10, 1]);

                        }

                        if (powerups[0] & blocks[i][2] === 4) {

                            blocks[i] = false;

                        } else {

                            //invisible Q blocks or visible Q block AND it has only a capacity of one
                            if ((blocks[i][2] >= 40 | (blocks[i][2] >= 5 & blocks[i][2] <= 9)) & blocks[i][6] <= 1) {

                                blocks[i][2] = 3; //changes to plain square

                            } else {

                                blocks[i][6] --;

                            }

                        }

                    }

                } //end of up collision

                //bouncing and a normal block ( can be invisible or disguised )
                if (blocks[i][4] & ((blocks[i][2] > 0 & blocks[i][2] < 10) | (blocks[i][2] >= 50 & blocks[i][2] < 100))) {

                    blocks[i][3] += blocks[i][5]; //increase the y offset by the y velocity
                    blocks[i][5] += 0.225; //increase the y velocity by the "gravity"

                    if (blocks[i][3] >= 0) { //if the y offset comes back to its normal position

                        blocks[i][4] = false; //no more bounce :(
                        blocks[i][3] = 0; //resets offset

                    }

                }

            } //ends collision

        } //end of going through blocks array

        //goes through pipes array
        for (var i = 0; i < pipes.length; i ++) {

            //only if the value is an array (normal pipes dont need this)
            if (pipes[i][2].length > 1) {

                //facing UP
                if (pipes[i][2][4] === 0) {

                    //player x is completely inside the pipe, he is right on top and down arrow clicked
                    if (player[0] <= (pipes[i][0] + 25) & player[0] >= pipes[i][0] & (player[1] >= (pipes[i][1] - 26 - yInc) & player[1] < (pipes[i][1] - 22.5)) & keys[DOWN]) {

                        pipeMov[0] = true; //start moving through pipes

                    }

                    if (pipeMov[0]) { //if moving through pipes

                        //x inside completely and y is far enough above
                        if (player[1] < (pipes[i][1] + yInc) & player[0] <= (pipes[i][0] + 25) & player[0] >= pipes[i][0]) {

                            player[1] ++; //moves player down the pipe

                        } else if (player[0] <= (pipes[i][0] + 25) & player[0] >= pipes[i][0]) { //reaches the bottom but is still within the pipe's x

                            lvlStage = pipes[i][2][0]; //changes the lvlStage
                            player[0] = pipes[i][2][1]; //changes player position
                            player[1] = pipes[i][2][2];
                            first = true;//sets first to be true

                            pipeMov[1] = pipes[i][2][0];//sets values of pipeMov because this pipe will be deleted with first
                            pipeMov[2] = pipes[i][2][1];
                            pipeMov[3] = pipes[i][2][2];
                            pipeMov[4] = pipes[i][2][3];
                            pipeMov[5] = pipes[i][2][4];

                            pipeMov[6] = true; //marks the beginning of the next stage

                        }

                    }

                } else if (pipes[i][2][4] === 2) { //facing LEFT

                    //player to direct left and y inside boundaries
                    //clicking right, or in the auto part of 1-2, where he goes into a pipe by himself
                    if (player[1] <= (pipes[i][1] + 25 - yInc) & player[1] >= pipes[i][1] & (player[0] >= (pipes[i][0] - 26) & player[0] < (pipes[i][0] - 22.5)) & (keys[RIGHT] | (levelNum === 1 & lvlStage === 0))) {

                        pipeMov[0] = true; //start moving through the pipes

                    }

                    if (pipeMov[0]) { //if he is moving through the pipes

                        //if the y values are still the same and the player isnt far enough right
                        if (player[0] < pipes[i][0] & player[1] <= (pipes[i][1] + 25 - yInc) & player[1] >= pipes[i][1]) {

                            player[0] ++; //move the player right

                        } else if (player[1] <= (pipes[i][1] + 25 - yInc) & player[1] >= pipes[i][1]) { //if the y value is still the same

                            lvlStage = pipes[i][2][0];//change the stage

                            player[0] = pipes[i][2][1];//change player's position
                            player[1] = pipes[i][2][2];
                            first = true;//initializes the new level

                            pipeMov[1] = pipes[i][2][0]; //changes pipeMov values bc pipe array emptied
                            pipeMov[2] = pipes[i][2][1]; //with first
                            pipeMov[3] = pipes[i][2][2];
                            pipeMov[4] = pipes[i][2][3];
                            pipeMov[5] = pipes[i][2][4];

                            pipeMov[6] = true;//begins second part (after having moved)

                        }

                    } //end of if moving through pipes

                }

            } //end of if facing left

        } //end of going through the pipes array

        if (pipeMov[6]) {//if he is in the next room BEGIN PHASE TWO

            if (pipeMov[4] === 0) { //he goes up into the place

                if (player[1] > (pipeMov[3] - 25 - yInc)) { //if he isnt too high

                    player[1] --; //moves the player up

                } else { //once he gets high enough

                    pipeMov[0] = false; //no longer moving through pipes
                    pipeMov[6] = false; //no longer stage 2 of pipe movement
                    player[3] = 0; //yvel reset to 0
                    player[2] = 0; //xvel reset to 0

                }

            } else if (pipeMov[4] === 1) { //he descends

                if (player[1] < (pipeMov[3] + 25)) { //if he isnt too low

                    player[1] ++; //move player down

                } else { //once he goes far enough down

                    pipeMov[0] = false; //no longer moving through pipes
                    pipeMov[6] = false; //no longer stage 2
                    player[2] = 0; //xvel reset to 0
                    player[3] = 0; //yvel reset to 0

                }

            } else if (pipeMov[4] === 2) { //he goes left

                if (player[0] > (pipeMov[0] - 25)) { //if he isnt too far left

                    player[0] --; //move the player left

                } else { //once he gets far enough

                    pipeMov[0] = false; //he is no longer moving through pipes
                    pipeMov[6] = false; //no longer in stage 2
                    player[2] = 0; //xvel reset to 0
                    player[3] = 0; //yvel reset to 0

                }

            } else { //he goes right

                if (player[0] > (pipeMov[1] + 25)) { //if he isnt too far right

                    player[0] ++; //move right

                } else { //once he makes it all the way right

                    pipeMov[0] = false; //no longer moving through pipes
                    pipeMov[6] = false; //no longer in stage 2
                    player[3] = 0; //yvel reset to 0
                    player[2] = 0; //xvel reset to 0

                }

            } //end of ifs concerning which way mario comes out of the pipe

        } //end of if stage 2 of mario's pipe adventure

        for (var i = 0; i < qAnimation.length; i ++) {

            if (qAnimation[i][4] === 1) { //coin

                bounceCoin(qAnimation[i][0], qAnimation[i][1], floor(frameCount/3)%8); //draws a coin

                qAnimation[i][3] += 0.625; //gravity for coin
                qAnimation[i][1] += qAnimation[i][3]; //established yvelocity

                if (qAnimation[i][3] > 6) { //if it is going fast enough down

                    qAnimation[i] = false; //get rid of it
                    score += 200;

                }

            } else if (qAnimation[i][4] === 2) { //mushroom

                powerUp(qAnimation[i][0], qAnimation[i][1], 1); //draws a mushroom

                if (qAnimation[i][1] > (qAnimation[i][5] - 25) & !qAnimation[i][6]) {

                    qAnimation[i][1] -= 2;

                } else {

                    qAnimation[i][6] = true;

                }

                if (qAnimation[i][6]) {

                    //goes through blocks array to see if there is movement anywhere
                    for (var j = 0; j < blocks.length; j ++) {

                        if (!dying[0] & !endLevel & blocks[j][0] > (qAnimation[i][0] - 30) & blocks[j][0] < (qAnimation[i][0] + 30) & blocks[j][1] > (qAnimation[i][1] - 30) & blocks[j][1] < (qAnimation[i][1] + 30)) { //if the level has not ended and if mario isnt going through pipes and he is close enough to the block

                            //begins collision

                            //if either the block is less than 20 or doesnt have a units digit of one (units digit of one means invisible question until hit from bottom)
                            if (blocks[j][2]%10 !== 1 | blocks[j][2] < 20) {

                                //checks if something is to the left

                                //if x is between 2.5 inside the right side and just outside the right side
                                //y pos from way above to way below
                                if (qAnimation[i][0] <= (blocks[j][0] + 25) & qAnimation[i][0] >= (blocks[j][0] + 20) & (qAnimation[i][1] > (blocks[j][1] - 20) & qAnimation[i][1] < (blocks[j][1] + 25))) {

                                    qAnimation[i][2] = 0.75;//sets x vel to be 1 (goes in opposite direction)

                                }

                                //something to the right?

                                //if x is between 2.5 inside the left side and just outside the left side
                                //y pos from way above to way below
                                if (qAnimation[i][0] <= (blocks[j][0] - 20) & qAnimation[i][0] >= (blocks[j][0] - 25) & (qAnimation[i][1] > (blocks[j][1] - 25) & qAnimation[i][1] < (blocks[j][1] + 25))) {

                                    qAnimation[i][2] = -0.75;//sets x vel to be -1 (goes in the opposite direction)

                                }

                                //something below?

                                //x is way to left or way to right
                                //y is a block above to 8.5 inside the block (yvel gets up to 7.5!!!)
                                if (qAnimation[i][1] >= (blocks[j][1] - 25 - qAnimation[i][3]) & qAnimation[i][1] <= (blocks[j][1] - 17.5) & qAnimation[i][0] > (blocks[j][0] - 25) & qAnimation[i][0] < (blocks[j][0] + 25)) {

                                    qAnimation[i][1] = blocks[j][1] - 25;//y is just outside (remember that huge 8.5 gap?)
                                    qAnimation[i][3] = 0;//sets yvel to 0

                                }

                            } //end of the not invisible if statement

                        } //ends collision

                    } //end of going through blocks array

                    //established gravity for the mushroom
                    qAnimation[i][3] += 0.17;

                    //if he is within a good distance from the screen
                    if (qAnimation[i][0] > (-translatePos - 50) & qAnimation[i][0] < (-translatePos + 425)) {

                        qAnimation[i][9] = true; //WELL GET MOVING YOU DON'T HAVE ALL DAY (sets moving? to true)

                    }

                    if (qAnimation[i][0] < 0) { //if it reaches the left side of the screen

                        qAnimation[i][2] = 0.75; //send it the other way
                        qAnimation[i][0] = 0; //move it back onto the screen

                    }

                    //moving?
                    if (qAnimation[i][9]) {

                        qAnimation[i][0] += qAnimation[i][2]; //change x by xvel
                        qAnimation[i][1] += qAnimation[i][3]; //change y by yvel

                    }

                    qAnimation[i][1] += qAnimation[i][3]; //established yvelocity
                    qAnimation[i][0] += qAnimation[i][2]; //established yvelocity

                    if (qAnimation[i][1] > 400) { //if the mushroom fell off the screen

                        //deletes
                        qAnimation[i] = false; //get rid of the specific enemy

                    }

                    //if player has hit mushroom
                    if (player[0] > (qAnimation[i][0] - 25) & player[0] < (qAnimation[i][0] + 25) & player[1] > (qAnimation[i][1] - 25 - yInc) & player[1] < (qAnimation[i][1] + 25)) {

                        if (!powerups[0]) {

                            powerups[0] = true; //big mario
                            yInc = 25;
                            player[1] -= yInc; //moves him up to avoid being stuck in the ground

                        }

                        //deletes
                        qAnimation[i] = false; //get rid of the specific enemy
                        score += 1000;

                    }

                }

            }

        }

        for (var i = 0; i < deadGoomba.length; i ++) {

            if (deadGoomba[i][2] === 1) { //squished goomba sprite

                if (deadGoomba[i][3] > 0) { //if there is still time

                    enemyDraw(deadGoomba[i][0], deadGoomba[i][1], 1, false, 1); //draws a squished goomba

                    deadGoomba[i][3] --; //timer counting down!

                } else { //OUT OF TIME

                    deadGoomba[i] = false; //no more squished goomba

                }

            } else if (deadGoomba[i][2] === 2) { //flying of the screen upside down



            }

        }

        for (var i = 0; i < coins.length; i ++) {

            if (coins[i]) {

                powerUp(coins[i][0], coins[i][1], 4);

            }

            if (player[0] > (coins[i][0] - 19) & player[0] < (coins[i][0] + 15) & player[1] > (coins[i][1] - 25 - yInc) & player[1] < (coins[i][1] + 25)) {

                valueDelete(coins[i][0], coins[i][1], 0);

                coins[i] = false;
                coin ++;
                score += 200;

            }

        }

        //goes max 2 x vel except when u r big
        if (!keys[RIGHT] & keys[LEFT] & player[4] & ((player[2] > -2 & !powerups[0]) | (player[2] > -2.25 & powerups[0]))) { //clicking only left, there is a space left and you aren't going too fast

            if (player[2] > 0) { //immediate turn left if you are going right

                player[2] = 0; //resets x velocity to 0

            }

            player[2] -= 0.1; //decreases x velocity slowly to create speed

        }
        if (!keys[LEFT] & keys[RIGHT] & player[5] & ((player[2] < 2 & !powerups[0]) | (player[2] < 2.25 & powerups[0]))) { //clicking only right, there is a space right and you aren't going too fast

            if (player[2] < 0) { //immediate turn right when going left

                player[2] = 0; //resets x velocity to 0

            }

            player[2] += 0.1; //increases x velocity y slowly creating speed

        }

        //goes max 2 x vel except when u r big
        if (!keys[RIGHT] & keys[LEFT] & player[3] === 0 & player[2] > -4 & keys[88]) { //clicking only left, there is a space left and you aren't going too fast

            player[2] -= 0.25; //decreases x velocity slowly to create speed

        } else if (!keys[88] & player[2] < -2) {

            player[2] += 0.1;

        }
        //goes max 2 x vel except when u r big
        if (!keys[LEFT] & keys[RIGHT] & player[3] === 0 & player[2] < 4 & keys[88]) { //clicking only left, there is a space left and you aren't going too fast

            player[2] += 0.25; //decreases x velocity slowly to create speed

        } else if (!keys[88] & player[2] > 2) {

            player[2] -= 0.1;

        }

        if ((!keys[LEFT] & !keys[RIGHT]) | (keys[RIGHT] & keys[LEFT])) { //if neither are held or if both are

            player[2] /= 1.1; //the slow down

        }

        if (!player[6] & player[7]) { //space up but not space down

            if (firstClick[UP]) { //if you are holding the up button on the ground

                //initial upward velocity is 8
                player[3] = -8;

                //sets jump to true for spriting purposes
                jump = true;

            } else {

                player[3] = 0; //should not be moving up or down with no place to go down :D

            }

        } else if (player[3] < 7.5) { //if there is no place to go down, then

//                         vv     cuz 0.3 just aint gud enuf
            player[3] += 0.31; //ENFORCE GRAVITY... BWAHAHAHAHAHA

        }

        //in the first part of 1-2, mario is moved by the
        if (levelNum === 1 & lvlStage === 0) {

            player[2] = 2;
            player[3] = 0;

        }

        if (!dying[0] & !endLevel & !pipeMov[0]) { //if its not the end of the level or moving through pipes (movement there is done with casework!

            player[0] += player[2]; //change x by x velocity

            player[1] += player[3]; //change y by y velocity

        }

        if (!pipeMov[0]) {

            player[0] = constrain(player[0], -translatePos, 25*maps[levelNum][lvlStage][0].length - 25); //dont let the player go off the screen

        }

        if (player[2] > 0 & !jump) { //if he is going right

            goingLeft = false; //not going left

        } else if (player[2] < 0 & !jump) { //if he is going left

            goingLeft = true; //is going left

        }

        if (powerups[0]) {

            yInc = 25;

        } else {

            yInc = 0;

        }

        //drawing different stages of mario running

        if (recover === 0 | frameCount%10 <= 5) {

            if (keys[88]) {

                timer += 2;

            } else {

                timer ++;

            }

            if (powerups[0] & !dying[0]) {

                //not in the castle
                if (player[0] < (endX + 150)) {

                    //passed the flag!
                    if (endLevel) {

                        //on top of the block and on the floor running
                        if ((abs(player[1] - 300) < 0.2 | (player[0] < (endX + 25) & player[0] > (endX - 10))) & player[0] < (endX + 200)) { //running sequence

                            //5 frames of a sequence of sprites: 2324
                            if (timer%20 < 5) {

                                bigMario (2, player[0], player[1]);

                            } else if (timer%20 < 10) {

                                bigMario (3, player[0], player[1]);

                            } else if (timer%20 < 15) {

                                bigMario (2, player[0], player[1]);

                            } else {

                                bigMario (4, player[0], player[1]);

                            }

                        } else if (player[0] < endX) { //going down the flag

                            bigMario (4, player[0], player[1], false);

                        } else if (player[1] < 325) { //falling of the block

                            bigMario (4, player[0], player[1], false);

                        } else { //just standing there

                            bigMario (1, player[0], player[1], false);

                        }

                    } else if (pipeMov[0]) { //going down a pipe means he isnt moving, just standing there

                        bigMario(1, player[0], player[1]);

                    } else if (jump) { //if he is in the middle of a jump

                        bigMario(5, player[0], player[1], goingLeft);

                    } else if (abs(player[3]) > 0.1) { //falling from a non-jump

                        bigMario (4, player[0], player[1], goingLeft);

                    } else if (abs(player[2]) < 0.05) { //standing still (basically)

                        bigMario (1, player[0], player[1], goingLeft);

                    } else { //running!

                        //5 frames in sequence 2324
                        if (timer%20 < 5) {

                            bigMario (2, player[0], player[1], goingLeft);

                        } else if (timer % 20 < 10) {

                            bigMario (3, player[0], player[1], goingLeft);

                        } else if (timer%20 < 15) {

                            bigMario (2, player[0], player[1], goingLeft);

                        } else {

                            bigMario (4, player[0], player[1], goingLeft);

                        }

                    }

                }

            } else if (!dying[0]) {

                //not in the castle
                if (player[0] < (endX + 150)) {

                    //passed the flag!
                    if (endLevel) {

                        //on top of the block and on the floor running
                        if ((abs(player[1] - 325) < 0.2 | (player[0] < (endX + 25) & player[0] > (endX - 5))) & player[0] < (endX + 200)) { //running sequence

                            //5 frames of a sequence of sprites: 2324
                            if (timer%20 < 5) {

                                smallMario (2, player[0], player[1]);

                            } else if (timer%20 < 10) {

                                smallMario (3, player[0], player[1]);

                            } else if (timer%20 < 15) {

                                smallMario (2, player[0], player[1]);

                            } else {

                                smallMario (4, player[0], player[1]);

                            }

                        } else if (player[0] < endX) { //going down the flag

                            smallMario (4, player[0], player[1], false);

                        } else if (player[1] < 325) { //falling of the block

                            smallMario (4, player[0], player[1], false);

                        } else { //just standing there

                            smallMario (1, player[0], player[1], false);

                        }

                    } else if (pipeMov[0]) { //going down a pipe means he isnt moving, just standing there

                        smallMario(1, player[0], player[1]);

                    } else if (jump) { //if he is in the middle of a jump

                        smallMario(5, player[0], player[1], goingLeft);

                    } else if (abs(player[3]) > 0.1) { //falling from a non-jump

                        smallMario (4, player[0], player[1], goingLeft);

                    } else if (abs(player[2]) < 0.05) { //standing still (basically)

                        smallMario (1, player[0], player[1], goingLeft);

                    } else { //running!

                        //5 frames in sequence 2324
                        if (timer%20 < 5) {

                            smallMario (2, player[0], player[1], goingLeft);

                        } else if (timer % 20 < 10) {

                            smallMario (3, player[0], player[1], goingLeft);

                        } else if (timer%20 < 15) {

                            smallMario (2, player[0], player[1], goingLeft);

                        } else {

                            smallMario (4, player[0], player[1], goingLeft);

                        }

                    }

                }

            }

        }

        //draws all the blocks
        for (var i = 0; i < blocks.length; i ++) {

            pushMatrix();

            translate(0, blocks[i][3]);

            var blockType = 0;

            if ((levelNum === 0 & lvlStage === 1) | (levelNum === 1 & lvlStage === 1)) {

                blockType = 1;

            }

            if (blocks[i][0] <= (-translatePos + 400) & blocks[i][0] >= (-translatePos - 25)) {

                if (blocks[i][2] <= 4 & blocks[i][2] > 0) {

                    image(blockImage[blocks[i][2] - 1][blockType], blocks[i][0], blocks[i][1]);

                } else if (blocks[i][2] === 50 | blocks[i][2] === 60 | blocks[i][2] === 70 | blocks[i][2] === 80 | blocks[i][2] === 90) {

                    //draws a brick
                    image(blockImage[3][blockType], blocks[i][0], blocks[i][1]);

                } else if (blocks[i][2] >= 5 & blocks[i][2] <= 9) {

                    question (floor(frameCount/3)%8, blocks[i][0], blocks[i][1]);

                }

            }
            popMatrix();

        }

        //draws the pipes
        for (var i = 0; i < pipes.length; i ++) {

            if (pipes[i][0] > (-translatePos - 51) & pipes[i][0] < (-translatePos + 401)) {

                if (pipes[i][2] >= 100) {

                    if (pipes[i][2] === 100) { //facing up!

                        var below = false;
                        var other1 = false;
                        var other2 = false;

                        for (var j = 0; j < pipes.length; j ++) {

                            if (pipes[i][1] === (pipes[j][1] + 25) & pipes[i][0] === pipes[j][0] & (pipes[i][2] === 100 | pipes[i][2][4] === 0)) {

                                below = true;

                            }

                            if (pipes[i][0] === (pipes[j][0] + 25) & pipes[i][1] === pipes[j][1]) {

                                other1 = true;

                            }

                            if (pipes[i][0] === (pipes[j][0] + 25) & pipes[i][1] === (pipes[j][1] + 25)) {

                                other2 = true;

                            }

                        }

                        if (other1) {

                            pipe(5, pipes[i][0], pipes[i][1]);

                        } else if (!other2) {

                            //in the underworld of level 1, the vertical pipe just ends without a top part
                            if (below | (levelNum === 0 & lvlStage === 1)) {

                                pipe(2, pipes[i][0], pipes[i][1]);

                            } else {

                                pipe(1, pipes[i][0], pipes[i][1]);

                            }

                        }

                    } else if (pipes[i][2] === 102) { //facing left!

                        var toLeft = false;
                        var other = false;

                        for (var j = 0; j < pipes.length; j ++) {

                            if (pipes[i][0] === (pipes[j][0] + 25) & pipes[i][1] === pipes[j][1] & (pipes[i][2] === 102 | pipes[i][2][4] === 2)) {

                                toLeft = true;

                            }

                        }

                        if (toLeft) {

                            pipe(4, pipes[i][0], pipes[i][1]);

                        } else {

                            pipe(3, pipes[i][0], pipes[i][1]);

                        }

                    }

                } else {

                    if (pipes[i][2][4] === 0) { //facing up!

                        var below = false;

                        for (var j = 0; j < pipes.length; j ++) {

                            if (pipes[i][1] === (pipes[j][1] + 25) & pipes[i][0] === pipes[j][0] & (pipes[i][2] === 100 | pipes[i][2][4] === 0)) {

                                below = true;

                            }

                        }

                        //in the underworld of level 1, the vertical pipe just ends without a top part
                        if (below | (levelNum === 0 & lvlStage === 1)) {

                            pipe(2, pipes[i][0], pipes[i][1]);

                        } else {

                            pipe(1, pipes[i][0], pipes[i][1]);

                        }

                    } else if (pipes[i][2][4] === 2) { //facing left!

                        var toLeft = false;

                        for (var j = 0; j < pipes.length; j ++) {

                            if (pipes[i][0] === (pipes[j][0] + 25) & pipes[i][1] === pipes[j][1] & (pipes[i][2] === 102 | pipes[i][2][4] === 2)) {

                                toLeft = true;

                            }

                        }

                        if (toLeft) {

                            pipe(4, pipes[i][0], pipes[i][1]);

                        } else {

                            pipe(3, pipes[i][0], pipes[i][1]);

                        }

                    }

                }

            }

        }

        if (player[1] >= 450) {

            dying = [true, -10, 1];

        }

        pushMatrix();

        translate (endX - 15, 50);

        scale(25/16);
        noStroke ();

        pushMatrix(); //separate part for the flag because moves

        translate(0, flagY); //moves the flag down at the end

        fill (252, 252, 252); //white part of the flag

        for (var a = 0; a < 17; a ++) { //draws the white layer of the flag

            rect (a, a + 15.5, 17 - a, 1.5);

        }

        fill (16, 148, 0); //draws the little logo on the flag
        rect (9, 18, 1, 5);
        rect (10, 21, 2, 2);
        rect (11, 22, 3, 2);
        rect (13, 21, 3, 2);
        rect (15, 18, 1, 5);
        rect (11, 20, 3, 1);
        rect (10, 17, 5, 1);
        rect (10, 18, 1, 1);
        rect (14, 18, 1, 1);
        rect (12, 18, 1, 2);

        popMatrix();

        fill (140, 214, 0); //draws the pole
        rect (17, 16, 2, 160);

        fill (0, 0, 0); //draws the ball outline
        rect (14, 10, 8, 4);
        rect (16, 8, 4, 8);
        rect (15, 9, 6, 6);

        fill (16, 148, 0); //ball inside
        rect (15, 10, 6, 4);
        rect (16, 9, 4, 6);

        fill (140, 214, 0); //ball shine
        rect (15, 10, 1, 2);
        rect (16, 9, 1, 1);

        popMatrix();

        //flag mario animation at the end of a level
        if (player[0] > (endX - 12.5)) {

            endLevel = true; //so that his movement is only manually contoled in this if statement
            player[2] = 0; //no x and y velocity
            player[3] = 0;

            if (player[1] < (300 - yInc)) { //if he hasn't made it to the bottom of the bottom of the flag pole

                player[1] += 3; //move mario down fairly quickly

                if (flagY < 137.5) {

                    flagY += 2; //really quick

                }

                player[0] = endX - 12;

            } else if (flagY < 137.5) { //then move the flag pole down

                flagY += 2; //really quick

            } else {

                flagY = 140.5;

                if (player[0] < (endX + 150)) { //moves forward until to the castle

                    player[0] += 2; //slowly

                }

                if (player[0] > (endX + 25) & player[1] < (325 - yInc)) { //if he is off the block but not on the ground

                    player[1] += (player[1] - 290 + yInc)/10; //move him down, by how low he already is

                } else if (player[0] > (endX + 50)) { //if he is past the block (well past it)

                    player[1] = 325 - yInc; //reset his y values to exactly on the ground

                }

            }

        } //end of flag animation

        if (dying[0]) {

            smallMario(6, player[0], player[1]);

        }

        popMatrix();

        if (timeLeft <= 0 & !endLevel & !dying[0]) {

            dying = [true, -10];

        }

        //makes the time go down
        if (frameCount%40 === 0 & !endLevel) {

            if (timeLeft > 0) {

                timeLeft --;

            } else {

                timeLeft = 0;

            }

        } else if (endLevel & player[0] >= (endX + 150)) {

            if (timeLeft > 0) {

                timeLeft --;
                score += 50;

            } else {

                if (levelNum < (maps.length - 1)) {

                    levelNum ++;
                    first = true;
                    endLevel = false;
                    playerReset = true;
                    timeLeft = 400;
                    savedScore = score;

                }

            }

        }

        if (recover > 0) { //if the timer is on for when mario just died

            recover --; //countdown on the timer

        }

        if (dying[0]) {

            dying[1] += 0.5;
            player[1] += dying[1];

            if (dying[1] > 0 & player[1] > 450) {

                if (dying[2] === 1) {

                    powerups = [false, false, false];

                }

                playerReset = true;
                first = true;
                timeLeft = 400;
                dying[0] = false;

                //turns on the death screen
                death = [true, 150];

                //decreases number of lives (bc mario died)
                lives --;

            }

        }

        if (playerReset) { //executed at the VERY END when the player dies

            //resets time
            timeLeft = 400;

            //reset player values
            player = [50, 325, 0.01, 0, true, true, true, true];

            //translate to very left
            translatePos = 0;

            //x, y, xvel, yvel, left open, right open, down open, up open, type, active?
            //not many enemies, so enemies are added manually!
            if (levelNum === 0) {

                enemy = [[550, 325, -1, 0, 1, false], [975, 325, -1, 1, false], [1250, 325, -1, 0, 1, false], [1300, 325, -1, 0, 1, false], [1950, 125, -1, 0, 1, false], [2000, 125, -1, 0, 1, false]];

            }

            score = savedScore;

            first = true; //level resets

            invincible = 0;

            playerReset = false; //doesnt constantly kill him

        }

    }
    //all the text at the top
    txt("MARIO", 37.5, 25);
    scoreText = score.toString();
    for (var i = 0; i < (6 - scoreText.length); i ++) {

        txt("0", 37.5 + i*12.5, 37.5);

    }
    txt(scoreText, 37.5 + (6 - scoreText.length)*12.5, 37.5);

    if (coin >= 10) {

        txt("×" + coin, 150, 37.5);

    } else {

        txt("×0" + coin, 150, 37.5);

    }

    txt("WORLD", 225, 25);
    txt("1-"+(levelNum + 1), 237.5, 37.5);

    txt("TIME", 312.5, 25);

    timeLeftText = timeLeft.toString();
    for (var i = 0; i < (3 - timeLeftText.length); i ++) {

        txt("0", 325 + i*12.5, 37.5);

    }
    txt(timeLeftText, 325 + (3 - timeLeftText.length)*12.5, 37.5);

    powerUp(125, 25, 4); //draws a coin

    //useful for placing enemies!
    /*
    if (mouseIsPressed) {
        fill(0, 0, 0);
        text("x: " + floor((mouseX - translatePos)/25)*25 + ", y: " + floor(mouseY/25)*25, 200, 200);
    }
    */

};
