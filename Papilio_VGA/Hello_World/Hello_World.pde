/*
  Gadget Factory
  Papilio One VGA Hello World Example
  
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

void setup() {

  VGA.clear();
  VGA.setBackgroundColor(BLACK);
  VGA.setColor(RED);
  VGA.printtext(30,0,"Papilio/ZPUino");
  VGA.printtext(35,10,"Hello World");
  VGA.printtext(15,30, "Hello World RED");
  VGA.setColor(GREEN);
  VGA.printtext(15,40, "Hello World GREEN");
  VGA.setColor(BLUE);
  VGA.printtext(15,50, "Hello World BLUE");
  VGA.setColor(YELLOW);
  VGA.printtext(15,60, "Hello World YELLOW");
  VGA.setColor(PURPLE);
  VGA.printtext(15,70, "Hello World PURPLE");
  VGA.setColor(CYAN);
  VGA.printtext(15,80, "Hello World CYAN");
  VGA.setColor(WHITE);
  VGA.printtext(15,90, "Hello World WHITE");   
  VGA.setBackgroundColor(WHITE);  
  VGA.setColor(BLACK);  
  VGA.printtext(15,100, "Hello World BLACK");  
}

void loop() {
  
}
