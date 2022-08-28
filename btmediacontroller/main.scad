ViewScale = [0.0254, 0.0254, 0.0254];

modelcolor = 1;
models = 0;

include <../models/apds9960.scad>
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
        translate([1730, 130, 0])
        square([120, 200]);
        translate([1795, 1200, 0])
        circle(248/2, $fn=96);
    }

    // Pushbutton mount 0
    translate([1795, 1200, 59])
    linear_extrude(111)
    difference() {
        circle(348/2, $fn=96);
        circle(248/2, $fn=96);
    }

    // Pushbutton mount 1
    translate([1795, 1200, 169])
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
            circle(248/2, $fn=96);
        }
    }


    // Screw mounts
//    color("red") {
        smheight = 230;
        translate([140, 140, 49]) linear_extrude(smheight) difference() { circle(180/2); circle(80/2); }
        translate([140, pcb[0], 49]) linear_extrude(smheight) difference() { circle(180/2); circle(80/2); }
        translate([2000, 740, 49]) linear_extrude(smheight) difference() { circle(180/2); circle(80/2); }
        translate([2000, pcb[0], 49]) linear_extrude(smheight) difference() { circle(180/2); circle(80/2); }
//    }

    // Center support
    translate([pcb[1]/2-200,pcb[0]/2-250, 49])
    linear_extrude(51) 
    square([100, 500]);
    translate([pcb[1]/2+200,pcb[0]/2-250, 49])
    linear_extrude(51) 
    square([100, 500]);

    // Side support
    translate([pcb[1]/2+850,pcb[0]/2-550, 49])
    linear_extrude(151) 
    square([50, 1000]);

    // APDS9960 support
    translate([pcb[1]/2+900,pcb[0]/2-170, 49])
    linear_extrude(151) 
    square([600, 50]);

    // Outer wall 0
    translate([0, 0, 49])
    linear_extrude(50)
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
    }
    // Inner
    translate([0, 0, -49])
    linear_extrude(50)
    difference() {
        translate([60, 60, 0])
        square([pcb[1]+780, pcb[0]+20]);
        translate([260, 260, 0])
        square([pcb[1]+380, pcb[0]-380]);

        translate([140, 140, 49]) circle(100/2);
        translate([140, pcb[0], 49]) circle(100/2);
        translate([2000, 740, 49]) circle(100/2);
        translate([2000, pcb[0], 49]) circle(100/2);
    }
}

module forViewing()
{
    pcb = model_esp32_wroom_dual_row_pcb(); 
    if(models) {
        translate([pcb[1]+450, pcb[0]-200, 420])
        rotate([180, 0, 0]) {
            model_pushbutton_6_6_6pt5();
            translate([235/2, 300/2, 250])
            model_pushbutton_top();
        }
        translate([pcb[1]+560, 70+521/2, 113])
        rotate([180, 0, 0])
        model_APDS9960();
    }
    esp32carrier();
    translate([0, 0, 340])
    lid();
//scWidth = 532;
//scHeight = 521;
//    translate([pcb[1] + 90 + (532+240)/2, 0, (521+240)/2])
//    rotate([0, 0, 180])
//    rotate([90, 0, 0])
//    {
//        scEnclosure();
//        sensorCarrier();
//    }
}

module forPrinting()
{
//    esp32carrier();
    translate([-2500, 1800, 0])
    rotate([180, 0, 0])
    lid();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
