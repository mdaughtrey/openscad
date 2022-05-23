ViewScale = [0.0254, 0.0254, 0.0254];

use <../libraries/OpenSCAD bottle threads/thread_profile.scad>
include <model_encoder.scad>
include <model_stepper.scad>
include <maingear.scad>
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
        r = 500/2,
        turns = 5.5,
        pitch = 200,
        fn=96);
	linear_extrude(1200)
	difference() {
		circle(502/2, $fn=96);
		circle(100/2, $fn=96);
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

module mainMount()
{
    x = 1660;
    x0 = -(x/2)+190;
    x1 = (x/2) - 190;
	linear_extrude(100)
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
	}
}

module forViewing()
{
    if (model) {
        translate([1700, 0, 0])
        model_encoder();
        model_stepper();
    }
    color("green")
    translate([0, 0, 1307])
	mainMount();
    translate([0, 0, 1500])
    mainGear();
    translate([1700, 0, 1500])
    mainGear();
    translate([0, 0, 1700])
	mainShaft();
    color("steelblue")
    translate([0, 0, 1845])
	rotate([0, 0, 90])
	traveler();
    color("green")
    translate([0, 0, 1307])
	rotate([0, 0, 90])
	travelTracks();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
