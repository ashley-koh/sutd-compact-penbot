let totalFrames = 120;
let counter = 0

let eyeWidth = 100;
let eyeHeight = 100;
let eyeRadius = 10;
let eyeSpacing = 150;

let x = 50;
let y = 50;
let easingConstant = 0.05;

function setup() {
  createCanvas(800, 480);
}

function draw() {
	let percent = counter / totalFrames;
	
	//translate( width/2, height/2);

  render(percent)
	counter++;
}

function render(percent) {
	background(0);
	fill(255);
	eyes(x, y, eyeSpacing, eyeWidth, eyeHeight, eyeRadius);
	easing()
}

function eyes(x, y, hgap, w, h, r) {
	let halfGap = hgap / 2;
	let xleft = x - halfGap;
	let xright = x + halfGap;
	fill('#66ccff');
	rectMode(CENTER)
	rect(xleft, y, w, h, r);
	rect(xright, y, w, h, r);
}

function easing() {
	let targetX = mouseX;
	let dx = targetX - x;
  x += dx * easingConstant;
	
	let targetY = mouseY;
  let dy = targetY - y;
  y += dy * easingConstant;
}
