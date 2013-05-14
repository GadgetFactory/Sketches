/*
  Gadget Factory
  Papilio One VGA LCD Example
  
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
#include <VGA.h>
#include <VGALiquidCrystal.h>

VGALiquidCrystal lcd(1,1,1,1,1,1);

void setup() {
  VGA.clear();

 // set up the LCD's number of columns and rows:
 lcd.begin(16,2);
 // clear the LCD screen:
 lcd.clear();
 
 lcd.setCursor(0,0);
 lcd.print("PAPILIO LCD DEMO");
 lcd.setCursor(1,1);
 lcd.print("ZPUINO INSIDE!");
 delay(3000); 
}

void loop() {
 lcd.scrollDisplayLeft();
 delay(100);
}
