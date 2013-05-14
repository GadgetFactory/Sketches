  REM Gadget Factory
  REM Papilio One YM2149 YM File from Flash Example
 
 REM This example will let you play YM files from the SPI Flash using the ZPUino Soft Processor. 
 
 REM To learn more about this example visit its home page at the Papilio Audio Wiki:
 REM http://audio.gadgetfactory.net/index.php?n=Main.YM2149Flash
 
 REM To learn more about the Papilio and Gadget Factory products visit:
 REM http://www.GadgetFactory.net
 
 REM Hardware:
 REM * Connect a MIDI-Audio Wing to CH
 REM * Connect an Audio Wing to AL
 REM * User an Arcade MegaWing

 REM created 2012
 REM by Jack Gassett from Zetris code example
 REM http://www.gadgetfactory.net
 
 REM This example code is Creative Commons Attribution.
 
cd /D %0\..\bin
copy %1 audio.ym
ymTool.exe c audio.ym
REM ymdump "%~n1.dat"
ymdump audio.BIN
copy audio.BIN.dat ..\smallfs\audio.dat
rm audio.*
pause