// OPTION TO CONTROL THE BUTTON TOGGLES

void mouseClicked(){
          // ==================================================
          // BUTTON TOGGLE #1 
          // ==================================================
          if (!toggle1.getStatus() 
              && mouseX > toggle1.getPosX() 
              && mouseX < toggle1.getPosX() + toggle1.getToggleButtonSize()
              && mouseY > toggle1.getPosY() 
              && mouseY < toggle1.getPosY() + toggle1.getToggleButtonSizeRatio()*toggle1.getToggleButtonSize()) {
              
              toggle1.setStatus(true);                         
              synthKnob1.setKnobValue(synthKnob1.getTemporaryKnobVolume());

          } 
          else if(toggle1.getStatus() 
                  && mouseX > toggle1.getPosX() 
                  && mouseX < toggle1.getPosX() + toggle1.getToggleButtonSize()
                  && mouseY > toggle1.getPosY() 
                  && mouseY < toggle1.getPosY() + toggle1.getToggleButtonSizeRatio()*toggle1.getToggleButtonSize()) {
              
              toggle1.setStatus(false);
              synthKnob1.setTemporaryKnobVolume(synthKnob1.getKnobValue());
              synthKnob1.setKnobValue(0);
          }
          
          // ==================================================
          // BUTTON TOGGLE #2 
          // ==================================================
          if (!toggle2.getStatus() 
              && mouseX > toggle2.getPosX() 
              && mouseX < toggle2.getPosX() + toggle2.getToggleButtonSize()
              && mouseY > toggle2.getPosY() 
              && mouseY < toggle2.getPosY() + toggle2.getToggleButtonSizeRatio()*toggle2.getToggleButtonSize()) {
              
              toggle2.setStatus(true);                         
              synthKnob2.setKnobValue(synthKnob2.getTemporaryKnobVolume());

          } 
          else if(toggle2.getStatus() 
                  && mouseX > toggle2.getPosX() 
                  && mouseX < toggle2.getPosX() + toggle2.getToggleButtonSize()
                  && mouseY > toggle2.getPosY() 
                  && mouseY < toggle2.getPosY() + toggle2.getToggleButtonSizeRatio()*toggle2.getToggleButtonSize()) {
              
              toggle2.setStatus(false);
              synthKnob2.setTemporaryKnobVolume(synthKnob2.getKnobValue());
              synthKnob2.setKnobValue(0);
          }
          
          // ==================================================
          // BUTTON TOGGLE #3
          // ==================================================
          if (!toggle3.getStatus() 
              && mouseX > toggle3.getPosX() 
              && mouseX < toggle3.getPosX() + toggle3.getToggleButtonSize()
              && mouseY > toggle3.getPosY() 
              && mouseY < toggle3.getPosY() + toggle3.getToggleButtonSizeRatio()*toggle3.getToggleButtonSize()) {
              
              toggle3.setStatus(true);                         
              synthKnob3.setKnobValue(synthKnob3.getTemporaryKnobVolume());

          } 
          else if(toggle3.getStatus() 
                  && mouseX > toggle3.getPosX() 
                  && mouseX < toggle3.getPosX() + toggle3.getToggleButtonSize()
                  && mouseY > toggle3.getPosY() 
                  && mouseY < toggle3.getPosY() + toggle3.getToggleButtonSizeRatio()*toggle3.getToggleButtonSize()) {
              
              toggle3.setStatus(false);
              synthKnob3.setTemporaryKnobVolume(synthKnob3.getKnobValue());
              synthKnob3.setKnobValue(0);
          }
          
          // ==================================================
          // BUTTON TOGGLE #4
          // ==================================================
          if (!toggle4.getStatus() 
              && mouseX > toggle4.getPosX() 
              && mouseX < toggle4.getPosX() + toggle4.getToggleButtonSize()
              && mouseY > toggle4.getPosY() 
              && mouseY < toggle4.getPosY() + toggle4.getToggleButtonSizeRatio()*toggle4.getToggleButtonSize()) {
              
              toggle4.setStatus(true);                         
              synthKnob4.setKnobValue(synthKnob4.getTemporaryKnobVolume());

          } 
          else if(toggle4.getStatus() 
                  && mouseX > toggle4.getPosX() 
                  && mouseX < toggle4.getPosX() + toggle4.getToggleButtonSize()
                  && mouseY > toggle4.getPosY() 
                  && mouseY < toggle4.getPosY() + toggle4.getToggleButtonSizeRatio()*toggle4.getToggleButtonSize()) {
              
              toggle4.setStatus(false);
              synthKnob4.setTemporaryKnobVolume(synthKnob4.getKnobValue());
              synthKnob4.setKnobValue(0);
          }
          
          // ==================================================
          // EXPORT BUTTON
          // ==================================================
          if(mouseX > imgExport.getX() && mouseX < imgExport.getX() + imgExport.getWidth()
           && mouseY > imgExport.getY() && mouseY < imgExport.getY() + imgExport.getHeight()){         
                screenShot = get(0,0,612,height);
                screenShot.save("ScreenShots/SnowCrystal-"+screenShotCounter+".png");
                screenShotCounter = screenShotCounter+1;
                screenShotSound.play();
           }
           
           
          // ==================================================
          // RESET BUTTON
          // ==================================================
           if(mouseX > imgReset.getX() && mouseX < imgReset.getX() + imgReset.getWidth()
           && mouseY > imgReset.getY() && mouseY < imgReset.getY() + imgReset.getHeight()){         
                crystal.reset_crystal();
                stillGrowing.display();
                ResetSound.play();
           }
          
}
