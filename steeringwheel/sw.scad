ViewScale = [0.0254, 0.0254, 0.0254];

use <../libraries/OpenSCAD bottle threads/thread_profile.scad>
include <model_encoder.scad>
include <model_stepper.scad>
include <model_steeringshaft.scad>
include <maingear.scad>
include <shaftgear.scad>
include <innerscrew.scad>


model = 1;

module case()
{
}

module mainShaft()
{
    proto = 0;
    th = 100-10;
    tw = 200-10;
    straight_thread(
        section_profile = [[0,0], [th, tw/2-10], [th, tw/2+10], [0, tw]], // ,  [0, tw]],
        higbee_arc = 20,
        r = 565/2,
        turns = 7,
        pitch = 200,
        fn=96);
    difference() {
        linear_extrude(proto ? 1800 : 3000)
        difference() {
            circle(567/2, $fn=96);
            intersection() {
                circle(212/2, $fn=96);
                translate([20, 0, 0])
                square([212, 212], center=true);
            }
//            circle(100/2, $fn=96);
        }

        // End slot cutout
        if (!proto) {
            translate([0, 0, 2400])
            rotate([0, -90, 0])
            translate([0, 0, -500])
            linear_extrude(1000)
            hull() {
                translate([180/2, 0, 0])
                circle(180/2, $fn=96);
                translate([800, 0, 0])
                square([180, 180], center=true);
            }
        }
        // Bolt Hole
        //translate([-1000, 0, 2500])
        if (!proto) {
            translate([0, 0, -1])
            linear_extrude(3000)
            intersection() {
                circle(188/2, $fn=96);
                translate([20, 0, 0])
                square([188, 188], center=true);
            }
        }
    }

}

module traveler()
{
    proto = 0;
    th = 100-10;
    tw = 200-10;
    straight_thread(
        section_profile = [[0,0], [-th, tw/2-10], [-th, tw/2+10], [0, tw]], // ,  [0, tw]],
        higbee_arc = 20,
        r = 785/2,
        turns = 2,
        pitch = 200,
        fn=96);


	translate([0, 0, 0])
	linear_extrude(600)
	difference() {
        if (proto) {
            circle(900/2, $fn=96);
        }
        else {
            union() {
                circle(900/2, $fn=96);
                square([2300, 200], center=true);
            }
        }
		circle(765/2, $fn=96);
	}
}

module travelTracks()
{
	for(ii = [0,180]) {
		rotate([0, 0, ii])
		translate([1200, 0, 0])
		linear_extrude(1500)
		difference() {
			square([400, 400], center=true);
			translate([-110, 0, 0])
			square([200, 200], center=true);
		}
	}
}

module mainMount(thick)
{
    proto=0;
    x = 1660;
    x0 = -610;
    x1 = 610;
    
    y0 = -(1400/2)-450;
    y1 = (1400/2)+450;

	linear_extrude(thick)
	difference() {
        if (proto) {
		    square([1500, 1500], center=true);
        } else {
		    translate([820, 0, 0])
    		square([3400+220, 2800], center=true);
        }
		circle(890/2, $fn=96);
        if (!proto) {
            translate([1700, 0, 0])
            {
                circle(20+785/2, $fn=96);
                for (ii = [0:120:360])
                {
                    rotate([0, 0, ii])
                    translate([546, 0, 0])
                    circle(130/2, $fn=96);
                }
            }
            for (ii = [x0, x1]) {
                for (jj = [y0, y1]) {
                    translate([ii, jj, 0])
                    circle(170/2, $fn=96);
                }
            }
        }
        for (ii = [x0, x1]) {
            for (jj = [x0, x1]) {
                translate([ii, jj, 0])
                circle(120/2, $fn=96);
            }
        }
	}
    // Bolt head surrounds
    translate([0, 0, thick-1])
    linear_extrude(150)
    for (ii = [x0, x1]) {
        for (jj = [x0, x1]) {
            translate([ii, jj, 0])
            difference() {
                circle(420/2, $fn=96);
                circle(220/2, $fn=96);
            }
        }
    }

    //translate([-850/2, 2000-400, 2000])
    //rotate([0, 90, 0])
    //linear_extrude(850)
    //difference() {
    //    circle(3000, $fn=96);
    //    circle(3000-470, $fn=96);
   // }
}

module shaftMount()
{
    x = 1660;
    x0 = -610;
    x1 = 610;

    // Fastener tabs
    linear_extrude(200)
    translate([0, -(1400/2)-450, 0])
    difference()
    {
        hull() {
            translate([-x0, 0, 0])
            circle(470/2, $fn=96);
            translate([x0, 0, 0])
            circle(470/2, $fn=96);
        }
        translate([-x0, 0, 0])
        circle(170/2, $fn=96);
        translate([x0, 0, 0])
        circle(170/2, $fn=96);
	    translate([0, 470/2-100+1, 0])
		square([200, 200], center=true);
    }

    // Vertical riser
    translate([0, 0, 199])
    linear_extrude(1801)
    translate([0, -(1400/2)-450, 0])
    difference() {
    //    translate([0, -(1400/2)-450, 0])
        square([850, 470], center=true);
        translate([-x0, -(1400/2)-450, 0])
        circle(470/2, $fn=96);
        translate([x0, -(1400/2)-450, 0])
        circle(470/2, $fn=96);
	    translate([0, 470/2-100+1, 0])
		square([200, 200], center=true);
    }

    // Traveler bridge top
    translate([0, -(1400/2)-450, 1999])
    linear_extrude(200)
    square([850, 470], center=true);

    // Bottom collar
    translate([0, 0, 2199])
    linear_extrude(470)
    difference() {
        circle(1400, $fn=96);
        circle(1400-470, $fn=96);
        translate([0, 1400, 0])
        square([2800, 2800], center=true);
    }

    // Top collar
    translate([0, 0, 2750])
    linear_extrude(1000)
    difference() {
        circle(1230/2, $fn=96);
        circle(800/2, $fn=96);
        translate([0, 1230/2, 0])
        square([1230, 1230], center=true);
    }
}

a = 200;        // Base thickness
module forViewing()
{
    a = 200;        // Base thickness
    if (model) {
        translate([1700, 0, 0])
        model_encoder();
        model_stepper();
        #color("grey")
        translate([0, 0, 5300+a])
        rotate([180, 0, 0])
        model_steeringShaft();
    }
    color("green")
    translate([0, 0, 1307])
	mainMount(a);
    translate([0, 0, 1500+a])
    shaftGear();
    translate([1700, 0, 1500+a])
    mainGear();
    translate([0, 0, 1700+a])
	mainShaft();
    color("steelblue")
    translate([0, 0, 1845+a])
	rotate([0, 0, 90])
	traveler();
//    color("green")
//    translate([0, 0, 1307+a])
//	rotate([0, 0, 90])
//	travelTracks();
    color("red")
    translate([0, 0, 1307+a])
    shaftMount();
}

module forPrinting()
{
	//mainMount(a);
    shaftGear();
   //mainGear();
   translate([0, 0, 200])
   mainShaft();
    //translate([0, 0, 100])
    //translate([0, 1200, 0])
	//traveler();
}

scale(ViewScale)
{
    forViewing();
    //forPrinting();
}
