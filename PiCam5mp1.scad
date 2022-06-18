//  PiCam design
// written in OpenSCAD
//
// Written: 10/1/2017
//    Rev.: 0.01
//      By: Robert S. Rau
// Updated: 
//    Rev.: 
//      By: Robert S. Rau
// Changes: 
//
//
//
//
//  ToDo list
//
//
// Overall circle/sphere definition  development: set to 20, production: set to 120
//
$fn=20;

PCBThickness = 1.1;
CamSizeY = 25.6;
CamSizeZ = 24.2;
CamSensorHeight = 5.1;
CamLensOffsetZ = 2.5;
CamBotEleHeight=2.3-PCBThickness;  // expressed this way since it is the easiest way to measure
CamMountingHoleCCZ = 12.5;
CamMountingHoleCCY = 21;
CanConnectorZ = 6.6;

// mounting holes
module CamHoles() {
         translate([0,CamMountingHoleCCY/2.0,CamMountingHoleCCZ]) {
             rotate( a=90, v=[0,1,0]) { cylinder(d=1.8,h=PCBThickness*3,center=true); }
         }
         translate([0,-CamMountingHoleCCY/2.0,CamMountingHoleCCZ]) {
             rotate( a=90, v=[0,1,0]) { cylinder(d=1.8,h=PCBThickness*3,center=true); }
         }
         translate([0,CamMountingHoleCCY/2.0,0]) {
             rotate( a=90, v=[0,1,0]) { cylinder(d=1.8,h=PCBThickness*3,center=true); }
         }
         translate([0,-CamMountingHoleCCY/2.0,0]) {
             rotate( a=90, v=[0,1,0]) { cylinder(d=1.8,h=PCBThickness*3,center=true); }
         }
    
}



module CamPCB() {
    difference() {
    translate([PCBThickness/2.0,0,CamLensOffsetZ]) {
        cube([PCBThickness,CamSizeY,CamSizeZ], center=true);
    }
    CamHoles();
}
}




// bottom side electronics
module CamBotEle() {
     translate([-CamBotEleHeight/2.0,0,CamMountingHoleCCZ/2.0]) {
        cube([CamBotEleHeight,CamSizeY,7], center=true);
     }
     translate([-CamBotEleHeight/2.0,0,CamLensOffsetZ]) {
        cube([CamBotEleHeight,CamMountingHoleCCY-5,CamSizeZ], center=true);
     }  
    // connector 
     translate([-1.5,0,-CamSizeZ/2.0+CamLensOffsetZ+CanConnectorZ/2.0]) {
        cube([3,21,CanConnectorZ], center=true);
     }   
    // Flex 
     translate([-1.57,0,-CamSizeZ/2.0+CamLensOffsetZ-2.9]) {
        cube([0.4,16,7], center=true);
     }   
  }
    
    
    
    
    
    
// lens
  module CamLens() {
           translate([PCBThickness+2.5,0,0]) {
        cube([5,9,9], center=true);
     }
 }

module CamAll() {
    CamPCB();
    CamBotEle();
    CamLens();
}

CamAll();