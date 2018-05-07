class Line{
  Node origin, end;
  color colorl;
  float sizel;
  
  
  Line(Node node1, Node node2, float tempsizel, color tempcolor){
    origin=node1;
    end=node2;
    sizel=tempsizel;
    colorl=color(200,130-120*(tempcolor-1),200);
  }
  
  void display(){
    pushStyle();
    strokeWeight(sizel);
    stroke(colorl);
    line(origin().position().x, origin().position().y, end().position().x, end().position().y);
    popStyle();
  }
  
  void displaysol(){
    pushStyle();
    strokeWeight(sizel);
    stroke(0);
    line(origin().position().x, origin().position().y, end().position().x, end().position().y);
    popStyle();
  }
  
  
  Node origin(){
    return origin;  
  }
  
  Node end(){
    return end;  
  }
  
  
}