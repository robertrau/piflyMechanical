//  PyFly Cage design
// written in OpenSCAD
// Camera flex cable: https://smile.amazon.com/gp/product/B0716TB6X3/ref=oh_aui_detailpage_o00_s00?ie=UTF8&psc=1
//
//
// Written: 9/10/2017
//    Rev.: 0.01
//      By: Robert S. Rau
// Updated: 9/30/2017
//    Rev.: 0.02
//      By: Robert S. Rau
// Changes: more cutouts for connectors and wire
//
// Updated: 10/1/2017
//    Rev.: 0.03
//      By: Robert S. Rau
// Changes: added camera, more room for GPS antenna, changed left/right logic so GPS antenna slide-in would work, bigger width for USB connectors on Zero
//
// Updated: 10/3/2017
//    Rev.: 0.04
//      By: Robert S. Rau
// Changes: added extra width to camera so it can be removed, added wire channel so sliding cage together doesn't crush camera flat cable. Added champhers to card guides.
//
// Updated: 10/5/2017
//    Rev.: 0.05
//      By: Robert S. Rau
// Changes: Added extra width to camera flex so it doesn't snag. Fixed Pi Zero LED cone allignment. Added Battery well for Panasonic BR-435 fishing lure battery, see Digi-Key. More room for Deans connector.
//
// Updated: 10/7/2017
//    Rev.: 0.06
//      By: Robert S. Rau
// Changes: PyFly USB connector size increased in Z, USB connector pins added on bottom of board.
//          Thinned and lengthend Deans power connector, narrowed LED cones by 2mm.
//          Added super cap. Added serial connector space so right side can slide in.
//          Lengthened servo connector to remove sliver caused by serial connector change.
//          Added space for Tach connector and room on right side to slide in.
//
// Updated: 10/8/2017
//    Rev.: 0.07
//      By: Robert S. Rau
// Changes: ToDo list updated. Added CameraFeatures option.
//
// Updated: 11/18/2017
//    Rev.: 0.08
//      By: Robert S. Rau
// Changes: ToDo list updated. Battery well no longer intersects screw cylinder. Clearance for remaining parts, option for old PyFly (1.0)
//
// Updated: 11/18/2017
//    Rev.: 0.08
//      By: Robert S. Rau
// Changes: Camera's camera connector depth changed from 3mm to 2.6. Main wiring channel divided into two parts, USB end made smaller to allow for a step for the two haves to mate against.
//
// Updated: 1/1/2023
//    Rev.: 0.09
//      By: Robert S. Rau
// Changes: Started mods for ArduCam 16MP
//
// Updated: 1/4/2023
//    Rev.: 0.10
//      By: Robert S. Rau
// Changes: Made more room for ArduCam 16MP camera
//
// Updated: 8/22/2023
//    Rev.: 0.11
//      By: Robert S. Rau
// Changes: Opened up Deans power connector area so PiFly would slide in eaiser. Expanded PCB thickness, 1.65->1.72
//
// Updated: 8/23/2023
//    Rev.: 0.12
//      By: Robert S. Rau
// Changes: Added opening for Pi Zero USB connectors. Increased HDMI connector opening and connector access. Increased PiFly board thickness.
//
//  ToDo list
// Add channel for tie-wrap to hold the thing together
// Add board supports (slots) and space for analog adapter board
// more height to W1 & W2
// Cutout for Pi connectors leaves filiment strands
// Quad copter version should allow for non omni antenna
// Room for right side to slide over differential pressure sensor.
// High current drive needs to be taller and wider
// No room for SMT parts on right side cage
// Should fork and do a old PyFly version cage
// clearance for Q4, R17, C43
//
// 
//
//
//
// IMPORTANT NOTES
//
// For rocket applications:
//  1) Any openings on your body tube for camera. LEDs, or button will affect the air pressure in the payload cavaity.
//       This will affect the barametric altimeter's reading. Make sure the body tube openings are at a neutral pressure
//       point down the side of your rocket.
//
//
//
//
//Printing
// Cura settings
//  Layer Height  0.2mm
//  Wall thickness 1mm
//  Infill 15%
//  Generate Support  Yes
//  Support structure  Tree
//  Support Branch angle  40°
//  Support Overhang Angle  50°
//  Support Placement  Touching Buildplate
//  Support pattern  Lines
//  Support Interface Pattern  Zig Zag
//  Buildplate Adhesion Type  None
//  Print left side with camera pointing to side.
//  
//
//
// Overall circle/sphere definition
$fn=90;

// USER PARAMETERS
// Here you set up which side of the clam shell you want to render/print, size of your body tube, and such
// for the left side, set CageLeftSide to true, for the right side, set CageLeftSide to false.
OldPyFly = true;   // This removes plastic around the new mounting holes and the old PyFly reset switch.
CageLeftSide = true;     // Set this true for one half, false for the other half. Left side has HDMI connector, Right side has backup battery.

HDMIUsed = true;   // make opening for mating connector

//MntCylinderDia = 38.1;    //  38mm rocket motor tube
//MntCylinderDia = 52.65;    //  Wildman coupler tube
//MntCylinderDia = 54.6;    //  Wildman body tube
MntCylinderDia = 39.1;    //  Estes BT-
//MntCylinderDia = 75.78;   //  2.6in rocket body tube
//MntCylinderDia = 102;     //  4in rocket body tube
//MntCylinderDia = 29.5;    //  use for minimum rectangle
//
//
// Do you want to mount the camera on the left side (right side has wire channel)?
CameraFeatures = true;
//
// This give you two options for camera mounting and video/still requirements. By default, CamFlip=false, the Pi camera produces images with the
//  correct orientation with the flex cable comming out the bottom. For the camera to be in this orientation the flex cable must
//  get a twist, which uses a bit of cable routing volume. You can set CamFlip to true and have nice flex cable routing but you
//  need to flip the image in software. raspivid must use the -ro 180 option, and raspistill must use -vf -hf options.
CamFlip = true;


module externalCylinder( diameter, length) {
    rotate( a=90, v=[0,1,0]) {cylinder(h=length, d=diameter, center=true );}
}





//  Model of space required for PyFly HAT board
//
// Written: 9/10/2017
//    Rev.: 0.01
//      By: Robert S. Rau
//
//
//  Coordinate system referenced to Osmand PCB layout coordinates. The Z zero is the board top, layer 1, for module PyFlyBoardNoHoles.
//  There is a Z coordinate shift in module PyFlyBoard.
//
//
// PCB
PCBThickness = 1.8;  //  PiFly nominal PCB thickness is 1.6mm
PyFlyZoffset = 0.5;


module PyFlyLEDCone(Xpos,Ypos,Col)    // Places a spot at test pad point, coloured to show pad function
{
    translate([Xpos,Ypos,PCBThickness/4]) {
        color(Col);
        rotate( a=180, v=[1,0,0]) cylinder(h=100,r1=1.2,r2=8,center=false);
    }
}


module PyFlyButtonCone(Xpos,Ypos,Col)    // Places a spot at test pad point, coloured to show pad function
{
    translate([Xpos,Ypos,PCBThickness/4]) {
        color(Col);
        rotate( a=180, v=[1,0,0]) cylinder(h=100,r1=.7,r2=10,center=false);
    }
}



module PyFlyBoardNoHoles() {
    translate([-0.25,-0.25,0]) cube([150.5,29.75,PCBThickness]);  //PCB  0.5mm oversize slot
    // new PyFly 2.00 features
    translate([-4.24,-0.25,0]) cube([4.01,29.75,PCBThickness]);  //Extra length of version 2.00
    
            // shape to make card guide champhers
        hull()
        {
            translate([-0.25,-0.25+5,0]) cube([150.5, 29.75-10, PCBThickness]);
            translate([-0.25,-0.25+6,-1]) cube([150.5, 29.75-12, PCBThickness+2]);
            translate([-0.25,-0.25+6,-1]) cube([150.5, 29.75-12, PCBThickness+2]);
        }
// First wiring channel covers from the GPS end of the board to just pass the Pi Zero, this channel is a little bigger than the next.
    hull() {
        translate([-1,15,(PCBThickness-2.6 )]) rotate(a=90, v=[0,1,0]) cylinder(d=17.5,h=(100),    center=false);   //wiring channel (opening down the center, above and below the boards)
        translate([-1,15,(PCBThickness + 2.39)]) rotate(a=90, v=[0,1,0]) cylinder(d=17.5,h=(100),    center=false);   //wiring channel 2
    }
    // Second wiring channel picks up where the first left off, from just beyond the Pi Zero past the USB connector. It doesn't go as deep to allow a step for the two haves to mate against each other
    hull() {
        translate([98,15,(PCBThickness-1.3 )]) rotate(a=90, v=[0,1,0]) cylinder(d=17.5,h=(100),    center=false);   //wiring channel (opening down the center, above and below the boards)
        translate([98,15,(PCBThickness + 2.39)]) rotate(a=90, v=[0,1,0]) cylinder(d=17.5,h=(100),    center=false);   //wiring channel 2
    }
    translate([62.5,15,(PCBThickness - 0.1)-3.2]) cube([53,30,4], center=true);               // Space between Zero and PyFly
    translate([0,0,(PCBThickness - 0.1)-4.4]) cube([24,12.7,96]);               // Servo connectors
    translate([-2.54,-4,(PCBThickness - 0.1)-3.2]) cube([2.7,16,96]);               // Dual Servo connector
    if (CageLeftSide)
    {
        translate([0,16.18,(PCBThickness + 0.39)]) rotate(a=270, v=[0,1,0]) cylinder(d=20,h=(39.0),center=false);   //GPS antenna
    }
    else
    {
        hull() {
        translate([0,16.18,(PCBThickness + 0.39)]) rotate(a=270, v=[0,1,0]) cylinder(d=20,h=(39.0),center=false);   //GPS antenna
        translate([0,-28,(PCBThickness + 0.39)]) rotate(a=270, v=[0,1,0]) cylinder(d=20,h=(39.0),center=false);   //GPS antenna
        }
    }
    translate([62.23, 26.4,(PCBThickness - 0.1)-2.5]) cube([52,5.2,8.5], center=true);  // Pi connector
    translate([152, 8.57,PCBThickness-4.5]) cube([15.5,13.5,9], center=true);  //USB connector
    translate([147.77, 8.57,PCBThickness+1.0]) cube([4,14.7,1.9], center=true);  //USB connector pins
    translate([152+7.75+20, 8.57,PCBThickness-3.75]) cube([44,20,15], center=true);  //USB Device
    translate([3.81, 24,(PCBThickness - 0.1)+5.5+50]) cube([5.2,2.8,17+100], center=true);  // Battery connector
    hull() 
    {
        translate([24.848, 17.58,(PCBThickness - 0.1)+5.5+50]) cube([2.2,8.4,17+100], center=true);  // Serial connector
        translate([24.848, -17.58,(PCBThickness - 0.1)+5.5+50]) cube([2.2,8.4,17+100], center=true);  // Serial connector
    }
     hull() 
    {
        translate([82.73415, 12.37,(PCBThickness - 0.1)+5.5+50]) cube([6.6,10.7,17+100], center=true);  // Tach connector
        translate([82.73415, -10,(PCBThickness - 0.1)+5.5+50]) cube([6.6,10.7,17+100], center=true);  // Tach connector
    }
    translate([139.25, 40,PCBThickness-7.25]) cube([22.5,57.5,21], center=true);  // High current connector
    translate([133.1, 2.85-1,PCBThickness+5.5]) cube([19,20,17], center=true);  // Keypad connector
    translate([138.35, 9.3218,PCBThickness+5.5]) cube([4,12,17], center=true);  // analog connector
    translate([55.734, 11.94,PCBThickness+5.5]) cube([12,14,11], center=true);  // Diff pressure sens
    translate([99.61, 5.73,PCBThickness+2.3]) cube([5.1,8,7], center=true);  // Interrupt jumpers
    translate([41.4, 5,PCBThickness+12.5+50]) cube([5.4,16,115], center=true);  // Audio connector, P4
    translate([115, 12.7,PCBThickness+2.5]) cube([17,10,200], center=true);  // Deans Power connector
    translate([115, 18.5,PCBThickness-13.5]) cube([15,9.5,11], center=true);  // Deans Power connector insertion well
    translate([115, 03,PCBThickness-6]) cube([15,9.5,9], center=true);  // Power supply modification clearance-----remove with new board.
    translate([72.5, 5.3,PCBThickness+0.5]) cube([32,10,4], center=true);  // parts
    hull()
    {
        translate([11.8872, 20.3484,PCBThickness-7.2]) cylinder(d=12,h=8, center=true);  // Super capacitor
        translate([11.8872, 14.3484,PCBThickness-7.2]) cylinder(d=12,h=8, center=true);  // Super capacitor
    }
    if (OldPyFly)
    {
        translate([19,22,PCBThickness/2-5.5]) cube([7.25,7,5.5], center=false);  // parts: Old PyFly reset button
        translate([25.5,26,PCBThickness/2])cube([6.5,6.5,6],center=true);
        translate([111,26,PCBThickness/2])cube([6.5,6.5,6],center=true);

    }
    translate([0,17,PCBThickness/2-3]) cube([22.25,29.25-17,6], center=false);  // parts: R40
    translate([28.75,17,PCBThickness/2-3]) cube([8.25,29.25-17,6], center=false);  // parts: Q3, R56
    translate([55, 6.5,PCBThickness/2]) cube([21,10,5], center=true);  // parts: PP35, PP23, R6
    translate([40.5, 5.3,PCBThickness/2]) cube([8,10,5], center=true);  // parts: D2
    translate([15.4, 5,PCBThickness/2]) cube([30.6,10,5.5], center=true);  // parts: U15, U10
    translate([122.25, 6.25,PCBThickness/2]) cube([55.5,10,5], center=true);  // parts: C27, C28, R67
    translate([0,3,PyFlyZoffset-3]) cube([19,23,3], center=false);  // parts    GPS LEDs resistors
    translate([114,17,PCBThickness/2-3]) cube([14,29.25-17,6], center=false);  // parts    High side driver
    translate([90.5,17,PCBThickness/2-3]) cube([17.5,29.25-17,6], center=false);  // parts    High side driver control logic & RF**
    PyFlyLEDCone(4.7,27.686,"Yellow");  // LED
    PyFlyLEDCone(4.7,26.543,"Yellow");  // LED
    PyFlyLEDCone(105.12,2.51,"Yellow");  // LED
    PyFlyLEDCone(107.98,21.107,"Yellow");  // LED
    translate([18.75,27.15,PCBThickness-2.0]) cube([5,3,3], center=true);  // button block
    translate([18.75,27.15,PCBThickness-3.7]) PyFlyButtonCone(0,0,"Blue");  // button cone
    MountingHoles();
    }

// Cutout for USB test point wires
module USBWireCutout() {
    hull() {
        translate([44.57,0,0]) cylinder(r=0.01,h=PCBThickness * 2.1,center=true);
        translate([46.8,1.5,0]) cylinder(r=0.01,h=PCBThickness * 2.1,center=true);
        translate([54.2,1.5,0]) cylinder(r=0.01,h=PCBThickness * 2.1,center=true);
        translate([56.43,0,0]) cylinder(r=0.01,h=PCBThickness * 2.1,center=true);
    }
}

module MountingHoles() {
    translate([33.5,3.5,0])cylinder(d=2.743,h=PCBThickness*20.1,center=true);
    translate([91.5,3.5,0])cylinder(d=2.743,h=PCBThickness*20.1,center=true);
    translate([25.5,26,0])cylinder(d=2.743,h=PCBThickness*20.1,center=true);
    translate([111,26,0])cylinder(d=2.743,h=PCBThickness*20.1,center=true);
}




module PyFlyBoard() {
//    translate([-62.5,-15,PyFlyZoffset]) difference () {
    translate([-62.5,-15,PyFlyZoffset]) {
        PyFlyBoardNoHoles();
        //USBWireCutout();
        //MountingHoles();
    }
}

module ScrewFlats() {
    translate([-62.5,-15,0.5]) translate([33.5,3.5,0])cylinder(d=7,h=50,center=true);
    translate([-62.5,-15,0.5]) translate([91.5,3.5,0])cylinder(d=7,h=50,center=true);
    translate([-62.5,-15,-0.5]) translate([25.5,26,0])cylinder(d=7,h=50,center=true);
    translate([-62.5,-15,-0.5]) translate([111,26,0])cylinder(d=7,h=50,center=true);
}
















//  Pi Zero model for checking other models
//  0,0,0 is centre of PCB, bottom face
//  This model is for V1.2

// PCB size variables
PiSizeX = 65.4;
PiSizeY = 30.4;
PiSizeZ = 1.7;   // new zeros are thicker  8/22/2023
PiCornerRad = 3.52;
PiHoleEdge = 3.5;       // Mount holes are 3.5mm from each edge
PiHoleDia = 2.75;
PiHoleRad = PiHoleDia / 2;
PiHoleClearRad = 3.0;    // Mount holes have 6 Dia clear on PCB

//  Component connector centrelines from Pi centreline
PiSDX = -24.5;          // SD holder
PiSDY = 1.9;

PiUSBX = 8.9;           // Data (USB)
PiUSBY = -11;

PiOTGX = 21.5;          // Power (OTG)
PiOTGY = -11;

PiHDMIX = -20.1;        // HDMI
PiHDMIY = -6.4;

PiHDMImcX = -20.1;        // HDMI mating connector
PiHDMImcY = -7;
PiHDMImcZ = -10;

PiLEDX = 27.38;         // LED
PiLEDY = -7.87;

PiCAMX = 32.5;   //Camera connector
PiCAMY = 0;


//  Component connector sizes
PiSDsizeX = 11.5;
PiSDsizeY = 12.0;
PiSDsizeZ = 1.3;     // Connector height (may be from point below surface of board (center = Zsize/2.3 )

PiUSBsizeX = 10;     // extra mm needed for little tabs on end of USB connectors
PiUSBsizeY = 18.0;
PiUSBsizeZ = 4;       // USB connectors have lips that extend higer and lower that the main (center = Zsize/2.3 )

PiHDMIsizeX = 13;
PiHDMIsizeY = 26;
PiHDMIsizeZ = 4.3;

PiHDMImcsizeX = 20;
PiHDMImcsizeY = 100;
PiHDMImcsizeZ = 100;

PiCAMsizeX = 8;
PiCAMsizeY = 17;
PiCAMsizeZ = 1.8;


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
translate([Xpos,Ypos,PiSizeZ  + Zsize/2.3]) color(Col)   // USB connectors have lips that extend higer and lower that the main connector height
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
//difference()
//    {
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
        
        // shape to make card guide champhers
        hull()
        {
            translate([0,0,PiSizeZ/2]) cube([PiSizeX, PiSizeY-12, PiSizeZ],center=true);
            translate([0,0,PiSizeZ/2]) cube([PiSizeX, PiSizeY-14, PiSizeZ+2],center=true);
        }

 
    // Corner screw holes
    PiPCBhole(-PiHoleX,-PiHoleY);
    PiPCBhole(PiHoleX,-PiHoleY);
    PiPCBhole(PiHoleX,PiHoleY);
    PiPCBhole(-PiHoleX,PiHoleY);
   
 //   }
    
PiComponent(PiSOCX,PiSOCY,PiSOCsizeX,PiSOCsizeY,PiSOCsizeZ,"Black");   // Processor
PiComponent(PiSDX,PiSDY,PiSDsizeX,PiSOCsizeY,PiSOCsizeZ,"Silver");   // SD card
PiComponent(PiHDMIX,PiHDMIY,PiHDMIsizeX,PiHDMIsizeY,PiHDMIsizeZ,"Silver");   // HDMI
if (HDMIUsed) {        
    //PiComponent(PiHDMImcX,PiHDMImcY,PiHDMImcsizeX,PiHDMImcsizeY,PiHDMImcsizeZ,"Blue");   // HDMI mating connector
    translate([PiHDMImcX,-PiHDMImcsizeY/2-16,-PiHDMImcsizeZ/2+18])   //    
//    translate([PiHDMImcX,PiHDMImcY-PiHDMImcsizeY/2,PiHDMImcsizeZ  + PiHDMImcsizeZ/2.3])   // USB connectors have lips that extend higer and lower that the main connector height
    cube([PiHDMImcsizeX+2,PiHDMImcsizeY,PiHDMImcsizeZ], center=true);
    
    }
PiComponent(PiUSBX,PiUSBY,PiUSBsizeX,PiUSBsizeY,PiUSBsizeZ,"Silver");   // USB
PiComponent(PiOTGX,PiOTGY,PiUSBsizeX,PiUSBsizeY,PiUSBsizeZ,"Silver");   // Power
PiComponent(PiCAMX,PiCAMY,PiCAMsizeX,PiCAMsizeY,PiCAMsizeZ,"Silver");   // Camera
PiComponent(0,0,PiKOLengthX,PiKOLengthY,PiKOLengthZ,"Yellow");   // Keep Out
PiComponent(0,0,PiKOWidthX,PiKOWidthY,PiKOWidthZ,"Yellow");   // Keep Out
PiLEDCone(PiLEDX,PiLEDY,"Green");

}






// Pi Zero in position
module PiZeroInPosition() {
     rotate(a=180, v=[0,0,1]) {
        translate ([0, 0, -2]) {
            rotate(a=180, v=[1,0,0]) {
                PiZeroBody();
            }
        }
    }
}




// These two cubes are used to cut the model in two parts
module CutCubes() {
    translate([0,250,-7]) cube([500,500,500], center=true);
    translate([0,-250,10]) cube([500,500,500], center=true);
}





// Camera stuff

CamPCBThickness = 1.1;
CamSizeY = 33.6;   //extra width so the camera can be removed (camera width is 25mm)
CamSizeZ = 24.9;
CamSensorHeight = 5.1;  // This matches the Pi Camera V2
CamLensOffsetZ = 2.5;
CamLensHeight = 4.86;
CamBotEleHeight=2.6-CamPCBThickness;  // expressed this way since it is the easiest way to measure
CamMountingHoleCCZ = 12.5;
CamMountingHoleCCY = 21;
CamConnectorZ = 7.6;  // connector depth from board edge into board
CamFlexWidth = 18;


    
// mounting holes
module CamHoles() {
         translate([0,CamMountingHoleCCY/2.0,CamMountingHoleCCZ]) {
             rotate( a=90, v=[0,1,0]) { cylinder(d=1.7,h=100,center=true); }
         }
         translate([0,-CamMountingHoleCCY/2.0,CamMountingHoleCCZ]) {
             rotate( a=90, v=[0,1,0]) { cylinder(d=1.7,h=100,center=true); }
         }
         translate([0,CamMountingHoleCCY/2.0,0]) {
             rotate( a=90, v=[0,1,0]) { cylinder(d=1.7,h=100,center=true); }
         }
         translate([0,-CamMountingHoleCCY/2.0,0]) {
             rotate( a=90, v=[0,1,0]) { cylinder(d=1.7,h=100,center=true); }
         }
    
}



module CamPCB() {
    difference() {
    translate([CamPCBThickness/2.0+50,0,CamLensOffsetZ]) {
        cube([CamPCBThickness+100,CamSizeY,CamSizeZ], center=true);
    }
    CamHoles();
}
}




// bottom side electronics
module CamBotEle() {
     translate([-CamBotEleHeight/2.0+0.01,0,CamMountingHoleCCZ/2.0]) {
        cube([CamBotEleHeight,CamSizeY,9], center=true);
     }
     translate([-CamBotEleHeight/2.0+0.01,0,CamLensOffsetZ]) {
        cube([CamBotEleHeight,CamMountingHoleCCY-3,CamSizeZ], center=true);
     }  
     translate([-CamBotEleHeight/2.0+0.01,0,CamLensOffsetZ+4]) rotate([45,0,0]) {
        cube([CamBotEleHeight,21,21], center=true);
     }  
    // connector 
     translate([-1.49,0,-CamSizeZ/2.0+CamLensOffsetZ+CamConnectorZ/2.0]) {
        cube([4,23.8,CamConnectorZ], center=true);     // connector width changed from 22 to 23.4 for ArduCam 16MP camera
     }   
    // Flex 
     translate([-1.57+50,0,-CamSizeZ/2.0+CamLensOffsetZ-2.9]) {
        cube([0.4+100,CamFlexWidth+.5,9], center=true);
     }   
  }
    
    
    


module CamPocket() {

    CamPCB();
    CamBotEle();
}
// !CamPocket();
//!translate([0,0,0]) rotate(a=90,[0,1,0]) CamPocket();



module FullCage() {
    difference() {
 
        externalCylinder(MntCylinderDia,200);
//       translate([0,0,3]) cube([200,36,25], center=true);     // minimum rectangle for airplanes and quadcopters
 
        PyFlyBoard();
        PiZeroInPosition();

// select only one  for the CutCubes, this makes the left or right side of the cage,comment whole if clause to see whole cage.  
            if (CageLeftSide)
            {
        translate([0,0,247.99]) CutCubes();     // Left side
            }
            else
            {
        translate([0,0,247.99-500]) CutCubes();    // Right side
            }
        
        translate([0,0,-37])ScrewFlats();
        translate([0,0,35.5])ScrewFlats();
        hull() {
            translate([48,-8,116]) cube([220,7,200],center=true);  // wire channel
            translate([48,-10.5,114]) cube([220,7,200],center=true);  // wire channel
            translate([48,-11.5,113]) cube([220,3,200],center=true);  // wire channel
            translate([48,-100,113]) cube([220,7,200],center=true);  // wire channel
        }
        hull() {
            translate([80,-1,-116]) cube([60,4,200],center=true);  // wire channel
            translate([80,-2.5,-113]) cube([60,4,200],center=true);  // wire channel
            translate([80,-5,-116]) cube([60,4,200],center=true);  // wire channel
        }
        if (CameraFeatures)
        {
        // camera pocket
        if (CamFlip) {
         translate([0,0,-(sqrt(((MntCylinderDia/2)*(MntCylinderDia/2))-16)-CamPCBThickness-CamLensHeight)]) rotate(a=90,v=[0,1,0]) CamPocket();
// camera flex cable entry
        translate([-18,0,-50]) cube([4,CamFlexWidth+0.5,100], center=true);
        }
        else
        {
         translate([0,0,-(sqrt(((MntCylinderDia/2)*(MntCylinderDia/2))-16)-CamPCBThickness-CamLensHeight)]) rotate(a=180,v=[0,0,1]) rotate(a=90,v=[0,1,0]) CamPocket();
// camera flex cable entry
        translate([18,0,-50]) cube([4,CamFlexWidth+0.5,100], center=true);
        }
        
        // Camera lens allignment notch
        translate([0,0,-(sqrt(((MntCylinderDia/2)*(MntCylinderDia/2))-16))-1.5]) cube([200,1,3],center=true);
    }
// battery cable channel
        translate([-59,0,MntCylinderDia/2+5.5]) cube([5,100,20], center=true);
// serial connector wire channel
            translate([24.848-62.5, -5,MntCylinderDia/2+4+50]) cube([2.2,8.4,17+100], center=true);  // Serial connector
        translate([0,3.5,-5.6]) cube([80,7,7],center=true);  //  cutaway so sliding cage together doesn't crush camera flat cable
// battery well
        hull()   // battery body
        {
        translate([-59,0.866*(MntCylinderDia-4.3)/2, 0.5*(MntCylinderDia-4.3)/2-1]) rotate( a=90, v=[0,1,0]) cylinder(d=4.2, h=31);
        translate([-59,0.866*(MntCylinderDia+1)/2, 0.5*(MntCylinderDia+1)/2-1]) rotate( a=90, v=[0,1,0]) cylinder(d=4.2, h=31);
        }
        hull()   // battery pin
        {
        translate([-65,0.866*(MntCylinderDia-4.3)/2, 0.5*(MntCylinderDia-4.3)/2-1]) rotate( a=90, v=[0,1,0]) cylinder(d=1.2, h=31);
        translate([-65,0.866*(MntCylinderDia+1)/2, 0.5*(MntCylinderDia+1)/2-1]) rotate( a=90, v=[0,1,0]) cylinder(d=1.2, h=31);
        }
       hull()   // battery wire path
        {
        translate([-61.5,0.866*(MntCylinderDia-4.3)/2, 0.5*(MntCylinderDia-4.3)/2]) rotate( a=90, v=[0,1,0]) cylinder(d=2.4, h=5.0);
        translate([-61.5,0,(MntCylinderDia+1)/2]) rotate( a=90, v=[0,1,0]) cylinder(d=2.4, h=5.0);
        }
        if (CameraFeatures)
        {
// opening for camera flex cable to wrap around end of Zero, this way the flex won't catch on the ledge.
        translate([26,-3,-9]) cube([23,6,5], center=true);
        }
    }
}



FullCage();
