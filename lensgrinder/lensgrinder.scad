ViewScale = [0.0254, 0.0254, 0.0254];
use <../libs/MCAD/involute_gears.scad>
//include "motorassbly.scad"
//include "gantry.scad"
//include "sungear.scad"
//include "planetgear.scad"
//include "rim.scad"
use <../lenses/proj2.scad>


// spinny gear that spins the lens
module lensinterface()
{
    translate([0, 0, 10])
    linear_extrude(200)
    difference() {
    circle(250, $fn=96);
    circle(105, $fn=6);
    }

    translate([0, 0, 210])
    gear(number_of_teeth=31,
        circular_pitch=6000,
	    gear_thickness=300,
	    rim_thickness=480,
        rim_width=50,
        bore_diameter = 210,
        bore_sides=96,
        circles=8);

}
 
// big gear in the middle
module sungear()
{
    gear(number_of_teeth=62,
        circular_pitch=6000,
	    gear_thickness=200,
	    rim_thickness=500,
        rim_width=50,
        bore_diameter = 380,
        bore_sides = 6,
        circles=8);
    // bottom flange
    translate([0, 0, -50])
    linear_extrude(50)
    difference(){
    circle(1300, $fn=96);
    circle(380/2, $fn=6);
    }
}

// arm that moves the lens interface around
module planetarm()
{
    // fits into lens interface gear
    linear_extrude(210)
    circle(420, $fn=96);

    // shaft into gear
    translate([0, 0, -180])
    linear_extrude(180)
    circle(100, $fn=96);

    // upper flange
    translate([0, 0, 210])
    linear_extrude(100)
    circle(700, $fn=96);

    // arm and shaft cutout
    translate([0, 0, 210]) {
    linear_extrude(100) {
    difference() {
    hull() {
        circle(400);
        translate([0, 1560, 0])
        circle(400);
    }
        // center hole
        translate([0, 1560, 0])
        circle(200, $fn=96);
    }}}

}

// sun gear shaft
module sunshaft()
{
    // hex insert
    linear_extrude(200)
    circle(370/2, $fn=6);

    // lip thing
    translate([0, 0, 200])
    linear_extrude(310)
    circle(500, $fn=96);

    // main shaft
    translate([0, 0, 200])
    linear_extrude(1000)
    circle(370/2, $fn=96);
}

// arm shaft
module armshaft()
{
    // outer shaft sleeve
    translate([0, 0, 0])
    linear_extrude(500)
    difference() {
        circle(320, $fn=96);
        circle(200, $fn=96);
    }
}

scale(ViewScale)
{
    translate([0, -1560, 0]) {
        lens_model();
        translate([0, 0, 120])
        lensinterface();
        translate([0, 0, 620])
        planetarm();
    }
    
    translate([0, 0, 320]) {
    sungear();
    sunshaft();
    translate([0, 0, 600]) 
    armshaft();
    }
}
