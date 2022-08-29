ViewScale = [0.0254, 0.0254, 0.0254];

include <../models/model_ws2812strip.scad>

model_lip = function() [50,350];
modelcolor = 1;

module ws2812strip_insert()
{
    difference() {
        projection() {
            translate([473, 0, 0])
            rotate([0, 270, 90])
            scale([1.0, 1.1, 2.0])
            model_ws2812strip();
        }
    }
}

module ws2812clip()
{
    difference() {
        square([401, 200]);
        translate([0, 150, 0])
        rotate([0, 0, -90])
        square(model_lip());
    }
    translate([400, 0, 0])
    rotate([0, 0, 15])
    difference() {
        square([573, 120]);
        translate([75, 50, 0])
        scale([1.0, -1.0, 1.0])
        ws2812strip_insert();
        translate([80, 70, 0])
        square([400, 50]);
    }
}

//pcb 12 1/4
//box 12 7/8


module sideclip()
{
    linear_extrude(625/2-100)
    square([1000, 500]);
    translate([0, 0, 625/2-101])
    linear_extrude(200)
    difference() {
        square([1000, 500]);
        translate([0, 250-40, 0])
        square([1000, 80]);

    }

    // Screw mount
    translate([500, 750, 0])
    linear_extrude(100)
    difference() {
        hull() {
            circle(500/2);
            translate([-250, -500, 0])
            square([500, 500]);
        }
        circle(180/2);
    }

}

module forViewing()
{
//    model_ws2812strip();
//    ws2812clip();
    sideclip();
}

module forPrinting()
{
    linear_extrude(300)
    ws2812clip();
}

scale(ViewScale)
{
//    forPrinting();
    forViewing();
}
