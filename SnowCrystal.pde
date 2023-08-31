class SnowCrystal {

  /** /////////////////
  *** PARAMETERS
  **/ /////////////////
      Hexagon[][] hexagon;
  
         
      float [][] receptiveValues;
      float [][] receptiveValues2;
      
      float alpha;
      float beta;
      float gamma;
      
      float max_value = 1.6;
      float min_value = 0.01;
      int rand;
      int time_limit = 0;
      int time_limit2 = 0;
      IntList inter = new IntList ();
      float peso_larghezza;
      IntList voti = new IntList ();
      float votiBuffer = 0;
      int nBuffer = 1;
      float votoPar = 0;
      int n_v;
      int voto;
      boolean exist = false;
      boolean ft = false;
      int r = 6; 
      boolean grow;
      int count_melt = 0;
      boolean fast = false;
      int menu_width = int (60/rad);
      int plTot = 0;
      int margin = int(15/rad);
      boolean margin_reached = false;
      int endend = 0;
  
  /** /////////////////
  *** CONSTRUCTOR
  **/ /////////////////
      SnowCrystal(float alpha, float beta, float gamma, Hexagon[][] hexagon){
          this.alpha = alpha;
          this.beta = beta;
          this.gamma = gamma;
          this.hexagon = hexagon;
      }

  /** /////////////////
  *** INIT
  **/ /////////////////
  
  // INIT SNOW CRYSTAL
  
  void reset_crystal(){
    margin_reached = false;
    endend = 0;
    for (int i = 1; i < hexcountx-1; i ++ ) {
      for (int j = 2; j < hexcounty-2; j ++ ) {
        if(hexagon[i][j].value != beta){
          hexagon[i][j].reset();
          receptiveValues2[i][j] = beta;                           
        }
      }
    }
    int i = round(hexcountx/2 - menu_width);
    int j = round(hexcounty/2);
    if (j % 2 == 0) {
              hexagon[i][j-2].arm = 0;
              hexagon[i][j-2].arm_assigned = true;
              hexagon[i][j-1].arm = 1;
              hexagon[i][j-1].arm_assigned = true;
              hexagon[i][j+1].arm = 2;
              hexagon[i][j+1].arm_assigned = true;
              hexagon[i][j+2].arm = 3;
              hexagon[i][j+2].arm_assigned = true;
              hexagon[i-1][j+1].arm = 4;
              hexagon[i-1][j+1].arm_assigned = true;
              hexagon[i-1][j-1].arm = 5;
              hexagon[i-1][j-1].arm_assigned = true;
            } else{
              hexagon[i][j-2].arm = 0;
              hexagon[i][j-2].arm_assigned = true;
              hexagon[i+1][j-1].arm = 1;
              hexagon[i+1][j-1].arm_assigned = true;
              hexagon[i+1][j+1].arm = 2;
              hexagon[i+1][j+1].arm_assigned = true;
              hexagon[i][j+2].arm = 3;
              hexagon[i][j+2].arm_assigned = true;
              hexagon[i][j+1].arm = 4;
              hexagon[i][j+1].arm_assigned = true;
              hexagon[i][j-1].arm = 5;
              hexagon[i][j-1].arm_assigned = true;
            }
  }
  
  void initSnowCrystal(){
          hexcountx = round((width/(rad*3)));
          hexcounty = round((height/(rad*sqrt(3))*2));
          receptiveValues = new float[hexcountx][hexcounty];
          receptiveValues2 = new float[hexcountx][hexcounty];
      
          hexagon = new Hexagon [hexcountx][hexcounty];
          for (int i = 0; i < hexcountx; i++) {
            for (int j = 0; j < hexcounty; j++) {
              receptiveValues2[i][j] = beta;
              if ((j % 2) == 0) {
                hexagon[i][j] = new Hexagon((3 * rad * i), (.866 * rad * j), rad);
              } else {
                hexagon[i][j] = new Hexagon(3 * rad * (i + .5), .866 * rad * j, rad);
              }
            }
          }
          
          for (int i = 0; i < hexcountx; i++) {
            for (int j = 0; j < hexcounty; j++) {
              hexagon[i][j].value = beta;
              if (i == round(hexcountx/2 - menu_width) && j == round(hexcounty/2) ) {
                hexagon[i][j].value = 1;
                hexagon[i][j].receptive = true;
                hexagon[i][j].frozen = true;
                if (j % 2 == 0) {
                  hexagon[i][j-2].arm = 0;
                  hexagon[i][j-2].arm_assigned = true;
                  hexagon[i][j-1].arm = 1;
                  hexagon[i][j-1].arm_assigned = true;
                  hexagon[i][j+1].arm = 2;
                  hexagon[i][j+1].arm_assigned = true;
                  hexagon[i][j+2].arm = 3;
                  hexagon[i][j+2].arm_assigned = true;
                  hexagon[i-1][j+1].arm = 4;
                  hexagon[i-1][j+1].arm_assigned = true;
                  hexagon[i-1][j-1].arm = 5;
                  hexagon[i-1][j-1].arm_assigned = true;
                } else{
                  hexagon[i][j-2].arm = 0;
                  hexagon[i][j-2].arm_assigned = true;
                  hexagon[i+1][j-1].arm = 1;
                  hexagon[i+1][j-1].arm_assigned = true;
                  hexagon[i+1][j+1].arm = 2;
                  hexagon[i+1][j+1].arm_assigned = true;
                  hexagon[i][j+2].arm = 3;
                  hexagon[i][j+2].arm_assigned = true;
                  hexagon[i][j+1].arm = 4;
                  hexagon[i][j+1].arm_assigned = true;
                  hexagon[i][j-1].arm = 5;
                  hexagon[i][j-1].arm_assigned = true;
                }
              }
            }
          }
  }
  
  void averageVoteBuffer(){
      if(millis() > time_limit2 + 500 || frameCount == 1){
          time_limit2 = millis();
          voto =  round(votiBuffer/nBuffer);
          votiBuffer = votoPar;
          nBuffer = 1; 
      }
  }
  
  /** /////////////////
  *** SNOW CRYSTAL ASSIGNMENTS
  **/ /////////////////  
  
  // 1) ARM ASSIGNMENT
        int arm_assignment(int i, int j){
                    
            int[] arm_counter = {0, 0, 0, 0, 0, 0};
            int arm = 0;
            
              if(hexagon[i][j-2].arm < 6){arm_counter[hexagon[i][j-2].arm]++;}
              if(hexagon[i][j-1].arm < 6){arm_counter[hexagon[i][j-1].arm]++;}
              if(hexagon[i][j+1].arm < 6){arm_counter[hexagon[i][j+1].arm]++;}
              if(hexagon[i][j+2].arm < 6){arm_counter[hexagon[i][j+2].arm]++;}
              if (j % 2 == 0) {
                if(hexagon[i-1][j-1].arm < 6){arm_counter[hexagon[i-1][j-1].arm]++;}
                if(hexagon[i-1][j+1].arm < 6){arm_counter[hexagon[i-1][j+1].arm]++;}
              } else {
                if(hexagon[i+1][j-1].arm < 6){arm_counter[hexagon[i+1][j-1].arm]++;}
                if(hexagon[i+1][j+1].arm < 6){arm_counter[hexagon[i+1][j+1].arm]++;}
              }
               for (int k = 0; k < 6; k++){
                 if(arm_counter[k] > arm_counter[arm]){
                   arm = k;
                 }
               }
               boolean duplicate = false;
               for (int k = 0; k < 6 && !duplicate; k++){
                 if(k != arm && arm_counter[k] == arm_counter[arm]){
                   duplicate = true;
                 }
               }
               if (duplicate){
                 arm = 6;
               }
        return arm;                
        }
        
  // 2) RECEPTIVE ASSIGNMENT
        void receptive_assignment(boolean a, boolean b, boolean c, boolean d, boolean e, boolean f, boolean g, int i, int j){
                
                hexagon[i][j].receptive = a;
                hexagon[i][j-2].receptive = b;
                hexagon[i][j-1].receptive = c;
                hexagon[i][j+1].receptive = d;
                hexagon[i][j+2].receptive = e;
                if (j % 2 == 0) {
                  hexagon[i-1][j-1].receptive = f;
                  hexagon[i-1][j+1].receptive = g;
                } else {
                  hexagon[i+1][j-1].receptive = f;
                  hexagon[i+1][j+1].receptive = g;
                }
        }
  
  /** /////////////////
  *** SNOW CRYSTAL BEHAVIOUR
  **/ /////////////////
  
  // Transform the not-growing Crystal into ice (freezing action)
  void freeze(){ 
          for (int i = 1; i < hexcounty-2; i++){//controlla che i margini non siano stati raggiunti
            if (hexagon[margin][i].frozen){
              margin_reached = true;
            }
          }
          for (int i = 1; i < hexcountx-2; i++){
            if (hexagon[i][margin].frozen){
              margin_reached = true;
            }
          }
          for (int i = 1; i < hexcountx-2; i++){
            if (hexagon[i][hexcounty-margin].frozen){
              margin_reached = true;
            }
          }
          if(!margin_reached){  
            if(!this.grow){count_melt++;}                     
            exist = false;
            for (int i = 1; i < hexcountx-1; i ++ ) {
              for (int j = 2; j < hexcounty-2; j ++ ) {
                if (hexagon[i][j].frozen) {
                  exist = true;
                }
                if (hexagon[i][j].value > beta) {
                  hexagon[i][j].count++;
                }
                if (hexagon[i][j].value < 1) {
                  hexagon[i][j].frozen = false;
                }
                if (hexagon[i][j].value >= 1) {
                  hexagon[i][j].frozen = true;
                     if(!hexagon[i][j].arm_assigned){
                        hexagon[i][j].arm = arm_assignment(i,j);
                        hexagon[i][j].arm_assigned = true;
                  }
                  
                  
                  if (this.grow) {  // Detemina i parametri di crescita in funzione dell'armonia e della melodia
                    count_melt = 0;
                     if (fast){
                        hexagon[i][j].value = hexagon[i][j].value - min_dif/2;
                      }
                      if (voto < 32) {//scioglimento di un braccio
                        if (ft == false){r = (int)random(6);}
                        ft = true;
                        if(hexagon[i][j].arm == r){
                           hexagon[i][j].value = hexagon[i][j].value - min_dif/2;
                           receptive_assignment(true, true, true, true, true, true, true, i, j);
                        }                              
                      }
              
                      if (voto > 31 && voto < 51) {
                        ft = false;                            
                          receptive_assignment(false, false, false, false, false, false, false, i, j);
                          hexagon[i][j].value = hexagon[i][j].value + min_dif/2;
                      }
                      if (voto > 50 && voto < 70) {
                        ft = false;
                        hexagon[i][j].value = hexagon[i][j].value + min_dif/10;
                        receptive_assignment(true, true, true, true, true, true, true, i, j);
                      }
                      if (voto > 69) {
                        ft = false;                    
                        receptive_assignment(true, true, true, true, true, true, true, i, j);
                      }
                  
                  }else{
                    if(count_melt > 400){ //Inizia lo scioglimento in mancanza di input
                      receptive_assignment(false, false, false, false, false, false, false, i, j);
                      alpha = 0.04;                            
                    }
                  }
                }
              }
            }
          }else{//Quando si blocca
            stopGrowing.display();
            endend++;
          }
          

                  
        //Resetta la radice del cristallo se si scioglie
        int i = round(hexcountx/2 - menu_width);
        int j = round(hexcounty/2);
        if (exist == false) {
          hexagon[i][j].value = 1;
          hexagon[i][j].receptive = true;
          hexagon[i][j].frozen = true;
          hexagon[i][j].display();
        }
  }
  
  // Modifica la velocità di crescita in funzione della velocità della melodia
  void listenToTempo(){
    if(millis() > time_limit + 1000){
       time_limit = millis();
       if (melody_count < 2){
         alpha = 1.2;
         fast = false;
       }
       if (melody_count > 1 && melody_count < 4){
         alpha = 1.8;
         fast = false;
       }
       if (melody_count > 3 && melody_count < 9){
         alpha = 2.4;
         fast = false;
       }
       if (melody_count > 8){
         alpha = 2.4;
         fast = true;
       }
       melody_count = 0;
    }
  }
  
    // Assegna i voti agli intervalli
  void listenToHarmony(IntList notes) { 
              
    notes.sort();
    if(notes.size()>1){
    this.grow = true;
    votoPar = 0;
    n_v = 0;
    plTot = 0;
    //paTot = 0;
    for (int i = 0; i < notes.size(); i ++ ) { 
      for (int j = i+1; j < notes.size(); j ++ ) {
        int intervallo = (notes.get(j) - notes.get(i));
        int int_norm = intervallo % 12;
        n_v++;
        float voto_intervallo = 0;
        switch(int_norm){
          case 0:
            voto_intervallo = 1;//ottava
          break;
          case 7:
            voto_intervallo = 0.9;//quinta
          break;
          case 4:
            voto_intervallo = 0.8;//terza M
          break;
          case 5:
            voto_intervallo = 0.7;//quarta
          break;
          case 9:
            voto_intervallo = 0.7;//sesta M
          break;
          case 3:
            voto_intervallo = 0.5;//terza m
          break;
          case 8:
            voto_intervallo = 0.4;//sesta m
          break;
          case 11:
            voto_intervallo = 0.4;//settima M
          break;
          case 2:
            voto_intervallo = 0.3;//seconda M
          break;
          case 10:
            voto_intervallo = 0.3;//settima m
          break;
          case 6:
            voto_intervallo = 0.05;//tritono
          break;
          case 1:
            voto_intervallo = 0.05;//seconda m
          break;
        }
      
        if(intervallo < 13){   
          peso_larghezza = 10;
        }                    
        if(intervallo > 12 && intervallo < 25){
          peso_larghezza = 8;
        }
        if(intervallo > 24 && intervallo < 36){
          peso_larghezza = 3;
        }
        if(intervallo > 35){
          peso_larghezza = 1;
        }
        
        plTot += peso_larghezza;
        votoPar += (int)(voto_intervallo * peso_larghezza * 100); // voto intervallo * peso larghezza
  
      }    
    }
    if(n_v != 0){
      votoPar = votoPar/plTot;
      votiBuffer = votiBuffer + votoPar;
      nBuffer = nBuffer+1;
    }
    }else{
      this.grow = false;
    }       
  }
  
  
  /** /////////////////
  *** SETTERS
  **/ /////////////////
  
  // SET TO 0 RECEPTIVE CELLS
  void setReceptiveToZero(){
      for (int i = 0; i < hexcountx; i ++ ) {
        for (int j = 0; j < hexcounty; j ++ ) {
          if (hexagon[i][j].receptive) {
            receptiveValues[i][j] = 0;
          } else {
            receptiveValues[i][j] = hexagon[i][j].value; // It is important to save a copy of the cells
          }
        }
      }
  }
            
  
  ///// Set cell value of of neighbouring cells with a weighted sum
  void setNeighbouringCellsValue(){
      for (int i = 1; i < hexcountx-1; i ++ ) {
        for (int j = 2; j < hexcounty-2; j ++ ) {
          if (j % 2 == 0) {
            receptiveValues2[i][j] = receptiveValues[i][j] + alpha/12*(-6*receptiveValues[i][j]
              + receptiveValues[i][j-2] + receptiveValues[i][j-1] + receptiveValues[i][j+1]
              + receptiveValues[i][j+2] + receptiveValues[i-1][j-1] + receptiveValues[i-1][j+1]);
          } else {
            receptiveValues2[i][j] = receptiveValues[i][j] + alpha/12*(-6*receptiveValues[i][j]
              + receptiveValues[i][j-2] + receptiveValues[i][j-1] + receptiveValues[i][j+1]
              + receptiveValues[i][j+2] + receptiveValues[i+1][j-1] + receptiveValues[i+1][j+1]);
          }
        }
      }
  }
  
  //// Add gamma to receptive cells, transform non-receptive in values2 and add to previous receptive values
  void addGammaToReceptive(){
      for (int i = 0; i < hexcountx; i ++ ) {
          for (int j = 0; j < hexcounty; j ++ ) {
            if (hexagon[i][j].receptive) {
              hexagon[i][j].value += gamma;
              hexagon[i][j].value += receptiveValues2[i][j];
            } else {
              hexagon[i][j].value = receptiveValues2[i][j];
            }
          }
      }
  }
  
  // Set Receptive cells to false if no adjacent cells are frozen (gas)
  void setReceptiveToFalse(){
      for (int i = 1; i < hexcountx-1; i ++ ) {
        for (int j = 2; j < hexcounty-2; j ++ ) {
          if (!hexagon[i][j].frozen) {
            if (!hexagon[i][j-2].frozen && !hexagon[i][j-1].frozen && !hexagon[i][j+1].frozen && !hexagon[i][j+2].frozen) {
              if (j % 2 == 0) {
                if (!hexagon[i-1][j-1].frozen && !hexagon[i-1][j+1].frozen) {
                  hexagon[i][j].receptive = false;
                }
              } else {
                if (!hexagon[i+1][j-1].frozen && !hexagon[i+1][j+1].frozen) {
                  hexagon[i][j].receptive = false;
                }
              }
            }
          }
          if (hexagon[i][j].value > beta && hexagon[i][j].count < 500 && endend < 800) {// Colora la cella se il valore è cambiato recentemente
              hexagon[i][j].display();
          }
          if (hexagon[i][j].value > max_value + beta) {
            hexagon[i][j].value = max_value + beta;
          }
          if (hexagon[i][j].value < min_value && hexagon[i][j].value != beta){hexagon[i][j].value = min_value;}
        }
      }
  }
}
