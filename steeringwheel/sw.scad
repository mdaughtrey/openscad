ViewScale = [0.0254, 0.0254, 0.0254];

include <model_encoder.scad>
include <model_stepper.scad>
include <maingear.scad>
//include <innerscrew.scad>

model = 1;

module case()
{
}

module mainShaft()
{
	linear_extrude(2000)
	difference() {
		circle(500, $fn=96);
		circle(100, $fn=96);
	}
}

module traveler()
{
	translate([0, 0, 750])
	linear_extrude(1000)
	difference() {
		union() {
			circle(600, $fn=96);
			square([2300, 200], center=true);
		}
		circle(520, $fn=96);
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
    translate([0, 0, 1307])
	mainMount();
    translate([0, 0, 1500])
    mainGear();
    translate([1700, 0, 1500])
    mainGear();
    translate([0, 0, 1700])
	mainShaft();
    translate([0, 0, 1200])
	rotate([0, 0, 90])
	traveler();
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
