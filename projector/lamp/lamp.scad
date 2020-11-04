ViewScale = [0.0254, 0.0254, 0.0254];

LEDTILT=25;

module onesupport()
{
    difference() {
    circle(500, $fn=96);
//    circle(400, $fn=96);
//    }
//
//    difference() {
//    circle(200, $fn=96);
   circle(175/2, $fn=96); }

//    difference() {
//        union() {
//            square([100, 1000], center=true);
//            rotate([0, 0, 90])
//            square([100, 1000], center=true);
//        }
//        circle(175/2, $fn=96);
//    }
}

module support()
{
    linear_extrude(100) {
        onesupport();
        translate([2000, 0, 0])
        onesupport();
        difference() {
            square([2000, 500]);
            circle(500, $fn=96);
            translate([2000, 0, 0])
            circle(500, $fn=96);
            translate([700, -10, 0])
            square([600, 300]);
        }
    }
}

module cutsupport()
{
    rotate([0, 90, 0])
    linear_extrude(100) {
        difference() {
        square([500, 500], center=true);
        translate([110, 0, 0])
        rotate([0, 0, LEDTILT])
        translate([-90, 0, 0])
        square([800, 120], center=true);
        rotate([0, 0, LEDTILT])
        translate([0, 300, 0])
        square([600, 300], center=true);
        }
    }
}

module ledmount()
{
    // full square
    translate([0, 0, 500])
    linear_extrude(150)
    difference() {
        square([1080+10, 1080+10], center=true);
        square([880+10, 880+10], center=true);
        *translate([0, 450, 0])
        square([200, 200], center=true);
    }

    // supports
    move = 940/2+25;
    translate([0, 0, 150+500]) 
    linear_extrude(200) {
        translate([move, move, 0])
        square([100, 100], center=true);
        translate([-move, move, 0])
        square([100, 100], center=true);
        translate([-move, -move, 0])
        square([100, 100], center=true);
        translate([move, -move, 0])
        square([100, 100], center=true);
        *translate([-150, move, 0])
        square([100, 100], center=true);
        *translate([150, move, 0])
        square([100, 100], center=true);
    }

    // cutout square
    translate([0, 0, 350+500])
    linear_extrude(100)
    difference() {
        square([1080+10, 1080+10], center=true);
        square([880+10, 880+10], center=true);
        //translate([0, 450, 0])
        //square([200, 200], center=true);
    }

    // long supports
    translate([-move-50,0, 450+500+250]) 
    cutsupport();
    translate([move-50,0, 450+500+250]) 
    cutsupport();
//    linear_extrude(500) {
//        translate([move, -100, 0])
//        square([100, 500], center=true);
//        translate([-move, -100, 0])
//        square([100, 500], center=true);
//    }

    *translate([0, -move+195, 800+500])
    linear_extrude(600)
    square([1080+10, 100], center=true);
}

module twopieces()
{
    translate([-1000, 0, 0])
    support();
    rotate([-LEDTILT, 0, 0])
    translate([0, -1200, 0])
    rotate([-90, 0, 0])
    ledmount();
}

module onepiece()
{
    //support();
    //translate([0, -1200, 0])
    ledmount();
}

scale(ViewScale)
{
    onepiece();
}
