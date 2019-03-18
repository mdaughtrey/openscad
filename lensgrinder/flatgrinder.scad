ViewScale = [0.0254, 0.0254, 0.0254];
use <../libs/MCAD/involute_gears.scad>
use <../libs/MCAD/boxes.scad>
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
    linear_extrude(100)
    circle(800, $fn=96);

    translate([0, 0, 100])
    linear_extrude(30)
    circle(300, $fn=96);

    translate([0, 0, 130])
    linear_extrude(300)
    circle(100, $fn=96);
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
        circle_diameter=200);
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
            circle(1225, $fn=96);
            circle(1075, $fn=96);
            square([2500, 1600], center=true);
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
     // TODO
    //for(ii = [-geartx, geartx]) {
    for(ii = [geartx]) {
        linear_extrude(270) 
        translate([ii, 0, 270]) {
        gearcircles(number_of_teeth=not,
            circular_pitch=6280,
            gear_thickness=200,
            rim_thickness=500,
            rim_width=50,
            circles=2,
            circle_diameter=200);
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
            circle_diameter=200);
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

    
    // pushrod mounting
    linear_extrude(300)
    translate([0, -geartx-750, 0])
    square([300, 400], center=true);

    *linear_extrude(300)
    translate([0, -2900, 0]) 
    square([400, 1800], center=true);

    *linear_extrude(100) 
    translate([0, -4300, 0]) {
        difference() {
            circle(1200/2, $fn=96);
            square(200, center=true);
        }
    }

    *translate([0, -4300, 100]) 
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

module arm2()
{
    armwheels();
    translate([0, 0, 400])
    linear_extrude(300) {
        // collars
        for(ii = [geartx, -geartx])
        {
            translate([ii, 0, 0]) {
                difference() {
                    circle(420/2, $fn=96);
                    circle(220/2, $fn=96);
                }
                // projecting arms
                difference() {
                    translate([0, -500, 0]) 
                    square([300, 1000], center=true);
                    circle(220/2, $fn=96);
                } // difference
            }
        }
        translate([0, -geartx+550, 0])
        difference() {
            circle(geartx+150, $fn=96);
            circle(geartx-150, $fn=96);
            translate([0, 1000, 0])
            square([4000, 2000], center=true);
        }
        // pushrod mounting
        translate([0, -geartx-1150-100, 400])
        square([300, 400], center=true);
    }
    
}

module pushrod0() {
    linear_extrude(200) {
        circle(400/2, $fn=96);
        translate([2000, 0, 0])
        circle(400/2, $fn=96);
        translate([1000, 0, 0])
        square([2000, 400], center=true);
    }
    for(ii = [0, 2000]) {
        translate([ii, 0, 199])
        linear_extrude(600)
        circle(200/2, $fn=96);
    }
}

module pushrod1() {
    linear_extrude(400) {
        difference() {
            union() {
                circle(400/2, $fn=96);
                translate([2000, 0, 0])
                circle(400/2, $fn=96);
                translate([1000, 0, 0])
                square([2000, 400], center=true);
            }
            circle(210/2, $fn=96);
            translate([2000, 0, 0])
            circle(210/2, $fn=96);
        }
    }
}

module pushpair() 
{
    pushrod0();
//    translate([0, 1000, 0])
//    pushrod();
//
//    translate([0, 0, 750])
//    pushrod();
//
//    translate([0, 1000, 750])
//    pushrod();
}

module pushrods()
{
//    *for(ii = [0, 2000]) {
        //translate([ii, 500, 470])
        *rotate([0, 90, 0])
        difference() {
            roundedBox([500, 1100, 500], 50.0, false);
            cube([320, 320, 510], center=true);
            for(ii = [350,-350]) {
                translate([-300, ii, 0])
                rotate([0, 90, 0])
                linear_extrude(600)
                circle(235/2, $fn=96);
            }
        }
//    }

    pushpair();

    *for(jj = [0, 1000]) {
        for(ii = [0, 2000]) {
            translate([ii, jj, 200])
            linear_extrude(600)
            circle(200/2, $fn=96);
        }
    }

//    translate([2000, 0, 200])
//    linear_extrude(600)
//    circle(200/2, $fn=96);


//    circle(200/2, $fn=96);
//    circle(200/2, $fn=96);

//    // arm mount
//    difference() {
//        roundedSquare(pos=[500,1500],r=100);
//        square([320, 420], center=true);
//    }
//    //linear_extrude(300)
//    *difference() {
//        square([300, 800], center=true);
//        translate([0, 100, 0])
//        circle(220/2, $fn=96);
//        translate([0, -100, 0])
//        circle(220/2, $fn=96);
//    }
}

module weightedbase0(delta)
{
    hull() {
        translate([geartx+delta/2, 0, 0])
        circle(800+delta, $fn=96);
        translate([-geartx-delta/2, 0, 0])
        circle(800+delta, $fn=96);
    }
    circle(1200+delta, $fn=96);
}

module weightedbase()
{
    linear_extrude(100)
    weightedbase0(70);
    
    translate([0, 0, 100])
    linear_extrude(300)
    difference() {
        weightedbase0(70);
        weightedbase0(20);
    }

    translate([0, 0, 400])
    linear_extrude(100)
    difference() {
        weightedbase0(70);
        weightedbase0(20);
    }
}

module interfacemount()
{
    // pushrod mounting
    linear_extrude(300)
    //translate([0, -geartx-750, 0])
    square([300, 400], center=true);

    translate([0, 500, 0])
    linear_extrude(1600)
    difference() {
        square(600, center=true);
        square(520, center=true);
    }
}

module lensinterface0()
{
    linear_extrude(50)
    difference() {
        square(600, center=true);
        circle(230/2, $fn=96);
    }

    translate([0, 0, 50])
    linear_extrude(100)
    difference() {
        square(500, center=true);
        circle(230/2, $fn=96);
    }

    translate([0, 0, 150])
    linear_extrude(200)
    difference() {
        square(500, center=true);
        square(450, center=true);
    }

}

scale(ViewScale)
{
//    armwheels();
//    lowersupports();
//    translate([0, 0, 130])
//    gears();
//    translate([0, 0, 250])
//    drivercrossbar();
//    translate([0, 0, 1850]) {
//        rotate([180, 0, 0]) {
//        motorhousing();
//        model_geared2();
//        }
//    }
//    translate([0, 0, 100])
//    motorsupport();

//    translate([0, 0, 500])
//    housingsupport();
//    
//    translate([0, 0, 1000])
//    arm();
//
//    translate([450, -3200, 1050])
//    rotate([90, 0, -90])
    pushrods();
//
//    translate([0, 0, -400])
//    weightedbase();

//    translate([0, -400, 75])
//    interfacemount();
//    lensinterface0();
    
    
}
