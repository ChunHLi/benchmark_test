public class My_button implements Collidable {
  
  String t;
  float x;
  float y;
  int w;
  int h;
  int r;
  int g;
  int b;
  int tR = 0;
  int tG = 0;
  int tB = 0;
  int mode;
  
  boolean hover;
  boolean click;
  
  public My_button(String t, float x, float y, int w, int h, int r, int g, int b, int mode) {
    this.t = t;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.r = r;
    this.g = g;
    this.b = b;
    this.hover = false;
    this.click = false;
    this.mode = mode;
  }
  
  void display(){
    textSize(60);
    strokeWeight(4);
    if (click){
      fill(255,255,255);
      stroke(255);
      rectMode(CENTER);
      rect(x,y,w,h);
      fill(255);
      textAlign(CENTER,CENTER);
      text(t,x,y);
    } else if (hover) {  
      fill(0,0,0);
      stroke(0);
      rectMode(CENTER);
      rect(x,y,w,h);
      fill(255);
      textAlign(CENTER,CENTER);
      text(t,x,y);
    } else {
      fill(r,g,b);
      stroke(0);
      rectMode(CENTER);
      rect(x,y,w,h);
      fill(0);
      textAlign(CENTER,CENTER);
      text(t,x,y);
    }
  }
  
  boolean checkCollision(float mX, float mY){
    return (mX > x-(w/2) && mX < x+(w/2) && mY > y-(h/2) && mY < y+(h/2));
  }
  
  int checkMouseHover(float mX, float mY){
    hover = false;
    if (checkCollision(mX,mY)){
      hover = true;
      return 1;
    }
    if (hover) return 1;
    else return -1;
  }
  
  int checkMouseClick(float mX, float mY){
    click = false;
    if (checkCollision(mX,mY) && mousePressed){
      click = true;
    }
    if (click) return this.mode;
    else return -1;
  }
}
