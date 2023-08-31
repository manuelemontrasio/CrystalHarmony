class Hexagon {
  float x, y, radi;
  float angle = 360.0 / 6;
  int count = 0;
  boolean frozen = false;
  boolean receptive = false;
  float displayed_value = 0;
  float value=0;
  float c;
  int [] Color;
  int arm = 6;
  boolean arm_assigned = false;
  float gc1 = 1;
  float gc2 = 1;
  float gc3 = 1;
  float gc4 = 1;
  
  Hexagon(float cx, float cy, float r)
  {
    x=cx;
    y=cy;
    radi=r;
  }

  void reset(){
    value = beta;
    fill(0,0,0);
     beginShape();     
      for (int i = 0; i < 6; i++){
        vertex(x + radi * cos(radians(angle * i)), 
        y + radi * sin(radians(angle * i)));
      }
       receptive = false;
       frozen = false;
       displayed_value = 0;
       count = 0;
       endShape(CLOSE);    
  }

  void display() {
    if(abs(value - displayed_value) >= min_dif){// Display the cell only if the value has changed significantly
      c = value - beta;
      gc1 = -(100 - synthKnob1.getKnobValue())*2; //red
      gc2 = -(100 - synthKnob2.getKnobValue()); //green
      gc3 = -(100 - synthKnob3.getKnobValue())/2.3; //blue
      gc4 = -(100 - synthKnob4.getKnobValue())/2; //opacity
      Color = RGBA_to_RGB(c*120 + gc1, c*230 + gc2, 255 + gc3, c*170 + gc4, 0, 0, 0);
      fill(Color[0], Color[1], Color[2]);
      beginShape();
      for (int i = 0; i < 6; i++){
        vertex(x + radi * cos(radians(angle * i)), 
        y + radi * sin(radians(angle * i)));
      }
      endShape(CLOSE);
      displayed_value = value;
     }
   } 
  
  int[] RGBA_to_RGB(float R, float G, float B, float A, float Rb, float Gb, float Bb){
    int [] Color = new int[3];
    float alpha = A/255;
    Color[0] = round((alpha * (R/255) + (alpha * (Rb/255))) * 255);
    Color[1] = round((alpha * (G/255) + (alpha * (Gb/255))) * 255);
    Color[2] = round((alpha * (B/255) + (alpha * (Bb/ 255))) * 255);
  
  return Color;
  }
  
  
}
