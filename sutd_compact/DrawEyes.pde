public class DrawEyes {
  int w, h, r;
  
  public DrawEyes( int w, int h, int r) {
     this.w = w; // width
     this.h = h; // height
     this.r = r; // corner radius
  }
  
  public void neutral(int red, int green, int blue) {
     int halfGap = eyeSpacing/2;
     float xleft = x - halfGap;
     float xright = x + halfGap;
     fill(red, green, blue);
     rectMode(CENTER);
     rect(xleft, y, w, eyeHeight, r);
     rect(xright, y, w, eyeHeight, r);
  }
  
  public void happy(int red, int green, int blue) {
     int halfGap = eyeSpacing/2;
     float xleft = x - halfGap;
     float xright = x + halfGap;
     fill(red, green, blue);
     ellipse(xleft, y, w+100, eyeHeight);
     ellipse(xright, y, w+100, eyeHeight);
     
     fill(0);
     ellipse(xleft, y, w+50, eyeHeight-50);
     ellipse(xright, y, w+50, eyeHeight-50);
     rectMode(CENTER);
     rect(xleft, y+h/2, w, eyeHeight);
     rect(xright, y+h/2, w, eyeHeight);
  }
  
  public void sad(int red, int green, int blue) {
     int halfGap = (eyeSpacing - 100)/2;
     float xleft = x - halfGap;
     float xright = x + halfGap;
     float dy = -(y/480 * 80);
     float halfHeight = eyeHeight/4;
     
     fill(red, green, blue);
     beginShape();
     vertex(xleft-w, y-halfHeight);
     curveVertex(xleft, y-halfHeight-20);
     curveVertex(xleft, y+halfHeight+40*h/150+dy);
     curveVertex(xleft-w+10, y+halfHeight+40*h/150+dy);
     endShape(CLOSE);
     
     beginShape();
     vertex(xright+w, y-halfHeight);
     curveVertex(xright, y-halfHeight-20);
     curveVertex(xright, y+halfHeight+40*h/150+dy);
     curveVertex(xright+w-10, y+halfHeight+40*h/150+dy);
     endShape(CLOSE);
  }
  
  public void blink() {
     //if (currentEmotion != "sleepy") {
       if (counter < 5)
         eyeHeight -= 20;
       else if (counter < 10)
         eyeHeight += 20;
  }
  
  public void targetPos(float targetX, float targetY) {
     float dx = targetX - x;
     x += dx * easingConst;
     
     float dy = targetY - y;
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
  
  public void randomPos() {
    if (counter == totalFrames && random(0, 100) >= 75) {
      targetX = random(0, width);
      targetY = random(0, height);
    }
  }
}
