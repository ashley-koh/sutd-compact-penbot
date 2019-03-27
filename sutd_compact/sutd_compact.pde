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
  //String portMega = Serial.list()[0];
  String portNano = Serial.list()[0];
  //String
  //Mega = new Serial(this, portName, 9600); // Mega.write("Whatever String");
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
     emotion();
     if (random(0, 100) >= 80)
       blinking = true;
     else
       blinking = false;
     counter = 0;
  }
  render();
  Nano.write(currentDirection);
  println("Sending: " + currentDirection);
}

void render() {
  background(0);
  Eyes.targetPos(targetX, targetY);
  if (blinking)
    Eyes.blink();
    
  Eyes.neutral(102, 204, 255);
  Eyes.randomPos();
}

void emotion() {
  if (randomEmotion) {
    float random = random(0, 100);
    if (random <= 10)
      currentEmotion = "happy";
    if (random > 25 && random <= 35)
      currentEmotion = "sad";
    if (random > 50 && random <= 60)
      currentEmotion = "bored";
    if (random > 75 && random <= 85)
      currentEmotion = "neutral";
    if (random > 85)
      currentEmotion = "angry";
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
}

void keyReleased() {
  if (key == CODED) {
     currentDirection = 's'; 
  }
}
