void guiSetUp() {
  
  /**** Comments 
  When using P2D or P3D you have to run draw() within 5 seconds, else you get a RuntimeException.
  Hence, to tackle this problem:
     1) Setup heavy stuff (i.e createShape) prior to run Size() or FullScreen(), which should occur at the very end of your setup.
     2) Prepare the "heavy setup stuff" in a separate thread (...)
     3) Prepare the "heavy setup stuff" in the draw() at the very fist frame, i.e. when frameCount == 1
  
  We opted for the 3rd solution.
  ==> The method guiSetUp() is called to prepare the GUI and the features of the project related to supercollider.
  */
  
  
  // ========================================================================================
  // ========================================================================================
  // GUI
  
      //////////////////////////////////////////////////////////
      ///
      /// SETUP WINDOW, GUI & GUI IMAGES
      ///
      //////////////////////////////////////////////////////////
              gui = new ImageGui("GUI", 638, 26);
              gui.display(); // The position is selected as a function of the window size
      
      //////////////////////////////////////////////////////////
      ///
      /// KNOB SYNTH BOX
      ///
      //////////////////////////////////////////////////////////
            // *****************************
            // *** SYNTH1 + TOGGLE BUTTON
            // *****************************
               synthKnob1 = new ObjGui(cp5, "synthKnob1", gui.getX() + gui.getWidth()/4.5, gui.getY() + gui.getHeight()/5.25);               
               synthKnob1.buildKnob();
               float knobRadius = synthKnob1.getKnobRadius(); // Once for all (all the knobs have equal radius)
               toggle1 = new ToggleButton(synthKnob1, synthKnob1.getPosX() + 2.3*knobRadius, synthKnob1.getPosY() + knobRadius/2);
            
            // *****************************
            // *** SYNTH2 + TOGGLE BUTTON  
            // *****************************
               synthKnob2 = new ObjGui(cp5, "synthKnob2", gui.getX() + gui.getWidth()/8.5 + gui.getWidth()/2, gui.getY() + gui.getHeight()/5.25);
               synthKnob2.buildKnob();
               toggle2 = new ToggleButton(synthKnob2, synthKnob2.getPosX() + 2.3*knobRadius, synthKnob2.getPosY() + knobRadius/2);     
                    
            // *****************************
            // *** SYNTH3 + TOGGLE BUTTON
            // *****************************
               synthKnob3 = new ObjGui(cp5, "synthKnob3", gui.getX() + gui.getWidth()/4.5, gui.getY() + gui.getHeight()/2.8);
               synthKnob3.buildKnob();
               toggle3 = new ToggleButton(synthKnob3, synthKnob3.getPosX() + 2.3*knobRadius, synthKnob3.getPosY() + knobRadius/2);
                    
            // *****************************
            // *** SYNTH4 + TOGGLE BUTTON
            // *****************************
               synthKnob4 = new ObjGui(cp5, "synthKnob4", gui.getX() + gui.getWidth()/8.5 + gui.getWidth()/2, gui.getY() + gui.getHeight()/2.8);
               synthKnob4.buildKnob();
               toggle4 = new ToggleButton(synthKnob4, synthKnob4.getPosX() + 2.3*knobRadius, synthKnob4.getPosY() + knobRadius/2);
      
      //////////////////////////////////////////////////////////
      ///
      /// VOLUME SLIDER
      ///
      //////////////////////////////////////////////////////////
              volumeSlider = new ObjGui(cp5, "volumeSlider", gui.getX() + gui.getWidth()/4 - 5, gui.getY() + gui.getHeight()/1.75, 167, 18); 
              volumeSlider.buildSlider();
      
      //////////////////////////////////////////////////////////
      ///
      /// ATTACK-DECAY KNOBS BOX
      ///
      //////////////////////////////////////////////////////////  
              ////////// ATTACK KNOB
              attackKnob = new ObjGui(cp5, "attackKnob", gui.getX() + gui.getWidth()/4.5, gui.getY() + gui.getHeight()/5 + gui.getHeight()/2);
              attackKnob.buildKnob();
            
              ////////// RELEASE KNOB
              releaseKnob = new ObjGui(cp5, "releaseKnob", gui.getX() + gui.getWidth()/8.5 + gui.getWidth()/2, gui.getY() + gui.getHeight()/5 + gui.getHeight()/2);
              releaseKnob.buildKnob();
         
      //////////////////////////////////////////////////////////
      ///
      /// EXPORT & RESET BUTTON & SOUNDEFFECT
      ///
      //////////////////////////////////////////////////////////
              imgExport = new ImageGui("exportOn", "exportButton",  gui.getX() + 30, gui.getY() + 534);
              imgReset = new ImageGui("resetOn", "resetButton",  gui.getX() + 167, gui.getY() + 534);
              
              // Load a soundfile from the /data folder of the sketch and play it back
              screenShotSound = new SoundFile(this, "SoundFiles/screenShotSound.mp3");
              ResetSound = new SoundFile(this, "SoundFiles/ResetSound.mp3");
              
      //////////////////////////////////////////////////////////
      ///
      /// GROWING LED
      ///
      //////////////////////////////////////////////////////////
              stillGrowing = new ImageGui("stillGrowing", 790, 615);
              stopGrowing = new ImageGui("stopGrowing", 790, 615);
              stillGrowing.display();
  
  // ========================================================================================
  // ========================================================================================
  
  // Wait 5 seconds to simulate a long setup
  // Wait 5 seconds
  
  try { 
    Thread.sleep(5000);
  } 
  catch (InterruptedException e) {
  }
  
}
