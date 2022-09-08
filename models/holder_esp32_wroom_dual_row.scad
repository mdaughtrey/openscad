ViewScale = [0.0254, 0.0254, 0.0254];

modelcolor = 1;
models = 1;

include <../models/apds9960.scad>
include <../models/model_esp32_wroom_dual_row.scad>
//include <../models/vl53l0x.scad>
include <../models/pushbutton.scad>
//include <../models/esp8266_d1_min.scad>
//include <../models/pushterminal.scad>
//include <../models/veroboard.scad>
//include <../models/levelshifter.scad>

include <sensorcarrier.scad>
include <scenclosure.scad>
include <lidarenclosure.scad>
include <esp8266Carrier.scad>

module esp32carrier()
{
    pcb = model_esp32_wroom_dual_row_pcb(); 

    // Base
    linear_extrude(50)
    square([pcb[1]+140, pcb[0]+140]);

    // Center support
    translate([pcb[1]/2-200,pcb[0]/2-250, 49])
    linear_extrude(201) 
    square([100, 500]);
    translate([pcb[1]/2+200,pcb[0]/2-250, 49])
    linear_extrude(201) 
    square([100, 500]);

    // Outer wall 0
    translate([0, 0, 49])
    linear_extrude(231)
    difference() {
        square([pcb[1]+140, pcb[0]+140]);
        translate([50, 50, 0])
        square([pcb[1]+40, pcb[0]+40]);
    }

    // Outer wall 1
    translate([0, 0, 279])
    linear_extrude(271)
    difference() {
        square([pcb[1]+140, pcb[0]+140]);
        translate([50, 50, 0])
        square([pcb[1]+40, pcb[0]+40]);

        // USB Connector
        translate([70, pcb[0]+130, 0])
        rotate([0, 0, -90]) {
            translate([-20, pcb[1]/2-335/2, 0])
            square([225, 335]);
        }
    }



    if (models) {
        translate([70, pcb[0]+70, 250])
        rotate([0, 0, -90])
        model_esp32_wroom_dual_row();
    }


}


module forViewing()
{
    esp32carrier();
//scWidth = 532;
//scHeight = 521;
    *translate([(532+240)/2, 0, (521+240)/2])
    rotate([0, 0, 180])
    rotate([90, 0, 0])
    {
        scEnclosure();
        sensorCarrier();
    }
}

module forPrinting()
{
    //sensorCarrier();
    scEnclosure();
}

scale(ViewScale)
{
    forViewing();
    //forPrinting();
}
