class ImageGui {
    
    /** /////////////////
    *** PARAMETERS
    **/ /////////////////
    PImage img;
    PImage imgChild;
    float posX, posY;
    
    /** /////////////////
    *** CONSTRUCTOR
    **/ /////////////////
    ImageGui(String imgName, float posX, float posY) {
      this.posX = posX;
      this.posY = posY;
      img = loadImage("Images/"+imgName+".png");
    }
    
    ImageGui(String imgName, String imgNameChild, float posX, float posY) {
      this.posX = posX;
      this.posY = posY;
      img = loadImage("Images/"+imgName+".png");
      imgChild = loadImage("Images/"+imgNameChild+".png");
    }
    
    /** /////////////////
    *** DISPLAY
    **/ /////////////////
    
    void display() {
      image(img, posX, posY);
    }
    
    // The method displayExport() displays the button export and activates its functionalities
    void displayExport() {
      if(mouseX > this.posX && mouseX < this.posX + img.width
         && mouseY > this.posY && mouseY < this.posY + img.height){
             this.display();  
      } else {
             image(imgChild, posX, posY);
      } 
    }
    
    // The method displayReset() displays the button export and activates its functionalities
    void displayReset() {
      if(mouseX > this.posX && mouseX < this.posX + img.width
         && mouseY > this.posY && mouseY < this.posY + img.height){
             this.display();  
      } else {
             image(imgChild, posX, posY);
      } 
    }
     
    /** /////////////////
    *** GETTERS
    **/ /////////////////
    float getX(){
      return this.posX;
    }
    
    float getY(){
      return this.posY;
    }
    
    float getWidth(){
      return img.width;
    }
    
    float getHeight(){
      return img.height;
    }
    
}
