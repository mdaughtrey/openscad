ViewScale = [0.0254, 0.0254, 0.0254];
include <model_xpe2_with_heatsink.scad>

module cutouts()
{
   difference() {
        circle(1600/2, $fn=96);
        circle(1490/2, $fn=96);
        // tab
        rotate([0, 0, 45]) 
        translate([0, 700, 0])
        square([200, 200], center=true);
        // tab
        rotate([0, 0, 165]) 
        translate([0, 700, 0])
        square([200, 200], center=true);
        // tab
        rotate([0, 0, 285]) 
        translate([0, 700, 0])
        square([200, 200], center=true);
        translate([-600, 0, 0])
        square([500, 100], center=true);
    }
}

module cutouts2()
{
   difference() {
        circle(1600/2, $fn=96);
        circle(1490/2, $fn=96);
        // tab
        rotate([0, 0, 53]) 
        translate([0, 700, 0])
        square([400, 200], center=true);
        // tab
        rotate([0, 0, 173]) 
        translate([0, 700, 0])
        square([400, 200], center=true);
        // tab
        //#rotate([0, 0, 240]) 
        rotate([0, 0, 293]) 
        translate([0, 700, 0])
        square([400, 200], center=true);
        translate([-600, 0, 0])
        square([500, 100], center=true);
        translate([-600, 0, 0])
        square([500, 100], center=true);
    }
}

module tab()
{
    // tab big bit
    *linear_extrude(160)
    intersection() {
        difference() {
            circle(1660/2, $fn=96);
            circle(1460/2, $fn=96);
        }
        rotate([0, 0, 52]) 
        translate([0, 700, 0])
        square([380, 260], center=true);
    }
    //translate([0, 0, 160])
    // tab little bit
    linear_extrude(130)
    intersection() {
        difference() {
            circle(1600/2, $fn=96);
            circle(1460/2, $fn=96);
        }
        rotate([0, 0, 45]) 
        translate([0, 700, 0])
        square([180, 300], center=true);
    }
}

module tabs()
{
    tab();
    rotate([0, 0, 120])
    tab();
    rotate([0, 0, 240])
    tab();

    *linear_extrude(200)
    difference() {
        circle(1461/2, $fn=96);
        circle(1355/2, $fn=96);
    }

}

module case()
{
    // front
    linear_extrude(20)
    difference() {
        circle(1461/2, $fn=96);
        circle(740/2, $fn=96);
    }

    // Inner ring
    translate([0, 0, 19])
    linear_extrude(100)
    difference() {
        circle(880/2, $fn=96);
        circle(780/2, $fn=96);
        translate([400, 0, 0])
        square(150, center=true);
    }
    // Outer
    translate([0, 0, 19])
    linear_extrude(392-20+70+20)
    difference() {
        circle(1461/2, $fn=96);
        circle(1350/2, $fn=96);
    }
    // Inner ribs
    translate([0, 0, 19])
    linear_extrude(392-20+20)
    for(ii = [0:120:360]) {
        rotate([0, 0, ii])
        translate([600, 0, 0])
        square(180, center=true);
    }
    // Inserts
    translate([0, 0, 19+392-19+20])
    linear_extrude(70)
    for(ii = [0:120:360]) {
        rotate([0, 0, ii])
        translate([620, 0, 0])
        square([120, 100], center=true);
    }
    tabs();
    translate([0, 0, 480])
    linear_extrude(250)
    difference() {
        circle(1600/2, $fn=96);
        circle(1400/2, $fn=96);
        translate([-600, 0, 0])
        square([500, 100], center=true);
    }
    *translate([0, 0, 480])
    linear_extrude(251)
    cutouts();

    translate([0, 0, 729])
    linear_extrude(151)
    cutouts2();

    translate([0, 0, 879])
    linear_extrude(151)
    cutouts();
}

module fanmount()
{
    module rotcutouts() {
        for(ii=[0:90:360]) {
            rotate([0, 0, ii])
            translate([0, 500, 0])
            square([400, 200], center=true);
        }
    }
    module ledframe1()
    {
        difference() {
            square([1140, 1140], center=true);
            square([900, 900], center=true);
            rotcutouts();
        }
    }

    linear_extrude(200){
        ledframe1();
    }

    translate([0, 0, 199])
    linear_extrude(201)
    difference() {
        square([1140, 1140], center=true);
        square([1010, 1040], center=true);
    }

    translate([0, 0, 399])
    linear_extrude(201)
    difference() {
        square([1140, 1140], center=true);
        square([1010, 1040], center=true);
        translate([300, 550, 0])
        square([200, 100], center=true);
    }
}

module lid()
{
    linear_extrude(250)
    difference() {
        circle(1461/2, $fn=96);
        circle(1361/2, $fn=96);
    }
    translate([0, 0, 249])
    linear_extrude(101)
    difference() {
        circle(1461/2, $fn=96);
        intersection() {
        circle(1361/2, $fn=96);
        square([900, 900], center=true);
        }

    }

    tabs();
    translate([0, 0, 349])
    fanmount();
}

module forViewing()
{
    case();
    translate([0, 0, 480])
    color("tan")
    rotate([180, 0, 0])
    model_xpe2();
    color("grey")
    translate([0, 0, 480])
    model_heatsink();
    color("green")
    translate([0, 0, 750])
    lid();

}

module forPrinting()
{
    case();
}

scale(ViewScale)
{
    forViewing();
    //forPrinting();
}
