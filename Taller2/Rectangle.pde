class Rectangle extends Node{
  Rectangle(PVector tempPos, float tempSizeN){
    setPosition(tempPos);
    setSize(tempSizeN);
  }
  
  @Override
  void display(){
    pushStyle();
    fill(0);
    stroke(0);
    rectMode(CENTER);
    rect(position.x, position.y, size, size);
    popStyle();
  }
}