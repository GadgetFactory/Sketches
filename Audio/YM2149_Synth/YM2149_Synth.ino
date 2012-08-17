/*
  Gadget Factory
  Papilio One YM2149 YM MIDI Synthesizer Example
 
 This example will let you play the YM2149 audio chip integrated into the ZPUino Soft Processor using a MIDI instrument such as a keyboard or guitar. 
 
 To learn more about this example visit its home page at the Papilio Audio Wiki:
 http://audio.gadgetfactory.net/index.php?n=Main.YM2149MIDISynthesizer
 
 To learn more about the Papilio and Gadget Factory products visit:
 http://www.GadgetFactory.net
 
 Hardware:
 * Connect a MIDI-Audio Wing to CH
 * Connect an Audio Wing to AL
 * User an Arcade MegaWing
 
 *******IMPORTANT********************
 Be sure to load the ZPUino "Apollo" variant to the Papilio's SPI Flash before loading this sketch.

 created 2012
 by Jack Gassett from Zetris code examples and YM2149 code examples at:
 http://kalshagar.wikispaces.com/Arduino+and+a+YMZ294

 http://www.gadgetfactory.net
 
 This example code is Creative Commons Attribution.
 */


#include "YM2149.h"
#include "MIDI.h"                   //Had to change MIDI.h to use Serial1 instead of Serial

#define AUDIOPIN WING_C_8           //For Audio-MIDI Wing connected to CH
#define AUDIOPINEXTRA WING_C_9

//#define AUDIOPIN WING_A_7         //For Audio Wing connected to AL

//#define AUDIOPIN WING_A_15        //For Arcade MegaWing
//#define AUDIOPINEXTRA WING_A_13

#define SERIAL1RXPIN WING_C_15      //Audio-MIDI Wing connected to CH

void setup(){
  Serial.begin(9600);

  //Move the audio output to the appropriate pins on the Papilio Hardware
  pinMode(AUDIOPIN,OUTPUT);
  digitalWrite(AUDIOPIN,HIGH);
  outputPinForFunction(AUDIOPIN, 9);
  pinModePPS(AUDIOPIN, HIGH);

  #ifdef AUDIOPINEXTRA
	pinMode(AUDIOPINEXTRA,OUTPUT);
	outputPinForFunction(AUDIOPINEXTRA, 9);
	pinModePPS(AUDIOPINEXTRA, HIGH);
  #endif  
  
  //Move the second serial port pin to where we need it, this is for MIDI input.
  pinMode(SERIAL1RXPIN,INPUT);
  inputPinForFunction(SERIAL1RXPIN, 1);
  
  //Setup the pin modes for the YMZ294
  setupYM2149();
   
  //don't forget to set the volume or you wont hear a thing...
  setVolumeYM2149(0x7f); 

  // Initiate MIDI communications, listen to all channels
  MIDI.begin(MIDI_CHANNEL_OMNI);  
 
  // Connect the HandleNoteOn function to the library, so it is called upon reception of a NoteOn.
  MIDI.setHandleNoteOn(HandleNoteOn);  // Put only the name of the function
  MIDI.setHandleNoteOff(HandleNoteOff);  // Put only the name of the function  
}

void loop(){
  // Call MIDI.read the fastest you can for real-time performance.
  MIDI.read();
  
}

void HandleNoteOn(byte channel, byte pitch, byte velocity) { 

  // Some keyboards send Note On with velocity 0 instead of Note Off.	
  if (velocity == 0)	
    return HandleNoteOff(channel, pitch, velocity);

  // Do whatever you want when you receive a Note On.
  Serial.print("Note Received: ");
  Serial.println(pitch);
  set_ch(ADDR_FREQ_A,pitch);
  set_ch(ADDR_FREQ_B,pitch+4);
  set_ch(ADDR_FREQ_C,pitch+7);

  // Try to keep your callbacks short (no delays ect) as the contrary would slow down the loop()
  // and have a bad impact on real-time performance.
}

void HandleNoteOff(byte channel, byte pitch, byte velocity) { 
//    set_ch(ADDR_FREQ_A,128);
//    set_ch(ADDR_FREQ_B,128);
//    set_ch(ADDR_FREQ_C,128);
//    Serial.print("In NoteOff");
}

