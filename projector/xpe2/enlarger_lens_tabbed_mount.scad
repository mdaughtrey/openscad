ViewScale = [0.0254, 0.0254, 0.0254];
//include <model_xpe2_with_heatsink.scad>
include <model_enlarger_lens.scad>
include <collars.scad>

models=1;


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
    translate([0, 0, 479])
    linear_extrude(201)
    difference() {
        circle(1600/2, $fn=96);
        circle(1400/2, $fn=96);
        for(ii=[0:20:360]) {
            rotate([0, 0, ii])
            translate([-600, 0, 0])
            square([500, 100], center=true);
        }
    }
    translate([0, 0, 679])
    linear_extrude(50)
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
            intersection() {
            square([1140, 1140], center=true);
            circle(1461/2, $fn=96);
            }
            square([900, 900], center=true);
           // rotcutouts();
        }
    }

    linear_extrude(200){
        ledframe1();
    }

    #translate([0, 0, 199])
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
    linear_extrude(150)
    difference() {
        circle(1461/2, $fn=96);
        circle(1361/2, $fn=96);
    }
    translate([0, 0, 149])
    linear_extrude(51)
    difference() {
        circle(1461/2, $fn=96);
        intersection() {
        circle(1361/2, $fn=96);
        square([900, 900], center=true);
        }

    }

    tabs();
    translate([0, 0, 199])
    fanmount();
}

module backend_tilt0() 
{
    translate([0, 0, 300])
    rotate([180, 0, 0])
    tabbed_accept_collar();
    translate([0, 0, 299])
    linear_extrude(151)
    difference() {
        circle(1740/2, $fn=96);
        circle(1535/2, $fn=96);
    }

    translate([0, 0, 449])
    linear_extrude(160)
    difference() {
        circle(1740/2, $fn=96);
        circle(1650/2, $fn=96);
    }
}

module backend_tilt5() 
{
    translate([0, 0, -250])
    rotate([5,0,0]) {
        tabbed_accept_collar();
        translate([0, 0, 299])
        linear_extrude(150)
        difference() {
            circle(1600/2, $fn=96);
            circle(1490/2, $fn=96);
        }
    }

    translate([0, 0, 100])
    linear_extrude(200)
    difference() {
        circle(1600/2, $fn=96);
        circle(1490/2, $fn=96);
    }

    translate([0, 0, 299])
    linear_extrude(151)
    difference() {
        circle(1740/2, $fn=96);
        circle(1535/2, $fn=96);
    }

    translate([0, 0, 449])
    linear_extrude(160)
    difference() {
        circle(1740/2, $fn=96);
        circle(1650/2, $fn=96);
    }
}

module backend_tilt2() 
{
    translate([0, 0, -250])
    rotate([2,0,0]) {
        tabbed_accept_collar();
        translate([0, 0, 299])
        linear_extrude(150)
        difference() {
            circle(1600/2, $fn=96);
            circle(1490/2, $fn=96);
        }
    }

    translate([0, 0, 100])
    linear_extrude(200)
    difference() {
        circle(1600/2, $fn=96);
        circle(1490/2, $fn=96);
    }

    translate([0, 0, 299])
    linear_extrude(151)
    difference() {
        circle(1740/2, $fn=96);
        circle(1535/2, $fn=96);
    }

    translate([0, 0, 449])
    linear_extrude(160)
    difference() {
        circle(1740/2, $fn=96);
        circle(1650/2, $fn=96);
    }
}

module frontend()
{
    linear_extrude(156)
    difference() {
        circle(1750/2, $fn=96);
        circle(1650/2, $fn=96);
    }
    translate([0, 0, 155])
    linear_extrude(101)
    difference() {
        circle(1750/2, $fn=96);
        circle(1340/2, $fn=96);
    }

    translate([0, 0, 255])
    linear_extrude(320)
    difference() {
        circle(1470/2, $fn=96);
        circle(1340/2, $fn=96);
    }

    translate([0, 0, 445])
    tabbed_insert_collar();


}

module little_lensmount()
{
    linear_extrude(101)
    difference() {
        circle(730/2, $fn=96);
        circle(700/2, $fn=96); // inner
    }

    translate([0, 0, 100])
    linear_extrude(101)
    difference() {
        circle(810/2, $fn=96);
        circle(700/2, $fn=96); // inner
    }

    translate([0, 0, 199])
    linear_extrude(101)
    difference() {
        circle(810/2, $fn=96);
        circle(780/2, $fn=96); // inner
    }


    *translate([0, 0, 599])
    linear_extrude(101)
    difference() {
        circle(810/2, $fn=96);
        circle(780/2, $fn=96); // inner
    }

    *translate([0, 0, 499])
    linear_extrude(100)
    difference() {
        circle(810/2, $fn=96);
        circle(780/2, $fn=96); // inner
    }
}

module forViewing()
{
//    case();
//    translate([0, 0, 480])
//    color("tan")
//    rotate([180, 0, 0])
//    model_xpe2();
//    color("grey")
//    translate([0, 0, 480])
//    model_heatsink();
//    color("green")
//    translate([0, 0, 750])
    lid();
//    if (models) { 
//        color("grey")
//        translate([0, 0, 300])
//        model_enlarger_lens(); 
//    }
//    *backend_tilt2();
//    *translate([0, 0, 950])
//    *frontend();
//    little_lensmount();

}

module forPrinting()
{
//   frontend();
//    backend();
    backend_tilt0();
}

scale(ViewScale)
{
    forViewing();
//    forPrinting();
}
