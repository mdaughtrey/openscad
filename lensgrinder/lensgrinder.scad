ViewScale = [0.0254, 0.0254, 0.0254];
use <../libs/MCAD/involute_gears.scad>
//include "motorassbly.scad"
//include "gantry.scad"
//include "sungear.scad"
//include "planetgear.scad"
//include "rim.scad"
use <../lenses/proj2.scad>
use <../strandbeast/geared2/housing.scad>
use <../strandbeast/geared2/model_geared2.scad>
geartranslate=1430;

// spinny gear that spins the lens
module planetgear()
{
    translate([0, 0, 10])
    linear_extrude(200)
    difference() {
    circle(350, $fn=96);
    circle(205, $fn=6);
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
    union() {
        gear(number_of_teeth=52,
            circular_pitch=6280,
             gear_thickness=100,
             rim_thickness=500,
             rim_width=50,
             bore_diameter = 270,
             bore_sides = 96,
             circle_diameter = 100);
        // bottom flange
        //translate([0, 0, -30])
        linear_extrude(30)
        difference(){
            circle(1050, $fn=96);
            circle(380/2, $fn=6);
        }
    }
    translate([0, 0, 100])
    linear_extrude(210)
    difference() {
        circle(400, $fn=96);
        circle(506/2, $fn=6);
    }
}

// arm that moves the lens interface around
module planetarm()
{
    armthickness=100;
    // fits into lens interface gear
    linear_extrude(210)
    circle(420, $fn=96);

    // shaft into gear
    translate([0, 0, -250])
    linear_extrude(250)
    circle(100, $fn=96);

    // upper flange
    translate([0, 0, 210])
    linear_extrude(armthickness)
    circle(700, $fn=96);

    // arm and shaft cutout
    translate([0, 0, 210]) {
        linear_extrude(armthickness) {
            difference() {
                hull() {
                    circle(400);
                    translate([0, geartranslate, 0])
                    circle(1000);
                }
                // center hole
                translate([0, geartranslate, 0]) {
                    circle(415/2, $fn=96);
                } // translate
            } // difference
        } // linear_extrude
    } // translate
    // arm gear
    translate([0, geartranslate, 210+armthickness])
    gear(number_of_teeth=22,
        circular_pitch=6280,
         gear_thickness=50,
         rim_thickness=300,
         rim_width=50,
         bore_diameter = 270,
         bore_sides = 96,
         circle_diameter = 100);
}

// sun gear shaft
module sunshaft()
{
    // layer 0
    linear_extrude(210)
    difference() {
        circle(500, $fn=96);
        circle(405, $fn=96);
    }
    // layer 1
    translate([0, 0, 210])
    linear_extrude(190)
    difference() {
        circle(500, $fn=96);
        circle(280/2, $fn=96);
    }
    // layer 2
    translate([0, 0, 400])
    linear_extrude(1450) {
        difference() {
            square(420, center=true);
            circle(300/2, $fn=96);
            //circle(280/2, $fn=96);
        }
    }
    // layer 3
    translate([0, 0, 1850])
    linear_extrude(50) {
        difference() {
            square(420, center=true);
            circle(95/2, $fn=96);
            //circle(280/2, $fn=96);
        }
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

module base()
{
    base_r = 850;
    // level 0
    linear_extrude(105)
    difference() {
        circle(base_r, $fn=96);
        circle(470/2, $fn=96);
        for (ii = [0:90:360])
        {
            rotate([0, 0, ii])
            translate([600, 0, 0])
            circle(335/2, $fn=96);
        }
    }
    // level 1
    translate([0, 0, 105])
    linear_extrude(105)
    difference() {
        circle(base_r, $fn=96);
        circle(470/2, $fn=96);
    }
    translate([0, 0, 210])
    linear_extrude(100)
    difference() {
        circle(base_r, $fn=96);
        circle(250/2, $fn=96);
    }

}

module motorgear()
{
    // arm gear
    translate([0, geartranslate+770, 310+330])
    rotate([180, 0, 0])
    gear(number_of_teeth=22,
        circular_pitch=6280,
         gear_thickness=200,
         rim_thickness=300,
         rim_width=50,
         bore_diameter = 270,
         bore_sides = 96,
         circle_diameter = 100);
}

module housingcoupling0(cdia)
{
    clearance = 25;
    difference() {
        hull() {
            square(540, center=true);
            translate([0, 770, 0])
            circle((784+clearance)/2, $fn=96);
        }
        square(440, center=true);
        translate([0, 770, 0])
        circle(cdia, $fn=96);
    }
}

module housingcoupling1()
{
    clearance = 25;
    difference() {
        hull() {
            square(540, center=true);
            translate([0, 770, 0])
            circle((784+clearance)/2, $fn=96);
        }
        circle(120/2, $fn=96);
        translate([0, 770, 0])
        circle((584+clearance)/2, $fn=96);
    }
}

module housingcoupling()
{
    clearance = 25;
    linear_extrude(200)
    housingcoupling0((584+clearance)/2);

    translate([0, 0, 200])
    linear_extrude(350)
    difference() {
        square(540, center=true);
        square(440, center=true);
    }

    translate([0, 0, 550])
    linear_extrude(100)
    housingcoupling0((584+clearance)/2);

    translate([0, 0, 650])
    linear_extrude(50)
    housingcoupling1();
}
TODO rim on gear


scale(ViewScale)
{
    base();
    translate([0, 0, 500]) {
        sungear();
        translate([0, 0, 100])
        sunshaft();
        translate([0, -geartranslate, -180]) 
        planetgear();
        translate([0, -geartranslate, 310])
        !planetarm();
        translate([0, -geartranslate, 310])
        motorgear();

    }
    translate([0, 770, 2550])
    rotate([180, 0, 0]) {
        motorhousing();
        model_geared2();
    }
    translate([0, 0, 1900])
    housingcoupling();
}
