import processing.sound.*;

PFont cookieMonster;
PFont dkCrayonCrumble;
PFont neoteric;
PFont primetime;
PFont trench100;

SoundFile title_wav;
String titleName = "sounds/title.wav";

SoundFile hover_wav;
boolean hover_once = true;
String selectName = "sounds/ChipSelect.wav";

SoundFile click_wav;
String clickName = "sounds/NewGame.wav";

SoundFile diff_wav;
String diffName = "sounds/ChangeDiff.wav";

int tmp_mode = 0;
int mode = 0;
boolean changeMode = false;
int changeMode_trans = 0;

int diff = 0;
int diff_trans = 0;

boolean tog_inc_diff;
boolean tog_dec_diff;

ArrayList<My_button> buttons = new ArrayList<My_button>();

final String BENCHMARKS = "BENCHMARKS";

final int[] DIFF_Y = new int[]{189,255,177};
final int[] DIFF_O = new int[]{255,255,196};
final int[] DIFF_R = new int[]{255,118,118};

float RB_X_0;
float RB_Y_0;
final int RB_W_0 = 447;
final int RB_H_0 = 78;

float FB_X_0;
float FB_Y_0;
final int FB_W_0 = 447;
final int FB_H_0 = 78;

float PB_X_0;
float PB_Y_0;
final int PB_W_0 = 447;
final int PB_H_0 = 78;

float EXIT_X_0;
float EXIT_Y_0;
final int EXIT_W_0 = 447;
final int EXIT_H_0 = 39;

PImage bgImage;
PImage exclamation;

void setup() {
  frameRate(100);
  fullScreen();
  RB_X_0 = displayWidth/2;
  RB_Y_0 = displayHeight/2-90;
  FB_X_0 = displayWidth/2;
  FB_Y_0 = displayHeight/2;
  PB_X_0 = displayWidth/2;
  PB_Y_0 = displayHeight/2+90;
  EXIT_X_0 = displayWidth/2;
  EXIT_Y_0 = displayHeight/2+162;
  fill(DIFF_Y[0],DIFF_Y[1],DIFF_Y[2]);
  rect(0,0,width,height);
  cookieMonster = createFont("fonts/CookieMonster.ttf",69);
  dkCrayonCrumble = createFont("fonts/DKCrayonCrumble.ttf",69);
  neoteric = createFont("fonts/NEOTERIC.ttf",69);
  primetime = createFont("fonts/PRIMETIME.ttf",69);
  trench100 = createFont("fonts/trench100.ttf",69);
  title_wav = new SoundFile(this, titleName);
  hover_wav = new SoundFile(this, selectName);
  click_wav = new SoundFile(this, clickName);
  diff_wav = new SoundFile(this, diffName);
  buttons.add(new My_button("TEST REACTION",RB_X_0,RB_Y_0,RB_W_0,RB_H_0,255,255,255,1));
  buttons.add(new My_button("TEST CONTROL",FB_X_0,FB_Y_0,FB_W_0,FB_H_0,255,255,255,2));
  buttons.add(new My_button("TEST MEMORY",PB_X_0,PB_Y_0,PB_W_0,PB_H_0,255,255,255,3));
  buttons.add(new My_button("EXIT", EXIT_X_0, EXIT_Y_0, EXIT_W_0, EXIT_H_0, 255,255,255,-2));
  title_wav.play(1,0.2);
}

void draw() {
  if (mode == 0) {
    changeDiff();
    displayMenu();
    checkHoverMode0();
  } else if (mode == 1) {
    setupReact();
    displayReact();
  } else if (mode == 2) {
  } else if (mode == 3) {
  } else if (mode == -2) {
    exit();
  }
  changeMode(tmp_mode);

}

void checkClickMode0() {
  int c;
  for (int i = 0; i < 4; i++) {
    c = buttons.get(i).checkMouseClick(mouseX,mouseY);  
    if (c > 0) {
      click_wav.play();
      tmp_mode = c;
      changeMode = true;
      title_wav.stop();
    } if (c == -2) {
      tmp_mode = -2;
      changeMode = true;
    }
  }
}

void changeDiff(){
  if (tog_inc_diff) {
    if (diff == 1) {
      if (diff_trans != 14) {
        fill(t(DIFF_Y[0],DIFF_O[0],diff_trans,15), t(DIFF_Y[1],DIFF_O[1],diff_trans,15), t(DIFF_Y[2],DIFF_O[2],diff_trans,15));
        rect(width/2,height/2,width,height);
        diff_trans++;
      } else {
        fill(DIFF_O[0],DIFF_O[1],DIFF_O[2]);
        rect(width/2,height/2,width,height);
        diff_trans = 0;
        tog_inc_diff = false;
        diff_wav.play();
      }
    }
    if (diff == 2) {
      if (diff_trans != 14) {
        fill(t(DIFF_O[0],DIFF_R[0],diff_trans,15), t(DIFF_O[1],DIFF_R[1],diff_trans,15), t(DIFF_O[2],DIFF_R[2],diff_trans,15));
        rect(width/2,height/2,width,height);
        diff_trans++;
      } else {
        fill(DIFF_R[0],DIFF_R[1],DIFF_R[2]);
        rect(width/2,height/2,width,height);
        diff_trans = 0;
        tog_inc_diff = false;
        diff_wav.play();
      }
    }
  }
  else if (tog_dec_diff) {
    if (diff == 1) {
      if (diff_trans != 14) {
        fill(t(DIFF_R[0],DIFF_O[0],diff_trans,15), t(DIFF_R[1],DIFF_O[1],diff_trans,15), t(DIFF_R[2],DIFF_O[2],diff_trans,15));
        rect(width/2,height/2,width,height);
        diff_trans++;
      } else {
        fill(DIFF_O[0],DIFF_O[1],DIFF_O[2]);
        rect(width/2,height/2,width,height);
        diff_trans = 0;
        tog_dec_diff = false;
        diff_wav.play();
      }
    }
    if (diff == 0) {
      if (diff_trans != 14) {
        fill(t(DIFF_O[0],DIFF_Y[0],diff_trans,15), t(DIFF_O[1],DIFF_Y[1],diff_trans,15), t(DIFF_O[2],DIFF_Y[2],diff_trans,15));
        rect(width/2,height/2,width,height);
        diff_trans++;
      } else {
        fill(DIFF_Y[0],DIFF_Y[1],DIFF_Y[2]);
        rect(width/2,height/2,width,height);
        diff_trans = 0;
        tog_dec_diff = false;
        diff_wav.play();
      }
    }
  } else {
    if (diff == 0) fill(DIFF_Y[0],DIFF_Y[1],DIFF_Y[2]); 
    if (diff == 1) fill(DIFF_O[0],DIFF_O[1],DIFF_O[2]);
    if (diff == 2) fill(DIFF_R[0],DIFF_R[1],DIFF_R[2]);
  }
}

void checkHoverMode0() {
  boolean check = true;
  for (int i = 0; i < 4; i++) {
    
    if (buttons.get(i).checkMouseHover(mouseX,mouseY) > 0){
      if (!hover_once) {
        hover_wav.play();
      }
      check = false;
    }
    
  }
  if (!check) hover_once = true;
  else hover_once = false;
}

int t(int t1, int t2, int current, int total){
  return t1 + current*((t2-t1)/total);
}

void changeMode(int c) {
  if (changeMode) {
    if (changeMode_trans <= 60) {
      fill(0,changeMode_trans*5);
      rect(width/2,height/2,width, height);
    } 
    if (changeMode_trans == 60) {
      mode = c;
    }
    if (changeMode_trans > 60 && changeMode_trans < 120) {
      fill(0,255+5*(60-changeMode_trans));
      rect(width/2,height/2,width, height);
    }
    if (changeMode_trans == 120) {
      changeMode = false;
      changeMode_trans = 0;
    }
    changeMode_trans++;
  }
}

void displayMenu(){
  fill(0);
  textFont(neoteric);
  textAlign(CENTER,CENTER);
  textSize(69);
  text(BENCHMARKS, displayWidth/2, displayHeight/2 - 180);
  buttons.get(0).display();
  buttons.get(1).display();
  buttons.get(2).display();
  buttons.get(3).display();
}  

void setupReact(){
  if (diff == 0) { bgImage = loadImage("sprites/react_background_easy.png"); exclamation = loadImage("sprites/big_react_1.png"); }
  if (diff == 1) { bgImage = loadImage("sprites/react_background_medium.png"); exclamation = loadImage("sprites/big_react_2.png"); }
  if (diff == 2) { bgImage = loadImage("sprites/react_background_hard.png"); exclamation = loadImage("sprites/big_react_3.png"); }
  
  
}

void mousePressed() {
  if (mode == 1) {
    displayReact();
  }  
  if (mode == 0) {
    checkClickMode0();
  }
}

void displayReact(){
  imageMode(CENTER);
  image(bgImage,width/2,height/2,(1024.0/888.0)*height,height);
}

void mouseReleased(MouseEvent event) {
  for (int i = 0; i < 4; i++) {
    buttons.get(i).checkMouseClick(mouseX,mouseY);  
  }
}

void mouseWheel(MouseEvent event) {
  if (mode == 0 && !(tog_inc_diff || tog_dec_diff)){
    if (event.getCount() < 0 && diff < 2){
      diff++;
      tog_inc_diff = true;
    } 
    if (event.getCount() > 0 && diff > 0){
      diff--; 
      tog_dec_diff = true;
    }
  }
}
