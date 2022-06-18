//  Pi Zero model for checking other models
//  0,0,0 is centre of PCB, bottom face
//  This model is for V1.2

// PCB size variables
PiSizeX = 65.04;
PiSizeY = 30.04;
PiSizeZ = 1.5;
PiCornerRad = 3.52;
PiHoleEdge = 3.5;       // Mount holes are 3.5mm from each edge
PiHoleDia = 2.75;
PiHoleRad = PiHoleDia / 2;
PiHoleClearRad = 3.0;    // Mount holes have 6 Dia clear on PCB

//  Component connector centrelines from Pi centreline
PiSDX = -24.5;          // SD holder
PiSDY = 1.9;
PiUSBX = 8.9;           // Data (USB)
PiUSBY = -13;
PiOTGX = 21.5;          // Power (OTG)
PiOTGY = -13;
PiHDMIX = -20.1;        // HDMI
PiHDMIY = -11.4;
PiLEDX = 28.38;         // LED
PiLEDY = -7.87;
PiCAMX = 32.5;   //Camera connector
PiCAMY = 0;


//  Component connector sizes
PiSDsizeX = 11.5;
PiSDsizeY = 12.0;
PiSDsizeZ = 1.3;
PiUSBsizeX = 8;
PiUSBsizeY = 6.0;
PiUSBsizeZ = 3;
PiHDMIsizeX = 12.25;
PiHDMIsizeY = 8.25;
PiHDMIsizeZ = 4;
PiCAMsizeY = 17;
PiCAMsizeX = 8;
PiCAMsizeZ = 3;


// Keepout sizes
PiKOLengthX = PiSizeX;
PiKOLengthY = 17;
PiKOLengthZ = 1.9;
PiKOWidthX = 52.5;
PiKOWidthY = PiSizeY;
PiKOWidthZ = 1.6;


//  SOC centrelines and sizes
PiSOCX = -2.5;
PiSOCY = -2;
PiSOCsizeX = 12;
PiSOCsizeY = 12;
PiSOCsizeZ = 1.2;


//  Mount hole dims from centre lines
PiHoleX = PiSizeX/2 - PiHoleEdge;
PiHoleY = PiSizeY/2 - PiHoleEdge;

//
// Modules used for Pi model
//
module PiDrawPad(Xpos,Ypos,Di,Col)    // Places a spot at test pad point, coloured to show pad function
{
translate([Xpos,Ypos,PiSizeZ/4])
    color(Col)
    cylinder(h=PiSizeZ*2/3,d=Di,center=true);
}

module PiPCBhole(Xpos,Ypos)   // Cuts a hole through PCB
{
translate([Xpos,Ypos,PiSizeZ/2])
    cylinder(h=2*PiSizeZ,d=PiHoleDia,center=true);
}

module PiComponent(Xpos,Ypos,Xsize,Ysize,Zsize,Col)    // Makes a block to represent a component on the upper face
{
translate([Xpos,Ypos,PiSizeZ + Zsize/2]) color(Col)
    cube([Xsize,Ysize,Zsize], center=true);
}

module PiLEDCone(Xpos,Ypos,Col)    // Places a spot at test pad point, coloured to show pad function
{
    translate([Xpos,Ypos,PiSizeZ/4]) {
        color(Col);
        cylinder(h=60,r1=1.2,r2=10,center=false);
    }
}

//
//  This is the main routine and can be called from outside
//
module PiZeroBody() // Models the Pi.
{
color("Green")
difference()
    {
    hull()  // PCB shape
        {
        translate([-PiHoleX,-PiHoleY,PiSizeZ/2])
            cylinder(r=PiCornerRad,h=PiSizeZ,center=true);
        translate([PiHoleX,-PiHoleY,PiSizeZ/2])
            cylinder(r=PiCornerRad,h=PiSizeZ,center=true);
        translate([PiHoleX,PiHoleY,PiSizeZ/2])
            cylinder(r=PiCornerRad,h=PiSizeZ,center=true);
        translate([-PiHoleX,PiHoleY,PiSizeZ/2])
            cylinder(r=PiCornerRad,h=PiSizeZ,center=true);
        }
 
    // Corner screw holes
    PiPCBhole(-PiHoleX,-PiHoleY);
    PiPCBhole(PiHoleX,-PiHoleY);
    PiPCBhole(PiHoleX,PiHoleY);
    PiPCBhole(-PiHoleX,PiHoleY);
   
    }
    
PiComponent(PiSOCX,PiSOCY,PiSOCsizeX,PiSOCsizeY,PiSOCsizeZ,"Black");   // Processor
PiComponent(PiSDX,PiSDY,PiSDsizeX,PiSOCsizeY,PiSOCsizeZ,"Silver");   // SD card
PiComponent(PiHDMIX,PiHDMIY,PiHDMIsizeX,PiHDMIsizeY,PiHDMIsizeZ,"Silver");   // HDMI
PiComponent(PiUSBX,PiUSBY,PiUSBsizeX,PiUSBsizeY,PiUSBsizeZ,"Silver");   // USB
PiComponent(PiOTGX,PiOTGY,PiUSBsizeX,PiUSBsizeY,PiUSBsizeZ,"Silver");   // Power
PiComponent(PiCAMX,PiCAMY,PiCAMsizeX,PiCAMsizeY,PiCAMsizeZ,"Silver");   // Camera
PiComponent(0,0,PiKOLengthX,PiKOLengthY,PiKOLengthZ,"Yellow");   // Keep Out
PiComponent(0,0,PiKOWidthX,PiKOWidthY,PiKOWidthZ,"Yellow");   // Keep Out
PiLEDCone(PiLEDX,PiLEDY,"Green");
}


/*
End of Pi model routines
Program from here
*/

// Input variables
ShowPiZero = true;
//ShowPiZero = false;

// Overall definition
$fn=20;


// Model the Zero if required
if(ShowPiZero) {
     rotate(a=180, v=[0,0,1]) {
        translate ([0, 0, -2]) {
            rotate(a=180, v=[1,0,0]) {
                PiZeroBody();
            }
        }
    }
}
