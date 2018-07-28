//ViewScale = [0.0254, 0.0254, 0.0254];
 
baseHeight=16;
clipHeight=78;

module lionpair()
{
    linear_extrude(2600)
    union() { circle(354, $fn=96); translate([714, 0, 0]) circle(354, $fn=96); }
}

module termbase()
{
    union() {
        translate([-250, 0, 0]) square([500, 986], center=true);
        circle(493, $fn=96);
    }
}

module negative(comp)
{
    linear_extrude(baseHeight){
    *translate([450, 0, 0]) {
        square([700, 140], center=true);
        translate([350, 0, 0]) circle(70, $fn=96);
    }
    difference() {
        termbase();
        circle(64, $fn=96);
    }
    }
    translate([0, 0, comp/2]) cylinder(h=comp, r1=375, r2=290, center=true, $fn=96);
}

module positive()
{
    linear_extrude(baseHeight) termbase();
    translate([0, 0, 36]) cylinder(h=72, r1=270, r2=190, center=true, $fn=96);
}


//module bits() {
//    color("cornflowerblue") {
////    negative(500);
////    translate([0, 0, 3180]) rotate([180, 0, 0]) positive();
//#    translate([-714, 0, 500]) LionPair();
//    }
//}


