/*
  Gadget Factory
  Papilio One VGA Color Bar Example
  
 VGA Wing Introduction:
 http://papilio.cc/index.php?n=Papilio.VGAWingIntroduction
 
 Hardware:
 * Connect a 3-bit VGA Wing to AL 
or
 * Connect an Arcade MegaWing

 created 2012
 by Jack Gassett
 http://www.gadgetfactory.net
 
 This example code is in the public domain.
 */
#include "VGA.h"

int textarea = 20;
int colors[] = {RED,GREEN,BLUE,YELLOW,PURPLE,CYAN,WHITE,BLACK};

void setup() {
  int width = VGA.getHSize();
  int height = VGA.getVSize();
  int column = width/8;
  
  VGA.clear();
  VGA.setBackgroundColor(BLACK);
  VGA.setColor(RED);
  VGA.printtext(25,0,"Papilio/ZPUino");
  VGA.printtext(25,10,"Color Bar Test");
  for ( int i=0; i<8; i++ )
  {
    VGA.setColor(colors[i]);
    VGA.drawRect(i*column, textarea, column, height-textarea);
  } 
}

void loop() {
  
}
