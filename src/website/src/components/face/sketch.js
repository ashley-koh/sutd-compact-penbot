export default function sketch(p5, props) {

    let totalFrames = 60;
    let counter = 0;

    let eyeWidth = 150;
    let eyeHeight = 150;
    let eyeRadius = 30;
    let eyeSpacing = 200;

    let x, y, minX, minY, maxX, maxY;
    let easingConst = 0.02;

    let currentEmotion;
    let randomEmotion = false;
    let blinking = false;

    p5.setup = function() {
        p5.createCanvas(800, 480);
        x = p5.width/2;
        y = p5.height/2;
        maxX = p5.width - eyeWidth/2 - eyeSpacing/2 - 50;
        maxY = p5.height - eyeHeight/2 - 50;
        minX = eyeWidth/2 + eyeSpacing/2 + 50;
        minY = eyeHeight/2 + 50;
        
    }
    
    p5.myCustomRedrawAccordingToNewPropsHandler = function(props) {
        console.log(props)
        if (props.emotion === "random")
            randomEmotion = true;
        else
            currentEmotion = props.emotion;
    }
    
    p5.draw = function(props) {
        counter++;
        if (counter > totalFrames) {
            emotion();
            if (p5.random(0, 100) >= 80)
                blinking = true;
            else
                blinking = false;
            counter = 0;
        }
        render();
        
    }
    
    function render(percent) {
        p5.background(0);
        // normalEyes(x, y, eyeSpacing, eyeWidth, eyeHeight, eyeRadius);
        // happyEyes(x, y, eyeSpacing, eyeWidth, eyeHeight);
        sadEyes(x, y, eyeSpacing, eyeWidth, eyeHeight, eyeRadius);
        easing();

        if (blinking)
            blink();
    }

    function emotion() {
        if (randomEmotion) {
            let random = p5.random(0, 100);
            if (random <= 10)
                currentEmotion = "happy"
            if (random > 25 && random <= 35)
                currentEmotion = "sad"
            if (random > 50 && random <= 60)
                currentEmotion = "bored"
            if (random > 75 && random <= 85)
                currentEmotion = "normal"
            console.log(currentEmotion)
        }
    }

    //Normal Eyes
    function normalEyes(x, y, hgap, w, h, r) {
        let halfGap = hgap/2;
        let xleft = x - halfGap;
        let xright = x + halfGap;
        p5.fill("#66ccff")
        p5.rectMode(p5.CENTER)
        p5.rect(xleft, y, w, h, r);
        p5.rect(xright, y, w, h, r);
        // console.log(`x: ${x}, y: ${y}, w: ${w}`)
    }

    //Happy Eyes
    function happyEyes(x, y, hgap, w, h) {
        let halfGap = hgap/2;
        let xleft = x - halfGap;
        let xright = x + halfGap;
        p5.fill("#66ccff")
        // p5.rect(xleft, y, w, h, r);
        // p5.rect(xright, y, w, h, r);
        
        p5.ellipse(xleft, y, w, h);
        p5.ellipse(xright, y, w, h);
        
        p5.fill(0);
        p5.ellipse(xleft, y, w - 50, h - 50);
        p5.ellipse(xright, y, w - 50, h - 50);
        p5.rectMode(p5.CENTER)
        p5.rect(xleft, y + h/2, w, h)
        p5.rect(xright, y + h/2, w, h)
    }

    //Sad Eyes
    function sadEyes(x, y, hgap, w, h, r) {
        let halfGap = hgap/2;
        let xleft = x - halfGap;
        let xright = x + halfGap;
        p5.fill("#66ccff")
        p5.rectMode(p5.CENTER)
        p5.rect(xleft, y, w, h, r);
        p5.rect(xright, y, w, h, r);
        // console.log(`x: ${x}, y: ${y}, w: ${w}`)
    }

    function easing() {
        // let targetX = p5.mouseX;
        // let targetY = p5.mouseY;
        let targetX = p5.width/2;
        let targetY = p5.height/2;

        let dx = targetX - x;
        x += dx * easingConst;

        let dy = targetY - y;
        y += dy * easingConst;

        if (x > maxX)
            x = maxX;
        if (x < minX)
            x = minX;
        if (y > maxY)
            y = maxY;
        if (y < minY)
            y = minY;
    }

    function blink() {
        if (counter < 5)
            eyeHeight -= 20;
        else if (counter < 10)
            eyeHeight += 20;
    }
}
