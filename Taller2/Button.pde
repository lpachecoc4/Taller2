class Button{
  PVector position;
  String text;
  
  Button(String tempText, PVector tempPos){
    text=tempText;
    position=tempPos;
  }
  
  void display(){
    textAlign(CENTER,CENTER);
    textSize(35);
    rectMode(RADIUS);
    if(pick(mouseX,mouseY)){
      fill(0);
      stroke(255);
      rect(position.x, position.y, 12*text.length(), 24);
      fill(255);
      text(text, position.x, position.y);
    }else{
      fill(255);
      stroke(0);
      rect(position.x, position.y, 12*text.length(), 24);
      fill(0);
      text(text, position.x, position.y);
    }
  }
  
  boolean pick(int x, int y){
    return abs(x-position.x)<=12*text.length()&&abs(y-position.y)<=24;
  }
  
  boolean click(int x, int y){
    return pick(x,y)&&mousePressed;
  }
  
}