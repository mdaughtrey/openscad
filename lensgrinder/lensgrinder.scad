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
//geartranslate=1430;
geartranslate=1450;

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
	    gear_thickness=280,
	    rim_thickness=460,
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
                    circle(1000, $fn=96);
                }
                // center hole
                translate([0, geartranslate, 0]) {
                    circle(900/2, $fn=96);
                } // translate
            } // difference
        } // linear_extrude
    } // translate

    // collar protrudes into sungear
    translate([0, geartranslate, -149])
    linear_extrude(350)
    difference() {
        circle(1620/2, $fn=96);
        circle(1520/2, $fn=96);
    }

    // arm gear
    translate([0, geartranslate, 210+armthickness])
    gear(number_of_teeth=35,
        circular_pitch=6280,
         gear_thickness=50,
         rim_thickness=300,
         rim_width=50,
         bore_diameter = 900,
         bore_sides = 96,
         circle_diameter = 100);

    *translate([0, geartranslate, 210])
    linear_extrude(armthickness)
    difference() {
        circle(250, $fn=6);
        circle(300/2, $fn=96);
    }
}

// sun gear shaft
module sunshaft()
{
    // layer 0 - ring around the hub
    linear_extrude(210)
    difference() {
        circle(500, $fn=96);
        circle(410, $fn=96);
    }
    // layer 1 - hub cab
    translate([0, 0, 210])
    linear_extrude(190)
    difference() {
        circle(500, $fn=96);
        //circle(280/2, $fn=96);
        circle(520/2, $fn=6);
    }
    //circle(205, $fn=6);
    // layer 2 - hex hole big enough for nut to slide through
    translate([0, 0, 400])
    linear_extrude(200) {
        difference() {
            square(600, center=true);
           // circle(300/2, $fn=96);
            circle(520/2, $fn=6);
        }
    }
    // layer 3 - nut capture
    translate([0, 0, 600])
    linear_extrude(250) {
        difference() {
            square(600, center=true);
           // circle(300/2, $fn=96);
            circle(506/2, $fn=6);
        }
    }
    // layer 4 - shaft cavity
    translate([0, 0, 850])
    linear_extrude(1000) {
        difference() {
            square(600, center=true);
            circle(300/2, $fn=96);
        }
    }
    // layer 5 - cap
    translate([0, 0, 1850])
    linear_extrude(100) {
        difference() {
            square(600, center=true);
            circle(95/2, $fn=96);
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
    linear_extrude(105) {
        difference() {
            circle(base_r, $fn=96);
            circle(base_r-100, $fn=96);
            //circle(470/2, $fn=96);
        }
        for (ii = [0:90:360])
        {
            rotate([0, 0, ii])
            translate([600, 0, 0])
            circle(355/2, $fn=96);
        }
        difference() {
            circle(570/2, $fn=96);
            circle(470/2, $fn=96);
        }
    }
    translate([0, 0, 210])
    linear_extrude(100) {
        difference() {
            circle(base_r, $fn=96);
            circle(base_r-100, $fn=96);
            //circle(470/2, $fn=96);
        }
        difference() {
            circle(570/2, $fn=96);
            circle(250/2, $fn=96);
        }
    }

//    difference() {
//        circle(base_r, $fn=96);
//        circle(250/2, $fn=96);
//    }

}

module motorgear()
{
    // arm gear
    rotate([180, 0, 0])
    gear(number_of_teeth=22,
        circular_pitch=6280,
         gear_thickness=200,
         rim_thickness=300,
         rim_width=50,
         bore_diameter = 320,
         bore_sides = 6,
         circle_diameter = 100);
}

module housingcoupling0(cdia)
{
    linear_extrude(200)
    difference() {
        circle(500, $fn=96);
        square(630, center=true);
    }

    translate([0, 0, 200])
    linear_extrude(1130)
    difference()
    {
        square(720, center=true);
        square(620, center=true);
    }
//    clearance = 25;
//    difference() {
//        hull() {
//            square(540, center=true);
//            translate([0, 770, 0])
//            circle((784+clearance)/2, $fn=96);
//        }
//        square(440, center=true);
//        translate([0, 770, 0])
//        circle(cdia, $fn=96);
//    }
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
//    clearance = 25;
//    linear_extrude(200)
//    housingcoupling0((584+clearance)/2);
        linear_extrude(200)
        difference() {
            circle(500, $fn=96);
            square(630, center=true);
        }

        translate([0, 0, 200])
        linear_extrude(1130)
        difference()
        {
            square(720, center=true);
            square(630, center=true);
        }
        translate([0, 0, 1329])
        linear_extrude(50)
        difference() {
            square(720, center=true);
            circle(100/2, $fn=96);
        }
    translate([0, 1000, 1400]) {
        rotate([180, 0, 0]) {
            motorhousing();
          //  model_geared2();
        }
    }
    translate([300, 820, 335]) 
    linear_extrude(370)
    square([120, 955], center=true);
    translate([-300, 820, 335]) 
    linear_extrude(370)
    square([120, 955], center=true);

    

//    translate([0, 0, 200])
//    linear_extrude(350)
//    difference() {
//        square(540, center=true);
//        square(440, center=true);
//    }
//
//    translate([0, 0, 550])
//    linear_extrude(100)
//    housingcoupling0((584+clearance)/2);
//
//    translate([0, 0, 650])
//    linear_extrude(50)
//    housingcoupling1();
}

module armgearfitter()
{
    linear_extrude(200)
    difference() {
        circle(880/2, $fn=96);
        translate([250+50, 250+50, 0])
        square(500, center=true);
        translate([-250-50, 250+50, 0])
        square(500, center=true);
        translate([+250+50, -250-50, 0])
        square(500, center=true);
        translate([-250-50, -250-50, 0])
        square(500, center=true);
    }
}

module motorgearinsert()
{
    clearance = 10;
    linear_extrude(200)
    difference() {
        circle((320 - clearance)/2, $fn=6);
        difference() {
            circle(118/2+clearance, $fn=96);
            translate([0, 25+118/2-20+clearance-10, 0])
            square([120, 50], center=true);
        }
    }
    translate([0, 0, 199])
    linear_extrude(100)
    difference() {
        circle(280, $fn=96);
        difference() {
            circle(118/2+clearance, $fn=96);
            translate([0, 25+118/2-20+clearance-10, 0])
            square([120, 50], center=true);
        }
    }
}

module sunflange()
{
    linear_extrude(100)
    difference() {
        circle(500, $fn=96);
        square(630, center=true);
    }
}


scale(ViewScale)
{
//    base();
//    translate([0, 0, 500]) {
//        sungear();
//        translate([0, 0, 100])
//        sunshaft();
//        translate([0, -geartranslate, -180]) {
//            planetgear();
//        }
//        translate([0, 0, 820])
//        sunflange();
//        translate([0, 0, 720])
        housingcoupling();
//        translate([0, -geartranslate, 310])
//        {
//            %planetarm();
//            translate([0, geartranslate+1000, 310+300]) {
//            motorgear();
//            rotate([180, 0, 0])
//            motorgearinsert();
//            }
//        }
//
//    }
//    *translate([0, 770, 2550])
//    rotate([180, 0, 0]) {
//        motorhousing();
//        model_geared2();
//    }
//    translate([0, 0, 2400])
//    armgearfitter();
//    motorshaftcutout();
}
