use <lionpair.scad>
ViewScale = [0.0254, 0.0254, 0.0254];

module lowerShoe()
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
        }
    }
    // top layer
    translate([0, 0, 68])
    linear_extrude(2650)
    difference() {
        union() {
            translate([-250, 0, 0]) square([500, 1116], center=true);
            circle(558, $fn=96);
        }
        union() {
            translate([-350, 0, 0]) square([700, 916], center=true);
            circle(458, $fn=96);
        }
    }}
}

module lower()
{
    translate([0, 0, 100]) lowerShoe();
    linear_extrude(100)
    hull() {
        translate([-714, 0, 0]) circle(558, $fn=96);
        circle(558, $fn=96);
    }
}

module rib(hh)
{
    linear_extrude(hh)
    union() {
    difference() {
        hull() union() { circle(558, $fn=96); translate([714, 0, 0]) circle(558, $fn=96); }
        union() {
            hull() union() { circle(374, $fn=96); translate([714, 0, 0]) circle(374, $fn=96); }
//            translate([357, 508, 0]) square([200, 100], center=true);
        }
    }
    //translate([357, -608, 0]) square([200, 100], center=true);
    }
}


scale(ViewScale)
{
    *translate([0, 0, 100]) bits();
    lower();
    translate([0, 0, 750]) rotate([0, 0, 180]) rib(100);
    translate([0, 0, 1750]) rotate([0, 0, 180]) rib(100);
    translate([0, 0, 2750]) rotate([0, 0, 180]) rib(300);
    // spine that sticks out
    linear_extrude(2850) translate([-357, 608, 0]) square([400, 100], center=true);

    linear_extrude(2850) translate([-57, -608, 0]) square([200, 100], center=true);
    linear_extrude(2850) translate([-557, -608, 0]) square([200, 100], center=true);
}

