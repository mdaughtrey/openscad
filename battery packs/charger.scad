use <lionpair.scad>
ViewScale = [0.0254, 0.0254, 0.0254];

module lowerShoe(ext)
{
    union(){
    // bottom layer
    linear_extrude(68)
    difference() {
        union() {
            translate([-250, 0, 0]) square([500, 1116], center=true);
            circle(558, $fn=96);
        }
        union() {
            translate([-350, 0, 0]) square([700, 1016], center=true);
            circle(508, $fn=96);
            translate([500, 0, 0]) square([150, 150], center=true);
        }
    }
    // top layer
    translate([0, 0, 68])
    linear_extrude(ext)
    difference() {
        union() {
            translate([-250, 0, 0]) square([500, 1116], center=true);
            circle(558, $fn=96);
        }
        union() {
            translate([-350, 0, 0]) square([700, 916], center=true);
            circle(458, $fn=96);
//            translate([500, 0, 0]) square([150, 150], center=true);
        }
    }}
}

module lower()
{
    translate([0, 0, 100]) lowerShoe(2650);
    linear_extrude(100)
    hull() {
        translate([-714, 0, 0]) circle(558, $fn=96);
        circle(558, $fn=96);
    }
    translate([0, 0, 0]) square(200, 300);
}

module boardCover()
{
}

module upper()
{
    rotate([180, 0, 0])
    {
        // shoe for charging board
//        translate([-435, 0, -300])
//        linear_extrude(225){
//            translate([0, -400, 0]) square([880, 50], center=true);
//            translate([0, 400, 0]) square([880, 50], center=true);
//
//            translate([465, 325, 0]) square([50, 200], center=true);
//            translate([-465, 325, 0]) square([50, 200], center=true);
//
//            translate([465, -325, 0]) square([50, 200], center=true);
//            translate([-465, -325, 0]) square([50, 200], center=true);
//
//        }
//        translate([-440, 0, -200])
//        linear_extrude(100)
//        square([880,780], center=true);

        lowerShoe(150);
        translate([0, 0, -100])
        linear_extrude(100)
        hull() {
            translate([-714, 0, 0]) circle(558, $fn=96);
            circle(558, $fn=96);
        }

        // sticky out bit for hinge
        translate([700, 0, -100])
        linear_extrude(300)
        union() {
            translate([0, 200, 0]) square([500, 200], center=true);
            translate([0, -200, 0]) square([500, 200], center=true);
        }

        // sticky out bit for catch
        translate([-1400, 0, 200])
        rotate([0, 180, 0])
        linear_extrude(300)
        union() {
            translate([0, 200, 0]) square([500, 200], center=true);
            translate([0, -200, 0]) square([500, 200], center=true);
        }
    }
}

module rib(hh)
{
    linear_extrude(hh)
    union() {
    difference() {
        hull() union() { circle(558, $fn=96); translate([714, 0, 0]) circle(558, $fn=96); }
        union() {
            hull() union() { circle(394, $fn=96); translate([714, 0, 0]) circle(394, $fn=96); }
            translate([-458, 0, 0]) square([200, 100], center=true);
        }
    }
    //translate([357, -608, 0]) square([200, 100], center=true);
    }
}


scale(ViewScale)
{
    translate([0, 0, 100]) bits();
    translate([0, 0, 3288]) upper();

    // the catch
//    translate([-1400, 0, 2500])
//    linear_extrude(190) 
//    union(){
//        square([700, 300]);
//        translate([-200, 0, 0]) square([200, 550]);
//        translate([0, 450]) polygon(points=[[0, 0],[100, 100], [0, 100]]);
//        linear_extrude(200) translate([-50, 0, 0]) square([450, 190], center=true);
//        translate([-100, 0, 200]) linear_extrude(700) square([300, 190], center=true);
//    }

    lower();
    // sticky out bit for the upper hinge
    translate([673, 0, 2600])
    union() {
        linear_extrude(200) translate([30, 0, 0]) square([500, 190], center=true);
        //linear_extrude(200) square([550, 190], center=true);
        translate([125, 0, 200]) linear_extrude(600) square([300, 190], center=true);
    }

    translate([0, 0, 750]) rotate([0, 0, 180]) rib(100);
    translate([0, 0, 1750]) rotate([0, 0, 180]) rib(100);
    translate([0, 0, 2750]) rotate([0, 0, 180]) rib(300);
    // spine that sticks out
    linear_extrude(2850) translate([-357, 608, 0]) square([280, 100], center=true);

    // spine that goes in
    linear_extrude(2850) translate([-57, -608, 0]) square([200, 100], center=true);
    linear_extrude(2850) translate([-557, -608, 0]) square([200, 100], center=true);
}

