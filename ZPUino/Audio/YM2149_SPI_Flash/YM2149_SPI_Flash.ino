/*
  Gadget Factory
  Papilio One YM2149 YM File from Flash Example
 
 This example will let you play YM files from the SPI Flash using the ZPUino Soft Processor. 
 
 To learn more about this example visit its home page at the Papilio Audio Wiki:
 http://audio.gadgetfactory.net/index.php?n=Main.YM2149Flash
 
 To learn more about the Papilio and Gadget Factory products visit:
 http://www.GadgetFactory.net
 
 Hardware:
 * Connect a MIDI-Audio Wing to CH
 * Connect an Audio Wing to AL
 * User an Arcade MegaWing

 *******IMPORTANT********************
 Be sure to load the ZPUino "RetroCade Lite" variant to the Papilio's SPI Flash before loading this sketch.

 created 2012
 by Jack Gassett from Zetris code example
 http://www.gadgetfactory.net
 
 This example code is Creative Commons Attribution.
 */

#include "SmallFS.h"
#include "cbuffer.h"

// AUDIO STUFF

#define YM2149BASE IO_SLOT(13)
#define YM2149REG(x) REGISTER(YM2149BASE,x)

struct ymframe {
	unsigned char regval[14];
};

CircularBuffer<ymframe,2> YMaudioBuffer;

SmallFSFile ymaudiofile;

#define AUDIOPIN WING_C_8           //For Audio-MIDI Wing connected to CH
#define AUDIOPINEXTRA WING_C_9

//#define AUDIOPIN WING_A_7         //For Audio Wing connected to AL

//#define AUDIOPIN WING_A_15        //For Arcade MegaWing
//#define AUDIOPINEXTRA WING_A_13


static unsigned int timerTicks = 0;

void _zpu_interrupt()
{
	// Play
	if (YMaudioBuffer.hasData()) {
		int i;
		ymframe f = YMaudioBuffer.pop();
		for (i=0;i<14; i++) {
			YM2149REG(i) = f.regval[i];
		}
	}

	timerTicks++;

	TMR0CTL &= ~(BIT(TCTLIF));
}


void setup()
{

	pinMode(AUDIOPIN,OUTPUT);
	digitalWrite(AUDIOPIN,HIGH);
	outputPinForFunction(AUDIOPIN, 8);
	pinModePPS(AUDIOPIN, HIGH);

#ifdef AUDIOPINEXTRA
	pinMode(AUDIOPINEXTRA,OUTPUT);
	outputPinForFunction(AUDIOPINEXTRA, 8);
	pinModePPS(AUDIOPINEXTRA, HIGH);
#endif
	if (SmallFS.begin()<0) {
		Serial.println("No SmalLFS found, aborting.");
		//while(1);
	}

	ymaudiofile = SmallFS.open("audio.dat");

	INTRMASK = BIT(INTRLINE_TIMER0); // Enable Timer0 interrupt

	INTRCTL=1;

	// Start timer, 50Hz (prescaler 64)
	TMR0CMP = (CLK_FREQ/(50U*64))-1;
	TMR0CNT = 0x0;
	TMR0CTL = BIT(TCTLENA)|BIT(TCTLCCM)|BIT(TCTLDIR)|BIT(TCTLCP2)|BIT(TCTLCP0)|BIT(TCTLIEN);
}

void audiofill()
{
	// Check audio
	int r;

	ymframe f;
	while (!YMaudioBuffer.isFull()) {
		r = ymaudiofile.read(&f.regval[0], 16);
		if (r==0) {
			ymaudiofile.seek(0,SEEK_SET);
			ymaudiofile.read(&f.regval[0], 16);
		}
		YMaudioBuffer.push(f);
	}
}

void loop()
{
	audiofill();
}
