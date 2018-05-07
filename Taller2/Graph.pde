class Graph{
  Node[] nodes;
  Line[] lines;
  
  Graph(String N, String L){
    setGraph(N,L);
  }
  
  void setGraph(String N, String L){
    Table tableN=loadTable(N+".csv", "header");
    Table tableL=loadTable(L+".csv");
    nodes=new Node[tableN.getRowCount()];
    for (int i=0; i<tableN.getRowCount(); i++){
      if(i<tableN.getRowCount()/2){ 
        nodes[i]=new Circle(new PVector(tableN.getInt(i,0), tableN.getInt(i,1)), 70);
      }else{
        nodes[i]=new Rectangle(new PVector(tableN.getInt(i,0), tableN.getInt(i,1)), 70);
      }    
    }
    
   lines=new Line[count(tableL)];
   int k=0;
    for(int i=0; i<tableL.getRowCount(); i++){
      for(int j=0; j<tableL.getColumnCount(); j++){
        if(tableL.getInt(i,j)!=0){
          lines[k]=new Line(nodes[i], nodes[j], 20, tableL.getInt(i,j));
          k++;
        }        
      }      
    }
  }
  
  void display(Graph S){
    if(lines(S)!=0){
      for (int i=0; i<S.lines.length; i++){
          lines[i].display();
          //println(count(tableL));
       }
    }
     for (int i=0; i<S.nodes.length; i++){
      nodes[i].display();
     }
  }
  
  void displaysol(Graph S){
    if(lines(S)!=0){
      for (int i=0; i<S.lines.length; i++){
          lines[i].displaysol();
          //println(count(tableL));
       }
    }
     for (int i=0; i<S.nodes.length; i++){
      nodes[i].display();
     }
  }
  
  int count(Table table){
    int contador=0;
    for(int i=0; i<table.getRowCount();i++){
       for(int j=0; j<table.getColumnCount(); j++){
         if (table.getInt(i,j)!=0){
           contador++;  
         }
       } 
      }
    return contador;
  }
    
  int lines(Graph S){
    return S.lines.length;
  }
  
  int nodes(Graph S){
    return S.nodes.length;
  }
  
  PVector nodes(Graph S, int i){
    return S.nodes[i].position();
  }
  
  
  
  
  
  
}