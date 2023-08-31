class ToggleButton {

  /** /////////////////
  *** PARAMETERS
  **/ /////////////////
  PShape toggleButtonON = loadShape("SVGs/ButtonON.svg");
  PShape toggleButtonOFF = loadShape("SVGs/ButtonOFF.svg");
  boolean isOn;
  
  float posX, posY;
  float toggleButtonSize = 17;
  float toggleButtonSizeRatio = 1.7;
  ObjGui knob;
  
  float temporaryVolume;
  
  /** /////////////////
  *** CONSTRUCTOR
  **/ /////////////////
  ToggleButton(ObjGui knob, float posX, float posY){
    this.knob = knob;
    this.posX = posX;
    this.posY = posY;
    isOn = true;
  }

  /** /////////////////
  *** INIT
  **/ /////////////////
  void initVisibility(){
    shape(toggleButtonOFF, posX, posY, toggleButtonSize, toggleButtonSizeRatio*toggleButtonSize);
    shape(toggleButtonON, posX, posY, toggleButtonSize, toggleButtonSizeRatio*toggleButtonSize);

    toggleButtonON.setVisible(this.getStatus());
    toggleButtonOFF.setVisible(!this.getStatus());
  }
  
  /** /////////////////
  *** GETTERS
  **/ /////////////////
  
  float getPosX(){
    return posX;
  }

  float getPosY(){
    return posY;
  }
  
  boolean getStatus(){
    return isOn;
  }
  
  float getToggleButtonSize(){
    return toggleButtonSize;
  }
  
  float getToggleButtonSizeRatio(){
    return toggleButtonSizeRatio;
  }
  
  void setStatus(boolean status){
    isOn = status;
  }  
}
