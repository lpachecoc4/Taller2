String L;
String N;
String S;
Graph graph;
Graph sol;
Graph newlevel;
PVector origin;
boolean P;
boolean Q;
boolean win;
int a;
int b;
int level;
PImage start;
PImage playl;
PImage createN;
Button create;
Button play;
Button retry;
Button back;
Button next;
Button finish;

ArrayList<Button> levels=new ArrayList<Button>();
//Button[] levels;

void setup() {
  size(800, 800);
  //levels=new Button[5];
  level=0;
  start=loadImage("Start.jpg");
  playl=loadImage("Play.jpg");
  createN=loadImage("CreateNodes.jpg");
  setDefault();
  next=new Button("Continuar", new PVector(550,700));
  finish=new Button("Terminar", new PVector(550,650));
  retry=new Button("Reintentar", new PVector(400,600));
  play=new Button("Jugar Niveles", new PVector(400,350));
  create=new Button("Crear Niveles", new PVector(400,550));
  back=new Button("Atrás",new PVector(100,50));
  for(int i=0; i<5; i++){
    String L=Integer.toString(i+1);
    //levels[i]=new Button("Nivel "+L,new PVector(600, 200+100*i));
    levels.add(new Button("Nivel "+L,new PVector(600, 200+100*i)));
    String S=L+"L";
    erase(S);
  }
}

void draw() {
  background(255);
  println(mouseX,mouseY);
  switch(level){
    case 0:
      image(start,0,0);
      play.display();
      create.display();
      if(play.click(mouseX,mouseY)){
        level=-1;
      }
      if(create.click(mouseX,mouseY)){
        Table r=loadTable("5N.csv","header");
        for(int i=r.getRowCount()-1; i>=0; i--){
          r.removeRow(i);
        }
        saveTable(r,"data/5N.csv");
        println(r.getRowCount());
        level=-2;
      }
    break;
    
    case -1:
      image(playl,0,0);
      back();
      for(int i=0; i<levels.size(); i++){
        levels.get(i).display();
        if(levels.get(i).click(mouseX,mouseY)){
          level=i+1;
        }
      }
      //for(int i=0; i<4; i++){
      //  levels[i].display();
      //  if(levels[i].click(mouseX,mouseY)){
      //    level=i+1;
      //  }
      //}
      
    break;
    
    case 1:
    if (!win) {
      setStrings(1);
      playing();
    } else {
      ganar();
    }
    break;
    
    case 2:
    if (!win) {
      setStrings(2);
      playing();
    } else {
      ganar();
    }    
    break;
    
    case 3:
    pushStyle();
    fill(200,130,200);
    stroke(200,130,200);
    triangle(375,50,425,10,425,90);
    popStyle();
    if (!win) {
      setStrings(3);
      playing();
    } else {
      ganar();
    }    
    break;
    
    case 4:
    if (!win) {
      setStrings(4);
      playing();
    } else {
      ganar();
    }
    break;
    
    case 5:
    if (!win) {
      setStrings(5);
      playing();
    } else {
      ganar();
    }
    break;
    
    case -2:
    image(createN,0,0);
    setStrings(5);
    back();
    continuar();
    Table t=loadTable(N+".csv","header");
    for(int i=0; i<t.getRowCount();i++){
      ellipse(t.getInt(i,0),t.getInt(i,1),70,70);
    }
    if(next.click(mouseX,mouseY)){
      level=-3;
      Table c=loadTable(S+".csv");
      Table b=loadTable(L+".csv");
      b.clearRows();
      c.clearRows();
     Table a=loadTable(N+".csv","header");
     for(int i=0; i<a.getRowCount(); i++){
       //println(a.getRowCount()); 
       c.addColumn();
       c.addRow();
       b.addColumn();
       b.addRow();
     }
     saveTable(b, "data/"+L+".csv");
     saveTable(c, "data/"+S+".csv");
     erase(L);
     erase(S);
  }
    //graph=new Graph(N,S);
    //for(int i=0; i<graph.nodes(graph);i++){
    //  graph.nodes[i].display();
    //}
    break;
    
    case -3:
    image(createN,0,0);
    setStrings(5);
    back();
    terminar();
    creating();
    
    
    break;  
  }   
}

void mouseClicked(){
  if(level==-2){
    Table table=loadTable(N+".csv", "header");
    int k=table.getRowCount();
    
    if(mouseX<700&&mouseX>200&&mouseY<530&&mouseY>50){
      //println(k);
      table.addRow();
      table.setInt(k,0,mouseX);
      table.setInt(k,1,mouseY);
    }
    saveTable(table,"data/"+N+".csv");
    
    
  }
  
}

void mousePressed() {
  if(level>0){  
    for (int i=0; i<graph.nodes(graph); i++) {
      if (sqrt(sq(mouseX-graph.nodes(graph, i).x) + sq(mouseY-graph.nodes(graph, i).y)) <= graph.nodes[i].size()/2&&!P&&Q) { 
        origin=graph.nodes(graph, i);
        P=true;
        a=i;
      } else if (!Q&&sqrt(sq(mouseX-graph.nodes(graph, i).x) + sq(mouseY-graph.nodes(graph, i).y)) <= graph.nodes[i].size()/2) {
        origin=graph.nodes(graph, b);
        P=true;
        a=b;
      }
    }
  }
  if(level==-3){
    for (int i=0; i<newlevel.nodes(newlevel); i++) {
      if (sqrt(sq(mouseX-newlevel.nodes(newlevel, i).x) + sq(mouseY-newlevel.nodes(newlevel, i).y)) <= newlevel.nodes[i].size()/2&&!P&&Q) { 
        origin=newlevel.nodes(newlevel, i);
        P=true;
        a=i;
      } else if (!Q&&sqrt(sq(mouseX-newlevel.nodes(newlevel, i).x) + sq(mouseY-newlevel.nodes(newlevel, i).y)) <= newlevel.nodes[i].size()/2) {
        origin=newlevel.nodes(newlevel, b);
        P=true;
        a=b;
      }
    }
  }
}

void mouseReleased() {
  if(level>0){
    for (int i=0; i<graph.nodes(graph); i++) {
      Table tabl=loadTable(L+".csv");
      Table table=loadTable(S+".csv");
      if ((sqrt(sq(mouseX-graph.nodes(graph, i).x) + sq(mouseY-graph.nodes(graph, i).y)) <= graph.nodes[i].size()/2)&&P&&tabl.getInt(a, i)!=0&&tabl.getInt(a, i)!=table.getInt(a, i)) { 
        P=false;
        Q=false;
        b=i;
        table.setInt(a, b, table.getInt(a, b)+1);
        table.setInt(b, a, table.getInt(b, a)+1);
        saveTable(table, "data/"+S+".csv");           
      }
    }
  }
  if(level==-3){
    for (int i=0; i<newlevel.nodes(newlevel); i++) {
      Table tabl=loadTable(L+".csv");
      Table table=loadTable(S+".csv");
      if ((sqrt(sq(mouseX-newlevel.nodes(newlevel, i).x) + sq(mouseY-newlevel.nodes(newlevel, i).y)) <= newlevel.nodes[i].size()/2)&&P) { 
        P=false;
        Q=false;
        b=i;
        table.setInt(a, b, table.getInt(a, b)+1);
        table.setInt(b, a, table.getInt(b, a)+1);
        saveTable(table, "data/"+L+".csv");
        saveTable(table, "data/"+S+".csv");
      }
    }
  }
}


boolean matches(Graph S, Graph T) {
  return S.lines(S)>=T.lines(T);
}

void ganar() {
  background(255);
  fill(0);
  textSize(100);
  textAlign(CENTER);
  text("¡¡¡GANASTE!!!", width/2, height/2);
  back();
}

void erase(String S) {
  String location="data/"+S+".csv";
  Table table=loadTable(S+".csv");
  for (int i=0; i<table.getRowCount(); i++) {
    for (int j=0; j<table.getColumnCount(); j++) {
      table.setInt(i, j, 0);
    }
  }
  saveTable(table, location);
}

void setDefault() {
  P=false;
  Q=true;
  win=false;
  
}

void playing(){
  sol=new Graph(N, S);
  graph=new Graph(N, L);
  graph.display(graph);
  sol.displaysol(sol);
  retry();
  back();
  if (P) {
     pushStyle();
     strokeWeight(20);
     stroke(0);
     line(origin.x, origin.y, mouseX, mouseY);
     popStyle();
   }
   win=matches(sol, graph);
}

void creating(){
  newlevel=new Graph(N,L);
  if (P) {
     pushStyle();
     strokeWeight(20);
     stroke(0);
     line(origin.x, origin.y, mouseX, mouseY);
     popStyle();
   }
   newlevel.displaysol(newlevel);
  
}

void retry(){
  retry.display();
  if (retry.click(mouseX,mouseY)){
    setDefault();
    erase(S);
  }  
}

void back(){
  back.display();
  if(back.click(mouseX,mouseY)&&level>0){
    level=-1;
    setDefault();
    eraseall();
  }
  if(back.click(mouseX,mouseY)&&level<0){
    level=0;
    eraseall();
    setDefault();
  }
  
}

void continuar(){
  next.display();
  if(next.click(mouseX,mouseY)){
    level=-3;
  }
}

void terminar(){
  finish.display();
  if(finish.click(mouseX,mouseY)){
    level=0;
    eraseall();
    setDefault();
  }
  
}

void eraseall(){
  for(int i=0; i<levels.size(); i++){
      String L=Integer.toString(i+1);
      String S=L+"L";
      erase(S);
    }
}

void setStrings(int i){
  String P=Integer.toString(i);
  L=P+"M";
  N=P+"N";
  S=P+"L";
}
//int contarNiveles(){
//  String S="M.csv";
//  int contador=1;
//  String L=Integer.toString(contador);
//  File f=new File("\bdata"+L+S);
//  while(f.exists()){
//    contador=contador+1;
//  }
//  println(contador);
//  return contador;
  
//}