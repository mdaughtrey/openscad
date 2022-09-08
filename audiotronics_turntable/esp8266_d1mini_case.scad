ViewScale = [0.0254, 0.0254, 0.0254];
include <../models/esp8266_d1_min.scad>

modelcolor=1;
models=1;

pcbWidth = 1355;
pcbHeight = 1010;

module holder()
{
    linear_extrude(50)
    difference() {
        square([pcbWidth+600, pcbHeight+500]);
        translate([600, 300, 0])
        hull() {
            circle(100/2);
            translate([0, 800, 0])
            circle(100/2);
        }
//        translate([190, 90, 0])
//        square([pcbWidth-480, pcbHeight-40]);
    }

    // Wire cutout
    translate([0, 0, 49])
    linear_extrude(151)
    difference() {
        square([pcbWidth+600, pcbHeight+500]);
        translate([50, 50, 0])
        square([pcbWidth+500, pcbHeight+400]);
        translate([0, pcbHeight/2-150, 0])
        square([100, 200]);
    }

    // USB Cutout
    translate([0, 0, 199])
    linear_extrude(250)
    difference() {
        square([pcbWidth+600, pcbHeight+500]);
        translate([50, 50, 0])
        square([pcbWidth+500, pcbHeight+400]);
        translate([1900, pcbHeight/2+60, 0])
        square([100, 450]);
    }

    // Screw mounts
    translate([130, 130, 49]) linear_extrude(300) difference() { circle(180/2); circle(80/2); }
    translate([1825, 130, 49]) linear_extrude(300) difference() { circle(180/2); circle(80/2); }
    translate([1825, 1380, 49]) linear_extrude(300) difference() { circle(180/2); circle(80/2); }
    translate([130, 1380, 49]) linear_extrude(300) difference() { circle(180/2); circle(80/2); }

    // ESP Backstop
    translate([400,400,49])
    linear_extrude(250)
    square([100, 800]);

    // Module rails
    translate([850, 400, 49])
    linear_extrude(101)
    square([500, 100]);
    translate([850, 1000, 49])
    linear_extrude(101)
    square([500, 100]);

    *translate([0, 0, 49]) {
        linear_extrude(251)
        square([pcbWidth+240, 50]);
        linear_extrude(251)
        translate([0, pcbHeight+90, 0])
        square([pcbWidth+240, 50]);
    }

    // Right Wall
    // Front
    *translate([0, 0, 409])
    linear_extrude(50)
    square([pcbWidth+240, pcbHeight+140]);

    // Bottom
    *translate([pcbWidth+190, 0, 49])
    linear_extrude(311)
    square([50, pcbHeight+140]);

    // Screw mounts
    *translate([250, pcbHeight+140+500/2-1, 0])
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
    *translate([250, -500/2+1, 0])
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

module lid()
{
    linear_extrude(50)
    difference() {
        square([pcbWidth+600, pcbHeight+500]);
        for(ii=[300, 1200]) {
        translate([600, ii, 0])
            hull() {
                circle(100/2);
                translate([800, 0, 0])
                circle(100/2);
            }
        }
        translate([130, 130, 49]) circle(140/2);
        translate([1825, 130, 49]) circle(140/2); 
        translate([1825, 1380, 49]) circle(140/2);
        translate([130, 1380, 49])  circle(140/2);
    }

    // Inner
    translate([70, 70, -50])
    linear_extrude(51)
    difference() {
        square([pcbWidth+460, pcbHeight+360]);
        translate([150, 150, 0])
        square([pcbWidth+160, pcbHeight+60]);
        translate([60, 60, 49]) circle(100/2);
        translate([1755, 60, 49]) circle(100/2); 
        translate([1755, 1310, 49]) circle(100/2);
        translate([60, 1310, 49])  circle(100/2);
    }

    // ESP Support
    translate([700, 700, -170])
    linear_extrude(171)
    square([200, 200]);

    // USB Support
    translate([1750, 600, -80])
    linear_extrude(81)
    square([100, 300]);

}

module forViewing()
{
    translate([pcbWidth/2+530, (pcbHeight/2)+240, 250])
    rotate([180, 0, 0])
     model_esp9266_d1_min();
     holder();
     translate([0, 0, 450])
     lid();
}

module forPrinting()
{
//     holder();
    lid();
}

scale(ViewScale)
{
    //forViewing();
    forPrinting();
}
