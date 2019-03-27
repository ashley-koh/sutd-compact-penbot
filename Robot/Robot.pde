import processing.serial.*;

Serial Mega, Nano;
String val;

int totalFrames = 120;
int counter = 0;

int eyeWidth = 150;
int eyeHeight = 150;
int eyeRadius = 30;
int eyeSpacing = 200;

float x, y, minX, minY, maxX, maxY, targetX, targetY;
float easingConst = 0.02;


char currentDirection = 's'; // 
String currentEmotion = "n"; // n, h, s, b, a
Boolean randomEmotion = false;
Boolean blinking = false;


DrawEyes Eyes = new DrawEyes(eyeWidth, eyeHeight, eyeRadius);

void setup() {
  size(800, 480);
  //fullScreen();
  printArray(Serial.list());
  String portMega = Serial.list()[1]; //"/dev/ttyACM0
  String portNano = Serial.list()[3]; //"/dev/ttyUSB0
  //String
  Mega = new Serial(this, portMega, 9600); // Mega.write("Whatever String");
  Nano = new Serial(this, portNano, 9600); // Handling Movement
  
  x = width/2;
  y = height/2;
  maxX = width - eyeWidth/2 - eyeSpacing/2 - 50;
  maxY = height - eyeHeight/2 - 50;
  minX = eyeWidth/2 + eyeSpacing/2 + 50;
  minY = eyeHeight/2 + 50;
}

void draw() {
  counter++;
  if (counter > totalFrames) {
     //emotion();
     if (random(0, 100) >= 80)
       blinking = true;
     else
       blinking = false;
     counter = 0;
  }
  render();
  //Nano.write(currentDirection);
  //println("Sending Nano: " + currentDirection);
  //Mega.write(currentEmotion);
  //println("Sending Mega: " + currentEmotion);
}

void render() {
  background(0);
  Eyes.targetPos(targetX, targetY);
  if (blinking)
    Eyes.blink();
    
  Eyes.happy(102, 204, 255);
  Eyes.randomPos();
}

void emotion() {
  if (randomEmotion) {
    float random = random(0, 100);
    if (random <= 10)
      currentEmotion = "h";
    if (random > 25 && random <= 35)
      currentEmotion = "s";
    if (random > 50 && random <= 60)
      currentEmotion = "b";
    if (random > 75 && random <= 85)
      currentEmotion = "n";
    if (random > 85)
      currentEmotion = "a";
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      currentDirection = 'f';
    } else if (keyCode == DOWN) {
      currentDirection = 'b';
    } else if (keyCode == RIGHT) {
      currentDirection = 'r';
    } else if (keyCode == LEFT) {
      currentDirection = 'l'; 
    } 
  }
  
  if (key == 'h') {
    
    println("sending Mega: h");
    //currentEmotion = " h";
    Mega.write(" h");
  }
  if (key == 'n') {
    println("sending Mega: n");
    //currentEmotion = "n";
    Mega.write(" n");
  }
  if (key == 's') {
    println("sending Mega: s");
    //currentEmotion = "s";
    Mega.write(" s");
  }
  if (key == 'b') {
    println("sending Mega: b");
    //currentEmotion = "b";
    Mega.write(" b");
  }
  if (key == 'a') {
    println("sending Mega: a");
    //currentEmotion = "a";
    Mega.write(" a");
  }
}

void keyReleased() {
  if (key == CODED) {
     currentDirection = 's'; 
  }
}
