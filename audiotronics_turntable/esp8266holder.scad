ViewScale = [0.0254, 0.0254, 0.0254];
include <../models/esp8266_d1_min.scad>

modelcolor=1;
models=1;

pcbWidth = 1355;
pcbHeight = 1010;

module holder()
{
    linear_extrude(100)
    difference() {
        square([pcbWidth+120, pcbHeight+140]);
        translate([190, 90, 0])
        square([pcbWidth-480, pcbHeight-40]);
    }

    translate([0, 0, 99]) {
        linear_extrude(251)
        square([pcbWidth+120, 50]);
        linear_extrude(251)
        translate([0, pcbHeight+90, 0])
        square([pcbWidth+120, 50]);
    }

    // Front
    translate([0, 0, 409])
    linear_extrude(50)
    translate([0, pcbHeight/2+120/2-300])
    square([pcbWidth+120, 600]);

    // End
    translate([pcbWidth+70, 0, 99])
    linear_extrude(311)
    square([50, pcbHeight+140]);

    // Screw mounts
    translate([250, pcbHeight+140+500/2-1, 0])
    linear_extrude(100)
    difference() {
        hull() {
            circle(500/2);
            translate([-250, -300, 0])
            square([500, 300]);
        }
        circle(180/2);
    }
    // Screw mount
    translate([250, -500/2+1, 0])
    linear_extrude(100)
    difference() {
        hull() {
            circle(500/2);
            translate([-250, 300, 0])
            square([500, 300]);
        }
        circle(180/2);
    }


//    difference() {
//
//        square([pcbWidth+120, pcbHeight+140]);
//        translate([0, pcbHeight/2-550/2, 0])
//        square([pcbWidth+120, 550]);
//    }
}

module forViewing()
{
    translate([pcbWidth/2, (pcbHeight/2)+70, 200])
     model_esp9266_d1_min();
     holder();
}

module forPrinting()
{
     holder();
}

scale(ViewScale)
{
    //forViewing()
    forPrinting();
}
