import processing.sound.*;

SoundFile hover_wav;
boolean hover_once = true;
String selectName = "sounds/ChipSelect.wav";

SoundFile click_wav;
String clickName = "sounds/NewGame.wav";

SoundFile diff_wav;
String diffName = "sounds/ChangeDiff.wav";

int mode = 0;
int mode_trans = 0;
int diff = 0;
int diff_trans = 0;

boolean tog_inc_diff;
boolean tog_dec_diff;

ArrayList<My_button> buttons = new ArrayList<My_button>();

final String BENCHMARKS = "BENCHMARKS";

final int[] DIFF_Y = new int[]{255,255,224};
final int[] DIFF_O = new int[]{255,130,122};
final int[] DIFF_R = new int[]{220,20,30};

final float RB_X_0 = 240; 
final float RB_Y_0 = 125; 
final int RB_W_0 = 447;
final int RB_H_0 = 78;

final float FB_X_0 = 240; 
final float FB_Y_0 = 215; 
final int FB_W_0 = 447;
final int FB_H_0 = 78;

final float PB_X_0 = 240; 
final float PB_Y_0 = 305; 
final int PB_W_0 = 447;
final int PB_H_0 = 78;



void setup() {
  size(480,360);
  background(DIFF_Y[0],DIFF_Y[1],DIFF_Y[2]);
  hover_wav = new SoundFile(this, selectName);
  click_wav = new SoundFile(this, clickName);
  
  buttons.add(new My_button("Test Reaction",RB_X_0,RB_Y_0,RB_W_0,RB_H_0,255,255,255,1));
  buttons.add(new My_button("Test Control",FB_X_0,FB_Y_0,FB_W_0,FB_H_0,255,255,255,2));
  buttons.add(new My_button("Test Memory",PB_X_0,PB_Y_0,PB_W_0,PB_H_0,255,255,255,3));
}

void draw() {
  if (mode == 0) {
    changeDiff();
    displayMenu();
    checkHover();
  } else if (mode == 1) {
  } else if (mode == 2) {
  } else if (mode == 3) {
  } 
}

void checkClick() {
  int c;
  for (int i = 0; i < 3; i++) {
    c = buttons.get(i).checkMouseClick(mouseX,mouseY);  
    if (c > 0) {
      diff_wav.play();
      mode = c;  
    }
  }
}

void changeDiff(){
  if (tog_inc_diff) {
    if (diff == 1) {
      if (diff_trans != 14) {
        background(t(DIFF_Y[0],DIFF_O[0],diff_trans,15), t(DIFF_Y[1],DIFF_O[1],diff_trans,15), t(DIFF_Y[2],DIFF_O[2],diff_trans,15));
        diff_trans++;
      } else {
        background(DIFF_O[0],DIFF_O[1],DIFF_O[2]);
        diff_trans = 0;
        tog_inc_diff = false;
      }
    }
    if (diff == 2) {
      if (diff_trans != 14) {
        background(t(DIFF_O[0],DIFF_R[0],diff_trans,15), t(DIFF_O[1],DIFF_R[1],diff_trans,15), t(DIFF_O[2],DIFF_R[2],diff_trans,15));
        diff_trans++;
      } else {
        background(DIFF_R[0],DIFF_R[1],DIFF_R[2]);
        diff_trans = 0;
        tog_inc_diff = false;
      }
    }
  }
  if (tog_dec_diff) {
    if (diff == 1) {
      if (diff_trans != 14) {
        background(t(DIFF_R[0],DIFF_O[0],diff_trans,15), t(DIFF_R[1],DIFF_O[1],diff_trans,15), t(DIFF_R[2],DIFF_O[2],diff_trans,15));
        diff_trans++;
      } else {
        background(DIFF_O[0],DIFF_O[1],DIFF_O[2]);
        diff_trans = 0;
        tog_dec_diff = false;
      }
    }
    if (diff == 0) {
      if (diff_trans != 14) {
        background(t(DIFF_O[0],DIFF_Y[0],diff_trans,15), t(DIFF_O[1],DIFF_Y[1],diff_trans,15), t(DIFF_O[2],DIFF_Y[2],diff_trans,15));
        diff_trans++;
      } else {
        background(DIFF_Y[0],DIFF_Y[1],DIFF_Y[2]);
        diff_trans = 0;
        tog_dec_diff = false;
      }
    }
  }
}

void checkHover() {
  boolean check = true;
  for (int i = 0; i < 3; i++) {
    
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

void changeMode() {
  
}

void displayMenu(){
  fill(0);
  textAlign(CENTER,CENTER);
  textSize(69);
  text(BENCHMARKS, 240, 35);
  buttons.get(0).display();
  buttons.get(1).display();
  buttons.get(2).display();
}  

void mousePressed() {
  if (mode == 1) {
  }  
  if (mode == 0) {
    checkClick();
  }
}

void mouseReleased(MouseEvent event) {
  for (int i = 0; i < 3; i++) {
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
