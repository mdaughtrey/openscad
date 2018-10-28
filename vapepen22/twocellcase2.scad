ViewScale = [0.0254, 0.0254, 0.0254];
include <model_hotend.scad>
include <lionpair.scad>

outerhullL=456;
outerhullS=449;
innerhullL=394;
innerhullS=394;

module base()
{
    hull() union() { circle(outerhullL, $fn=96); translate([714, 0, 0]) circle(outerhullS, $fn=96); }
}

module rib(hh)
{
    linear_extrude(hh)
    difference() {
        hull() union() { circle(outerhullL, $fn=96); translate([714, 0, 0]) circle(outerhullS, $fn=96); }
        hull() union() { circle(innerhullL, $fn=96); translate([714, 0, 0]) circle(innerhullS, $fn=96); }
    }
}

module innerrib(hh)
{
    clearance=35;
    linear_extrude(hh)
    difference() {
        hull() union() { circle(outerhullL-clearance, $fn=96); translate([714, 0, 0]) circle(outerhullS-clearance, $fn=96); }
        hull() union() { circle(innerhullL, $fn=96); translate([714, 0, 0]) circle(innerhullS, $fn=96); }
    }
}

module outerrib(hh)
{
    clearance=35;
    linear_extrude(hh)
    difference() {
        hull() union() { circle(outerhullL, $fn=96); translate([714, 0, 0]) circle(449, $fn=96); }
        hull() union() { circle(innerhullL+clearance, $fn=96); translate([714, 0, 0]) circle(innerhullS+clearance, $fn=96); }
    }
}

module usb()
{
    rotate([0, 0, 90])
    translate([0, -300, 60])
    rotate([90, 0, 0])
    linear_extrude(200)
    square([350, 120], center=true);
}

module button()
{
    rotate([0, 0, -90])
    translate([0, -300, 100])
    rotate([90, 0, 0])
    linear_extrude(200)
    square([340, 200], center=true);
}

module airhole()
{
    translate([0, 500, 0])
    rotate([90, 0, 0])
    linear_extrude(1000)
    translate([-(317-80)/2, 0, 0])
    hull() union() { circle(40, $fn=96); translate([317-80, 0, 0]) circle(40, $fn=96); }
}

module hetab()
{
    // cover support
    *translate([0, 0, -50])
    linear_extrude(40)
    #difference () {
    hull() union() { circle(outerhullL, $fn=96); translate([714, 0, 0]) circle(outerhullS, $fn=96); }
//    hull() union() { circle(389, $fn=96); translate([714, 0, 0]) circle(389, $fn=96); }

    circle(912/2, $fn=96);
    }

    // insert
    *translate([0, 0, -50])
    linear_extrude(50)
    difference () {
    hull() union() { circle(379, $fn=96); translate([714, 0, 0]) circle(379, $fn=96); }
    circle(902/2, $fn=96);
    }

    // cover
    linear_extrude(50)
    difference () {
    hull() union() { circle(outerhullL, $fn=96); translate([714, 0, 0]) circle(outerhullS, $fn=96); }
    circle(902/2, $fn=96);
    }
}

module hotend() 
{
    *#translate([0, 0, -50])
    linear_extrude(40)
    difference() {
    circle(902/2, $fn=96);
    circle(852/2, $fn=96);
    }

    difference() {
    linear_extrude(706)
    difference() {
    circle(outerhullL, $fn=96);
    circle(outerhullL-25, $fn=96);
    }
    translate([0, 0, 706-140])
    airhole();
    translate([0, 0, 120])
    usb();
    translate([0, 0, 120])
    button();
    }
    rotate([0, 0, -135])
    hetab();
}

module iltube(clearance)
{
    rotate([90, 0, 0])
    linear_extrude(1000)
    translate([714-902/2, 0, 0])
    circle(200+clearance, $fn=96);
}

module ilcutout(clearance)
{
    translate([-300, 500, 0])
    iltube(clearance);
    translate([500, 500, 0])
    iltube(clearance);
}

module interlockhigh(hh)
{
    translate([0, 0, 200])
    rib(hh-200);
    innerrib(200);
}

module interlocklow(hh)
{
   rib(hh-240);
   translate([0, 0, hh-240])
   outerrib(240);
}

scale(ViewScale)
{
    union() {
    // body base
    linear_extrude(50)
    base();
    translate([0, 0, 50])
    rib(1880+220);

    // interlocks
    translate([0, 0, 1880+220])
    interlocklow(500);
    }


    translate([0, 0, 400])
    union () {
    translate([0, 0, 2380])
    interlockhigh(500);

    rotate([0, 0, 135])
    translate([0, 0, 2880])
    {
//    rotate([0, 0, 180])
//    color("cornflowerblue")
//    model_hotend();
    hotend();
    }
    }
    *translate([0, 0, 50])
    color("cornflowerblue") 
    lionpair();
}
