ViewScale = [0.0254, 0.0254, 0.0254];
use <../libs/MCAD/involute_gears.scad>
use <../strandbeast/geared2/model_geared2.scad>
use <../strandbeast/geared2/housing.scad>

geartx = 1520;
not = 43;
cdia = 220;

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

module gears()
{
    for(ii = [-geartx, 0, geartx]) {
        translate([ii, 0, 0])
        gear(number_of_teeth=not,
            circular_pitch=6280,
            gear_thickness=200,
            rim_thickness=500,
            rim_width=50,
            bore_diameter = 220,
            bore_sides = 96,
            circles=2,
            circle_diameter = cdia,
            circle_rim_inner_dia=220,
            circle_rim_thickness=100,
            circle_rim_height=300);
    }

//    gear(number_of_teeth=not,
//        circular_pitch=6280,
//         gear_thickness=200,
//         rim_thickness=500,
//         rim_width=50,
//         bore_diameter = 220,
//         bore_sides = 96,
//         circles=2,
//         circle_diameter = cdia,
//         circle_rim_inner_dia=220,
//         circle_rim_thickness=100,
//         circle_rim_height=300);
//    translate([geartx, 0, 0])
//    gear(number_of_teeth=not,
//        circular_pitch=6280,
//         gear_thickness=200,
//         rim_thickness=500,
//         rim_width=50,
//         bore_diameter = 220,
//         bore_sides = 96,
//         circles=2,
//         circle_diameter = cdia,
//         circle_rim_inner_dia=220,
//         circle_rim_thickness=100,
//         circle_rim_height=300);
}

module lowersupport()
{
//    linear_extrude(100)
//    circle(800, $fn=96);

    translate([0, 0, 100])
    linear_extrude(30)
    circle(300, $fn=96);

    translate([0, 0, 130])
    linear_extrude(300)
    circle(105, $fn=96);
}

module lowersupports()
{
    linear_extrude(100) {
        hull() {
            translate([geartx, 0, 0])
            circle(800, $fn=96);
            translate([-geartx, 0, 0])
            circle(800, $fn=96);
        }
        circle(1200, $fn=96);
    }

    for(ii = [-geartx, 0, geartx]) {
        lowersupport();
        translate([ii, 0, 0])
        lowersupport();
    }
}

module drivercrossbar()
{
    linear_extrude(400)
    gearcircles(number_of_teeth=not,
        circular_pitch=6280,
        gear_thickness=200,
        rim_thickness=500,
        rim_width=50,
        circles=2,
        circle_diameter=cdia);
    translate([0, 0, 400])
    linear_extrude(100)
    difference() {
        circle(700, $fn=96);
        intersection() {
            circle(128/2, $fn=96);
            translate([15, 0, 0])
            square(118, center=true);
        }
    }
}

module motorsupport()
{
    linear_extrude(1000)
    difference() {
        circle(1200, $fn=96);
        circle(1100, $fn=96);
        square([2500, 1600], center=true);
    }
}

module housingsupport()
{
    clearance = 25;
    linear_extrude(600)
    difference() {
        circle(1315, $fn=96);
        circle(985, $fn=96);
        difference() {
            circle(1205, $fn=96);
            circle(1095, $fn=96);
            square([2500, 1580], center=true);
        }
        square([2700, 1400], center=true);
    }
    translate([0, 0, 600])
    linear_extrude(100)
    difference() {
        circle(1315, $fn=96);
        square([513+clearance, 590+clearance], center=true);
        translate([-1500, 0, 0])
        circle(800, $fn=96);
        translate([1500, 0, 0])
        circle(800, $fn=96);
    }

    translate([0, 0, 300])
    linear_extrude(300)
    difference() {
        square([613+clearance, 690+clearance], center=true);
        square([513+clearance, 590+clearance], center=true);
    }
}

module armwheels()
{
    for(ii = [-geartx, geartx]) {
        linear_extrude(270) 
        translate([ii, 0, 270]) {
        gearcircles(number_of_teeth=not,
            circular_pitch=6280,
            gear_thickness=200,
            rim_thickness=500,
            rim_width=50,
            circles=2,
            circle_diameter=cdia);
        }
        translate([ii, 0, 270]) 
        linear_extrude(100) 
        circle(1200/2, $fn=96);
        translate([ii, 0, 370]) 
        linear_extrude(500) 
        gearcircles(number_of_teeth=not,
            circular_pitch=6280,
            gear_thickness=200,
            rim_thickness=500,
            rim_width=50,
            circles=1,
            circle_diameter=cdia);
    }
}

module armcurve()
{
    linear_extrude(300) {
        difference() {
            circle(420/2, $fn=96);
            circle(220/2, $fn=96);
        }
        translate([0, -1000, 0])
        difference() {
            circle(2200/2, $fn=96);
            circle(1800/2, $fn=96);
            translate([600, 0, 0])
            square([1200, 2200], center=true);
            translate([0, 1000, 0])
            circle(220/2, $fn=96);
        }
    }
    translate([0, 0, 300])
    linear_extrude(100)
    difference() {
        circle(420/2, $fn=96);
        circle(220/2, $fn=96);
    }
}

module arm()
{
    armwheels();
    translate([-geartx, 0, 0])
    armcurve();
    translate([geartx, 0, 0])
    mirror([1, 0, 0])
    armcurve();
    translate([-geartx, -2100, 0])
    linear_extrude(300)
    square([geartx*2, 200], $fn=96);

    linear_extrude(300)
    translate([0, -2900, 0]) 
    square([400, 1800], center=true);

    linear_extrude(100) 
    translate([0, -4300, 0]) {
        difference() {
            circle(1200/2, $fn=96);
            square(200, center=true);
        }
    }

    translate([0, -4300, 100]) 
    linear_extrude(200) {
        difference() {
            circle(1200/2, $fn=96);
            circle(1100/2, $fn=96);
        }
        difference() {
            square(300, center=true);
            square(200, center=true);
        }
    }

}

scale(ViewScale)
{
    lowersupports();
    translate([0, 0, 130])
    gears();
    translate([0, 0, 250])
    drivercrossbar();
    translate([0, 0, 1850]) {
        rotate([180, 0, 0]) {
        motorhousing();
        model_geared2();
        }
    }
    translate([0, 0, 100])
    motorsupport();

    translate([0, 0, 500])
    housingsupport();
    
    translate([0, 0, 1000])
    arm();
}
