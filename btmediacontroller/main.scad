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
    square([pcb[1]+240, pcb[0]+240]);

    // Outer wall
    translate([0, 0, 49])
    linear_extrude(100)
    difference() {
        square([pcb[1]+240, pcb[0]+240]);
        translate([60, 60, 0])
        square([pcb[1]+120, pcb[0]+120]);
    }

    // Center support



    translate([120, pcb[0]+120, 500])
    rotate([0, 0, -90])
    model_esp32_wroom_dual_row();


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
