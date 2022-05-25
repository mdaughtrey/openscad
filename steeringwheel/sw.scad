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
    th = 100-10;
    tw = 100-10;
    straight_thread(
        section_profile = [[0,0], [th, 0], [th, tw],  [0, tw]],
        higbee_arc = 20,
        r = 565/2,
        turns = 5.5,
        pitch = 200,
        fn=96);
    difference() {
        linear_extrude(3000)
//        difference() {
            circle(567/2, $fn=96);
//            circle(100/2, $fn=96);
//        }

        // End slot cutout
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
        // Bolt Hole
        //translate([-1000, 0, 2500])
        translate([0, 0, -1])
        linear_extrude(3000)
        #intersection() {
            circle(198/2, $fn=96);
            translate([20, 0, 0])
            square([198, 198], center=true);
        }
    }

}

module traveler()
{
    th = 130;
    tw = 100;
    straight_thread(
        section_profile = [[0,0], [th, 0], [th, tw],  [0, tw]],
        higbee_arc = 20,
        r = 510/2,
        turns = 2,
        pitch = 200,
        fn=96);


	translate([0, 0, 0])
	linear_extrude(500)
	difference() {
		union() {
			circle(900/2, $fn=96);
			square([2300, 200], center=true);
		}
		circle(720/2, $fn=96);
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
    x = 1660;
    x0 = -(x/2)+190;
    x1 = (x/2) - 190;
    
    y0 = -(1400/2)-450;
    y1 = (1400/2)+450;

	linear_extrude(thick)
	difference() {
		translate([820, 0, 0])
		square([3400+220, 2800], center=true);
		circle(785/2+10, $fn=96);
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
            for (jj = [x0, x1]) {
                translate([ii, jj, 0])
                circle(120/2, $fn=96);
            }
        }
        for (ii = [x0, x1]) {
            for (jj = [y0, y1]) {
                translate([ii, jj, 0])
                circle(170/2, $fn=96);
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
	rotate([0, 0, 90])
	travelTracks();
}

module shaftMount()
{
    x = 1660;
    x0 = -(x/2)+190;
    x1 = (x/2) - 190;

    // Fastener tabs
    linear_extrude(200)
    for (ii = [[x0,1],[x1,-1]]) {
        translate([ii[0], -(1400/2)-450, 0])
        difference() {
            union()
            {
                circle(470/2, $fn=96);
                translate([ii[1]*190, 0, 0])
                square([470, 470], center=true);
            }
            circle(170/2, $fn=96);
        }
    }

    // Traveler groove adjacent
    translate([0, 0, 199])
    linear_extrude(1121)
    for (ii = [[x0,1],[x1,-1]]) {
        translate([ii[0], -(1400/2)-450, 0])
        difference()
        {
            translate([ii[1]*190, 0, 0])
            square([470, 470], center=true);
            circle(490/2, $fn=96);
        }
    }

    // Traveler groove over
    translate([0, 0, 1199])
    linear_extrude(201)
    translate([0, -(1400/2)-450, 0])
    difference() {
        square([1200, 470], center=true);
        for (ii = [x0,x1]) {
            translate([ii, 0, 0])
            circle(490/2, $fn=96);
        }
    }
    // Top collar
    translate([0, 0, 3250])
    linear_extrude(500)
    difference() {
        circle(1230/2, $fn=96);
        circle(800/2, $fn=96);
    }

//    for (ii = [x0, x1]) {
//        translate([ii, -(1400/2)-450, 0])
//        linear_extrude(100)
//        difference() {
//            circle(470/2, $fn=96);
//            circle(170/2, $fn=96);
//        }
//    }

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
	mainMount(a);
}

scale(ViewScale)
{
    forViewing();
    //forPrinting();
}
