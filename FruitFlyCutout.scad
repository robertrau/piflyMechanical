//  Model of space required for PyFly HAT board.
//  Coordinate system referenced to Osmand PCB layout coordinates. The Z zero is the board top, layer 1, for module PyFlyBoardNoHoles.
//  There is a Z coordinate shift in module PyFlyBoard.
//
// Written: 9/10/2017
//    Rev.: 0.01
//      By: Robert S. Rau
//
// Updated: 11/18/2017
//    Rev.: 0.02
//      By: Robert S. Rau
// Changes: Reliefs for SMT parts near board edge. Fixed USB connector shield pin relief.
//
//
//
// set up global rendering parameters
$fn=36;
// PCB
//

// PCB
PCBThickness = 1.65;
PyFlyZoffset = 0.5;


module PyFlyLEDCone(Xpos,Ypos,Col)    // Places a spot at test pad point, coloured to show pad function
{
    translate([Xpos,Ypos,PiSizeZ/4]) {
        color(Col);
        rotate( a=180, v=[1,0,0]) cylinder(h=60,r1=1.2,r2=8,center=false);
    }
}


module PyFlyButtonCone(Xpos,Ypos,Col)    // Places a spot at test pad point, coloured to show pad function
{
    translate([Xpos,Ypos,PiSizeZ/4]) {
        color(Col);
        rotate( a=180, v=[1,0,0]) cylinder(h=60,r1=.7,r2=10,center=false);
    }
}



module PyFlyBoardNoHoles() {
    translate([-0.25,-0.25,0]) cube([150.5,29.75,PCBThickness]);  //PCB  0.5mm oversize slot
    
            // shape to make card guide champhers
        hull()
        {
            translate([-0.25,-0.25+5,0]) cube([150.5, 29.75-10, PCBThickness]);
            translate([-0.25,-0.25+6,-1]) cube([150.5, 29.75-12, PCBThickness+2]);
        }

    hull() {
        translate([-1,15,(PCBThickness-1.4 )]) rotate(a=90, v=[0,1,0]) cylinder(d=17.5,h=(200),    center=false);   //wiring channel (opening down the center, above and below the boards)
        translate([-1,15,(PCBThickness + 2.39)]) rotate(a=90, v=[0,1,0]) cylinder(d=17.5,h=(200),    center=false);   //wiring channel 2
    }
    translate([62.5,15,(PCBThickness - 0.1)-3.2]) cube([53,30,4], center=true);               // Space between Zero and PyFly
    translate([0,-4,(PCBThickness - 0.1)-3.2]) cube([24,12.7,25]);               // Servo connectors
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
    translate([62.23, 26.4,(PCBThickness - 0.1)-2]) cube([52,5.2,6.5], center=true);  // Pi connector
    translate([152, 8.57,PCBThickness-4.5]) cube([15.5,13.5,9], center=true);  //USB connector
    translate([147.77, 8.57,PCBThickness+1.0]) cube([4,14.9,5.9], center=true);  //USB connector pins
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
    translate([99.61, 5.73,PCBThickness+2.5]) cube([5.1,8,5], center=true);  // Interrupt jumpers
    translate([115, 12.7,PCBThickness+2.5]) cube([17,10,90], center=true);  // Deans Power connector
    translate([115, 16.5,PCBThickness-10]) cube([15,9.5,11], center=true);  // Deans Power connector insertion well
    translate([76.5, 7,PCBThickness+0.5]) cube([24,10,4], center=true);  // parts
    translate([76.5, 7,PCBThickness+0.5]) cube([24,10,4], center=true);  // parts
    hull()
    {
        translate([11.8872, 20.3484,PCBThickness-7.2]) cylinder(d=12,h=8, center=true);  // Super capacitor
        translate([11.8872, 14.3484,PCBThickness-7.2]) cylinder(d=12,h=8, center=true);  // Super capacitor
    }
    translate([57, 9,PCBThickness+0.5]) cube([21,10,4], center=true);  // parts
    translate([15.4, 5,PCBThickness-0.8]) cube([30.6,10,5], center=true);  // parts
    translate([122.25, 6,PCBThickness-0.8]) cube([55.5,10,5], center=true);  // parts
    translate([0,3,PyFlyZoffset-3]) cube([19,23,3], center=false);  // parts    GPS LEDs resistors
    translate([114,17,PyFlyZoffset-3]) cube([14,29.25-17,4], center=false);  // parts    High side driver
    translate([93.5,16,PyFlyZoffset-2]) cube([14.5,29.25-17,2], center=false);  // parts    High side driver control logic**
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
    translate([111,26,0])cylinder(d=6,h=PCBThickness*20.1,center=true);
}




module PyFlyBoard() {
    translate([-62.5,-15,PyFlyZoffset]) difference () {
        PyFlyBoardNoHoles();
        USBWireCutout();
        //MountingHoles();
    }
}

PyFlyBoard();