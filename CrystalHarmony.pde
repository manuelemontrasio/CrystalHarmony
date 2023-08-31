import themidibus.*; //Import the library
import javax.sound.midi.MidiMessage;
import java.util.Arrays;
import processing.sound.*;

// ========================================================================================
// ========================================================================================
// ==> GUI & SUPERCOLLIDER

      import controlP5.*;
      import oscP5.*;
      import netP5.*;
      
      OscP5 osc;
      NetAddress supercollider;
      
      ///////////////////////////////////////////
      // Knobs, Slider, Button
      ControlP5 cp5;
      ObjGui synthKnob1, synthKnob2, synthKnob3, synthKnob4, attackKnob, releaseKnob, volumeSlider;
      Button exportButton, resetButton;
      
      int screenShotCounter = 1; // To count the screenshots
      PImage screenShot;
      SoundFile screenShotSound;
      SoundFile ResetSound;
      
      /// TOGGLE
      ToggleButton toggle1, toggle2, toggle3, toggle4;
      
      ///////////////////////////////////////////
      // IMAGES
      ImageGui gui, imgExport, imgReset, stopGrowing, stillGrowing;
      
      /////////////////////////////////////////
      // OSC MESSAGES
      OscToSupercollider msgRhodes, msgFm, msgKal, msgSynth, msgAtt, msgRel, msgVol;
// ========================================================================================
// ========================================================================================
 

// ************************************************************
// ************************************************************
// ******* SNOW CRYSTAL PARAMETERS ****************************
// ************************************************************
// ************************************************************
      
      MidiBus myBus;
      int midiDevice  = 1;
      
      Hexagon[][] hexagon;
      int hexcountx, hexcounty;
      float rad = 1;  
      int melody_count = 0;
      IntList notes = new IntList ();
      
      SnowCrystal crystal;
      boolean exist;
      
      ////////////
      float alpha = 0.4; // alpha/12 parametro per media pesata // 0 < alpha < 2.69
      float beta = 0.4; // parametro iniziale// 0 < beta < 0.95
      float gamma = 0.00025;// costante da sommare
      ////////////
      float min_dif = 0.02;
      

void setup(){
      
  // ========================================================================================
  // ========================================================================================
  // SUPERCOLLIDER
  
      //////////////////////////////////////////////////////////
      ///
      /// CONTROL P5, OSC, IP ADDRESS TO SUPERCOLLIDER & OSC MESSAGES
      ///
      //////////////////////////////////////////////////////////
              cp5 = new ControlP5(this); // Per i knob e lo slider
              osc = new OscP5(this, 12000);
              supercollider = new NetAddress ("127.0.0.1", 57120);
      
              msgRhodes = new OscToSupercollider("/rhodes", osc, supercollider);
              msgFm = new OscToSupercollider("/fm", osc, supercollider);
              msgKal = new OscToSupercollider("/kalimba", osc, supercollider);
              msgSynth = new OscToSupercollider("/synth", osc, supercollider);
              msgAtt = new OscToSupercollider("/att", osc, supercollider);
              msgRel = new OscToSupercollider("/rel", osc, supercollider);
              msgVol = new OscToSupercollider("/volume", osc, supercollider);
              
  // ========================================================================================
  // ========================================================================================
  // WINDOW SETUP  
  // The remaining GUI features are called in the guiSetUp() method.
  
      //////////////////////////////////////////////////////////
      ///
      /// FRAMERATE, SIZE and BACKGROUND COLOUR
      ///
      //////////////////////////////////////////////////////////
      frameRate(200);
      size(1000, 680, P2D); // Originale 800x800
      background(0, 0, 0);
      noStroke();
      smooth(); 
      
      
  // ~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*
  // ~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*    
  // SNOW CRYSTALS e MIDI BUS
            
              MidiBus.list();
              myBus = new MidiBus(this, midiDevice, 1);
              
              crystal = new SnowCrystal(alpha, beta, gamma, hexagon); 
              crystal.initSnowCrystal();
              
  // ~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*
  // ~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*
    
}



void draw() {
  
  // ###############################
      // This part is to call the method guiSetUp, which allows to complete to call all the method of the setup()
      // in the draw() to avoid "RuntimeException".
      if (frameCount == 1) {
        this.guiSetUp();
      }
  // ###############################
  
  
  // ========================================================================================
  // ========================================================================================
  // GUI & SUPERCOLLIDER
  
      // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         // %%%%%
         // %%%%% MESSAGES TO SUPERCOLLIDER
         // %%%%%
         // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                  msgRhodes.sendToSupercollider(synthKnob1.getKnobValue()/100);
                  msgFm.sendToSupercollider(synthKnob2.getKnobValue()/100);
                  msgKal.sendToSupercollider(synthKnob3.getKnobValue()/100);
                  msgSynth.sendToSupercollider(synthKnob4.getKnobValue()/100);
                  msgAtt.sendToSupercollider(attackKnob.getKnobValue()/100);
                  msgRel.sendToSupercollider(releaseKnob.getKnobValue()/50);
                  msgVol.sendToSupercollider(volumeSlider.getSliderValue());

  
  // ========================================================================================
  // ========================================================================================
  
  
  // ************************************************************
  // ************************************************************
  // ******* SNOW CRYSTAL BEHAVIOUR *****************************
  // ************************************************************
  // ************************************************************
                  crystal.freeze();
                  crystal.setReceptiveToZero();
                  crystal.setNeighbouringCellsValue();
                  crystal.addGammaToReceptive();
                  crystal.setReceptiveToFalse();
                  
                  crystal.averageVoteBuffer();
                  crystal.listenToTempo();
            
      //////////////////////////////////////////////////////////
      ///
      /// DISPLAY GUI, EXPORT & RESET BUTTON
      ///
      //////////////////////////////////////////////////////////    
          // To avoid that the growing crystal overlaps the GUI, the gui is continuously displayed.
          gui.display();
          imgExport.displayExport();
          imgReset.displayReset();
          
                            
         // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         // %%%%%
         // %%%%% TOOGLE SYNTH VOLUMES
         // %%%%%
         // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          toggle1.initVisibility();
          toggle2.initVisibility();
          toggle3.initVisibility();
          toggle4.initVisibility();
}
