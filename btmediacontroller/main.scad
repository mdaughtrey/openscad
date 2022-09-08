ViewScale = [0.0254, 0.0254, 0.0254];

modelcolor = 1;
models = 0;

//include <../models/apds9960.scad>
include <../models/paj7620.scad>
include <../models/model_esp32_wroom_dual_row.scad>
include <../models/model_pcb_pushbuttons.scad>
//include <../models/vl53l0x.scad>
//include <../models/pushbutton.scad>
//include <../models/esp8266_d1_min.scad>
//include <../models/pushterminal.scad>
//include <../models/veroboard.scad>
//include <../models/levelshifter.scad>

include <sensorcarrier.scad>
include <scenclosure.scad>
//include <lidarenclosure.scad>
//include <esp8266Carrier.scad>

module esp32carrier()
{
    pcb = model_esp32_wroom_dual_row_pcb(); 

    // Base
    linear_extrude(50)
    difference() {
        square([pcb[1]+900, pcb[0]+140]);
        // APDS9660 
        //translate([1730, 60, 0])
        //square([120, 180]);
        // PAJ7629
        translate([1730, 120, 0])
        square([138, 223]);
        // Pushbutton
        *translate([1795, 1200, 0])
        circle(200/2, $fn=96);
        // Vents
        translate([650, 550, 0])
        hull() {
            circle(100/2);
            translate([0, 500, 0])
            circle(100/2);
        }
        translate([1050, 550, 0])
        hull() {
            circle(100/2);
            translate([0, 500, 0])
            circle(100/2);
        }
    }
    // ESP backstop
    translate([400, 49, 49])
    linear_extrude(101)
    square([1000, 30]);

    // Pushbutton mount 0
    *translate([1795, 1200, 49])
    linear_extrude(111)
    difference() {
        circle(300/2, $fn=96);
        circle(200/2, $fn=96);
    }

    // Pushbutton mount 1
    *translate([1795, 1200, 49])
    linear_extrude(110)
    intersection() {
        union() {
            translate([-200, -100, 0]) 
            square([400, 200]);
            translate([-50, -200, 0]) 
            square([100, 400]);
        }
        difference() {
            circle(348/2, $fn=96);
            circle(200/2, $fn=96);
            translate([-245/2, -245/2, 0])
            square([245,245]);
        }
    }


    // Screw mounts
//    color("red") {
        smheight = 230;
        translate([141, 141, 49]) linear_extrude(smheight) difference() { circle(180/2); circle(80/2); }
        translate([141, pcb[0], 49]) linear_extrude(smheight) difference() { circle(180/2); circle(80/2); }
        translate([2000, 740, 49]) linear_extrude(smheight) difference() { circle(180/2); circle(80/2); }
        translate([2000, pcb[0], 49]) linear_extrude(smheight) difference() { circle(180/2); circle(80/2); }
//    }

    // ESP supports
    translate([pcb[1]/2-200,pcb[0]/2-250, 49])
    linear_extrude(51) 
    square([100, 500]);
    translate([pcb[1]/2+200,pcb[0]/2-250, 49])
    linear_extrude(51) 
    square([100, 500]);
    translate([pcb[1]/2+600,pcb[0]/2-250, 49])
    linear_extrude(51) 
    square([100, 500]);

    // ESP Front
    translate([pcb[1]/2-180,pcb[0]/2+750, 49])
    linear_extrude(51) 
    square([800, 100]);
    // ESP Back
    translate([pcb[1]/2-180,pcb[0]/2-700, 49])
    linear_extrude(51) 
    square([800, 100]);

    // Side support
    translate([pcb[1]/2+850,pcb[0]/2-550, 49])
    linear_extrude(151) 
    square([50, 1000]);

    // APDS9960 support
    //translate([pcb[1]/2+900,pcb[0]/2-190, 49])
    //linear_extrude(151) 
    //square([600, 50]);

    // PAJ7620 support
    translate([pcb[1]/2+900,pcb[0]/2-155, 49])
    linear_extrude(151) 
    square([600, 50]);

    // Outer wall 0
    translate([0, 0, 49])
    linear_extrude(51)
    difference() {
        square([pcb[1]+900, pcb[0]+140]);
        translate([50, 50, 0])
        square([pcb[1]+800, pcb[0]+40]);
    }

    // Outer wall 1
    translate([0, 0, 99])
    linear_extrude(241)
    difference() {
        square([pcb[1]+900, pcb[0]+140]);
        translate([50, 50, 0])
        square([pcb[1]+800, pcb[0]+40]);

        // USB Connector
        translate([180, pcb[0]+130, 0])
        rotate([0, 0, -90]) {
            translate([-20, pcb[1]/2-335/2, 0])
            square([225, 435]);
        }
    }

    if (models) {
        translate([230, pcb[0]+70, 110])
        rotate([0, 0, -90])
        model_esp32_wroom_dual_row();
    }
}

module lid()
{
    pcb = model_esp32_wroom_dual_row_pcb(); 

    // Base
    linear_extrude(50)
    difference() {
        square([pcb[1]+900, pcb[0]+140]);
        // Screw holes
        smheight = 230;
        translate([140, 140, 49]) circle(160/2);
        translate([140, pcb[0], 49]) circle(160/2);
        translate([2000, 740, 49]) circle(160/2);
        translate([2000, pcb[0], 49]) circle(160/2);
        translate([400, 300, 0])
        hull() {
            circle(100/2, $fn=96);
            translate([1000, 0, 0])
            circle(100/2, $fn=96);
        }
        translate([400, 1300, 0])
        hull() {
            circle(100/2, $fn=96);
            translate([1000, 0, 0])
            circle(100/2, $fn=96);
        }
    }
    // Inner
    translate([0, 0, -49])
    linear_extrude(50)
    difference() {
        translate([60, 60, 0])
        square([pcb[1]+780, pcb[0]+20]);
        translate([260, 260, 0])
        square([pcb[1]+380, pcb[0]-380]);

        translate([141, 141, 49]) circle(100/2);
        translate([141, pcb[0], 49]) circle(100/2);
        translate([2000, 740, 49]) circle(100/2);
        translate([2000, pcb[0], 49]) circle(100/2);
    }
    // ESP standoff
    translate([0, 0, -59])
    linear_extrude(60)
    translate([750, 600, 0])
    square([200, 200]);


    // Pushbutton
    *translate([1795, 1200, -130])
    linear_extrude(131)
    difference() {
        circle(200/2, $fn=96);
        circle(100/2, $fn=96);
    }

    // APDS9660
    translate([pcb[1]+560, 50+521/2, -150])
    linear_extrude(150)
    difference() {
        circle(300/2, $fn=96);
        circle(200/2, $fn=96);
    }

}

module forViewing()
{
    pcb = model_esp32_wroom_dual_row_pcb(); 
    if(models) {
        *translate([pcb[1]+450, pcb[0]-200, 320])
        rotate([180, 0, 0]) {
            model_pushbutton_6_6_6pt5();
//            translate([235/2, 300/2, 250])
//            model_pushbutton_top();
        }
        translate([pcb[1]+570, 75+521/2, 113])
        rotate([180, 0, 0])
        //model_APDS9960();
        model_PAJ7620();
    }
    esp32carrier();
    *translate([0, 0, 340])
    lid();
}

module forPrinting()
{
//    esp32carrier();
    //translate([-2500, 1800, 0])
    rotate([180, 0, 0])
    lid();
}

scale(ViewScale)
{
    forViewing();
//    forPrinting();
}
