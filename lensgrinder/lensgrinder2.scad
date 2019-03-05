ViewScale = [0.0254, 0.0254, 0.0254];
use <../libs/MCAD/involute_gears.scad>
//include "motorassbly.scad"
//include "gantry.scad"
//include "sungear.scad"
//include "planetgear.scad"
//include "rim.scad"
use <../lenses/proj2.scad>
geartranslate=1430;

module gearcircles (
	number_of_teeth=15,
	circular_pitch=false, //  diametral_pitch=false,
	pressure_angle=28,
	clearance = 0.2,
	gear_thickness=5,
	rim_thickness=8,
	rim_width=5,
	hub_thickness=10,
	hub_diameter=15,
	circles=0,
    circle_diameter=0)
{
    pi=3.1415926535897932384626433832795;

	// Pitch diameter: Diameter of pitch circle.
	pitch_diameter  =  number_of_teeth * circular_pitch / 180;
    echo("pitch_diameter ",pitch_diameter);
	pitch_radius = pitch_diameter/2;
	echo ("Teeth:", number_of_teeth, " Pitch radius:", pitch_radius);

	// Diametrial pitch: Number of teeth per unit length.
	pitch_diametrial = number_of_teeth / pitch_diameter;

	// Addendum: Radial distance from pitch circle to outside circle.
	addendum = 1/pitch_diametrial;

	//Outer Circle
	outer_radius = pitch_radius+addendum;

	// Dedendum: Radial distance from pitch circle to root diameter
	dedendum = addendum + clearance;

	// Root diameter: Diameter of bottom of tooth spaces.
	root_radius = pitch_radius-dedendum;

	// Variables controlling the rim.
	rim_radius = root_radius - rim_width;

	// Variables controlling the circular holes in the gear.
	circle_orbit_diameter=hub_diameter/2+rim_radius;
	circle_orbit_circumference=pi*circle_orbit_diameter;

	if (circles>0)
	{
		for(i=[0:circles-1]) {
			rotate([0,0,i*360/circles])
			translate([circle_orbit_diameter/2,0,0]) {
                //linear_extrude_flat_option(flat =flat, height=max(gear_thickness,rim_thickness)+3)
                circle(r=circle_diameter/2, $fn=96);
            }
        }
	}
}

// spinny gear that spins the lens
module planetgear()
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
    difference() {
        union() {
            gear(number_of_teeth=52,
                circular_pitch=6280,
                 gear_thickness=200,
                 rim_thickness=500,
                 rim_width=50,
                 bore_diameter = 280,
                 bore_sides = 6,
                 circle_diameter = 100,
                 circle_rim_inner_dia = 325,
                 circle_rim_thickness = 50,
                 circle_rim_height = 105,
                 circles=4);
            // bottom flange
            //translate([0, 0, -30])
            linear_extrude(30)
            difference(){
                circle(1050, $fn=96);
                circle(380/2, $fn=6);
            }
        }

        union() {
        linear_extrude(100)
        gearcircles(number_of_teeth=52,
            circular_pitch=6280,
            gear_thickness=200,
            rim_thickness=500,
            rim_width=50,
            bore_diameter = 380,
            bore_sides = 6,
            circle_diameter = 425,
            circle_rim_inner_dia = 325,
            circle_rim_thickness = 50,
            circle_rim_height = 105,
            circles=4);

        translate([0, 0, 100])
        linear_extrude(105)
        gearcircles(number_of_teeth=52,
            circular_pitch=6280,
            gear_thickness=200,
            rim_thickness=500,
            rim_width=50,
            bore_diameter = 380,
            bore_sides = 6,
            circle_diameter = 325,
            circle_rim_inner_dia = 325,
            circle_rim_thickness = 50,
            circle_rim_height = 105,
            circles=4);
        }
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
                translate([0, 1560, 0]) {
                    union() {
                        circle(200, $fn=96);
                        intersection() {
                            difference() {
                                circle(440, $fn=96);
                                circle(310, $fn=96);
                            }
                            union() {
                                square([800, 210], center=true);
                                square([210, 800], center=true);
                            } // union
                        } // intersection
                    } // union
                } // translate
            } // difference
        } // linear_extrude
    } // translate
    translate([0, 1560, 310]) 
    armshaft();

}

// sun gear shaft
module sunshaft()
{
    // level 0
    linear_extrude(105)
    difference() {
        union() {
        circle(500, $fn=96);
        gearcircles(number_of_teeth=52,
            circular_pitch=6280,
            gear_thickness=200,
            rim_thickness=500,
            rim_width=50,
            circle_diameter=535,
            circles=4);
        }
        gearcircles(number_of_teeth=52,
            circular_pitch=6280,
            gear_thickness=200,
            rim_thickness=500,
            rim_width=50,
            circle_diameter=435,
            circles=4);
        square(100, center=true);
        //circle(280/2, $fn=6);
    }

    // level 1
    translate([0, 0, 105])
    linear_extrude(105)
    difference() {
        union() {
        circle(500, $fn=96);
        gearcircles(number_of_teeth=52,
            circular_pitch=6280,
            gear_thickness=200,
            rim_thickness=500,
            rim_width=50,
            circle_diameter=535,
            circles=4);
        }
        gearcircles(number_of_teeth=52,
            circular_pitch=6280,
            gear_thickness=200,
            rim_thickness=500,
            rim_width=50,
            circle_diameter=325,
            circles=4);
        square(100, center=true);
        //circle(280/2, $fn=6);
    }

    // level 2
    translate([0, 0, 210])
    linear_extrude(100)
    difference() {
        circle(500, $fn=96);
        square(100, center=true);
    }

    // level 3
    translate([0, 0, 310])
    linear_extrude(100)
    difference() {
        circle(150, $fn=96);
        square(100, center=true);
    }


//    // hex insert
//    linear_extrude(200)
//    circle(370/2, $fn=6);
//
//    // lip thing
//    translate([0, 0, 200])
//    linear_extrude(310)
//    circle(500, $fn=96);
//
//    // main shaft
//    translate([0, 0, 200])
//    linear_extrude(1000)
//    circle(370/2, $fn=96);
//
//    // circles that overlap the sun gear 
//    translate([0, 0, 200])
//    shaftcircles();
}

module shaftcircles()
{
//    linear_extrude(110)
    difference() {
    gearcircles(number_of_teeth=52,
        circular_pitch=6280,
        gear_thickness=200,
        rim_thickness=500,
        rim_width=50,
        circle_diameter=535,
        circles=4);
    gearcircles(number_of_teeth=52,
        circular_pitch=6280,
        gear_thickness=200,
        rim_thickness=500,
        rim_width=50,
        circle_diameter=435,
        circles=4);
    }
}

// arm shaft
module armshaft()
{
    translate([0, 0, -100])
    linear_extrude(300)
    intersection() {
        difference() {
            circle(400, $fn=96);
            circle(320, $fn=96);
        }
        union() {
            square([800, 200], center=true);
            square([200, 800], center=true);
        }
    }
    
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
    translate([0, -geartranslate-300, 30]) {
//        lens_model();
        translate([0, 0, 120])
        planetgear();
//        translate([0, 0, 620])
//        planetarm();
    }
    
    translate([0, 0, 320]) {
    sungear();
    translate([0, 0, 1200])
    sunshaft();
    }
//    translate([0, 0, 1200]) 
//    sunshaft();
//    }
}
