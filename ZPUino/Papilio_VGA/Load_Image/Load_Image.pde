/*
  Gadget Factory
  Papilio One VGA Load Background Image Example
  
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
#include "SmallFS.h"

void blitImage(const char *name)
{
	VGA.blitStreamInit(0, 0, VGA.getHSize());

	SmallFSFile entry = SmallFS.open(name);
	if (entry.valid()) {
		entry.readCallback( entry.size(), &VGA.blitStream, (void*)&VGA );
	}
}

void setup() {
  VGA.clear();
  
  if (SmallFS.begin()<0) {
    Serial.println("No SmalLFS found, aborting.");
    while(1);
  }  
  
  blitImage("PapilioImage.dat"); 
}

void loop() {
  
}
