  

  void midiMessage(MidiMessage message) { 
    
    if(((int)message.getMessage()[0] & 0xFF) == 0x90){// IF NOTE ON
      notes.push(((int)message.getMessage()[1]) & 0xFF);
      //melody.push(((int)message.getMessage()[1]) & 0xFF);
      melody_count++;
    }
    if(((int)message.getMessage()[0] & 0xFF) == 0x80){// IF NOTE OFF
        for (int i = 0; i < notes.size(); i ++ ) { 
          if(notes.get(i)== ((int)message.getMessage()[1] & 0xFF)){
            notes.remove(i);
          }
        }
    }
        
    crystal.listenToHarmony(notes);  
  }
  
 
