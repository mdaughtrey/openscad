ViewScale = [0.0254, 0.0254, 0.0254];
include <model_rocker_switch.scad>

module model_metal()
{
    translate([-870, 0, 0])
    square([390, 280]);
    hull() {
        translate([-870+32, 0, 0])
        circle(64/2, $fn=96);
        circle(64/2, $fn=96);
    }

    rotate([0, 0, 45])
    hull() {
        circle(64/2, $fn=96);
        translate([364, 0, 0])
        circle(64/2, $fn=96);
    }
}

module cutout()
{
    c=80;
    translate([-870-16, 0, 0])
    square([390+32, 280+16]);
    hull() {
        translate([-870+32, 0, 0])
        circle(c/2, $fn=96);
        circle(c/2, $fn=96);
    }

    rotate([0, 0, 45])
    hull() {
        circle(c/2, $fn=96);
        translate([364+16, 0, 0])
        circle(c/2, $fn=96);
    }
}

module case()
{
    difference() {
        translate([100, 100, 0])
        square([1500, 500], center=true);
        translate([450, 0, 0])
        cutout();
    }
}

module onemount()
{
    linear_extrude(200)
    difference()
    {
        union() {
            circle(360/2, $fn=96);
            translate([0, -140, 0])
            square([360, 280], center=true);
          }
        circle(160/2, $fn=96);
    }
}

module switchcap()
{
    linear_extrude(600)
    difference() {
        translate([100, 100, 0])
        square([1500, 500], center=true);
        translate([450, 0, 0])
        cutout();
        translate([450, 150, 0])
        circle(200/2, $fn=96);
    }
    translate([0, 0, 599])
    linear_extrude(100)
    difference() {
    translate([100, 100, 0])
    square([1500, 500], center=true);
        translate([450, 150, 0])
        circle(200/2, $fn=96);
    }
    translate([0, 0, 99])
    // Mounts
    translate([1120, 100-50, 80])
    rotate([0, 90, -90]) onemount();

    translate([-930, 100-500/2, 180])
    rotate([0, 90, 90])
    onemount();
}

module endcap()
{
    linear_extrude(100)
    translate([100, 100, 0])
    square([1500, 500], center=true);
    translate([0, 0, 99])
    linear_extrude(600)
    difference() {
        translate([100, 100, 0])
        square([1500, 500], center=true);
        translate([450, 0, 0])
        cutout();
    }

    // Mounts
    translate([1120, 100-50, 180])
    rotate([0, 90, -90])
    onemount();

    translate([-930, 100-0-500/2, 180])
    rotate([0, 90, 90])
    onemount();
}

module switchbox()
{
    wall=100;
    outerX = 1500;
    outerY = 1200;
    linear_extrude(200)
    difference() {
        square([outerX, outerY], center=true);
        circle(800/2, $fn=96);
    }
    translate([0, 0, 199])
    linear_extrude(1000)
    difference() {
        square([outerX, outerY], center=true);
        square([outerX-wall, outerY-wall], center=true);
    }
    *color("cornflowerblue")
    model_rocker_switch();
}


module forViewing()
{
//    color("cornflowerblue")
//    translate([0, 1000, 200])
    switchcap();
    translate([100, 1540, 600])
    rotate([90, 0, 0])
    switchbox();
//    onemount();
//    translate([0, 600, 0])
//    endcap();
//    case();
//    color("blue")
//    translate([450, 0, 0])
//    model_metal();
}

module forPrinting()
{
    linear_extrude(200)
    difference() {
        translate([100, 100, 0])
        square([1500, 500], center=true);
        translate([450, 0, 0])
        cutout();
    }
}

scale(ViewScale)
{
//    forPrinting();
    forViewing();
}
