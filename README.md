# CrystalHarmony
Watch your music become a snow crystal

## Description
Crystal Harmony is an interactive visual experience that runs within the Processing environment. The tool allows the user to enjoy a visual representation of a musical piano performance.\
The program uses MIDI inputs and musical features (e.g., harmony and tempo) to affect the growth parameters of a snow crystal.\
Throughout the experience, the user can play and experiment with different sounds.\
No piano-skills are required to use Crystal Harmony, enthusiasm alone is sufficient!

<p align="center">
<img class= "center" src="https://github.com/manuelemontrasio/CrystalHarmony/assets/93670319/df633331-1058-4029-bdab-9a9cb83155c8" width="600">

  
## Instructions
### Get started
Connect your MIDI keybord to your PC. Please, be sure it is turned on.\
Open the SuperCollider file CrystalHarmony.sc. Reboot the server and run the script to initialize MIDI connections, MIDIdefs, SynthDefs and OSCdefs (follow the instructions in the file). Please, be sure that everything is working correctly by looking at the Post window.\
Open the Processing file CrystalHarmony.pde and run it. Please, wait until the menu appears before start playing.

### Menu features

<img align="right" src="https://github.com/manuelemontrasio/CrystalHarmony/assets/93670319/991f9e86-161c-4f0d-a079-b244002c6227" width="200"/>
The top part of the menu is devoted to the synths settings. Here a window containing four knobs can be found. These ones control the volume of each of the four synths. Next to each one of them there is a toggle botton that can mute/unmute them.<br>
The underneath bar controls the master volume.<br>
Under that you can find the knobs controlling the attack and decay time of all the synths.<br>
Then two bottons can be found. The left one saves a picture of the snow crystal in the Processing files folder. The right one resets the crystal generation.<br>
Finally the botton light turns red when the crystals reaches the boundarys of the window and stops growing.



## Authors
Manuele Montrasio\
Francesco Veronesi\
Francesco Zese
