abstract class Node{
  PVector position;
  float size;
  
  abstract void display();
  //abstract boolean pick(PVector P);

  void setSize(float s){
    size=s;
  }
  void setPosition(PVector pos){
    position=pos;
  }
  void setPosition(float x, float y){
    setPosition(new PVector(x,y));
  }
  
  PVector position(){
     return position;
   }
  float size(){
     return size;
   }
}