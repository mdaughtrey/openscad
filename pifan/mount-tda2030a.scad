ViewScale = [0.0254, 0.0254, 0.0254];
include <../models/tda2030a.scad>

//module mount_tda2030a()
//{
//    xs=1267;
//    ys=951;
//
//    // spine
//    linear_extrude(100)
//    translate([0, 0, 0])
//    square([xs+200, 200], center=true);
//
//    translate([(xs-589+350)/2, -50, 99])
//    linear_extrude(70)
//    square([(xs-589)/2+100, 100], center=true);
//
//    translate([-xs/2+320/2-50, -50, 99])
//    linear_extrude(70)
//    square([420, 100], center=true);
//
//    translate([(xs-589+350)/2, -30, 169])
//    linear_extrude(50)
//    square([(xs-589)/2+100, 140], center=true);
//
//    translate([-xs/2+320/2-50, -30, 169])
//    linear_extrude(50)
//    square([420, 140], center=true);
//
//    // side
//    translate([650, -100, 110])
//    rotate([-90, 180, 0])
//    linear_extrude(500)
//    difference()
//    {
//        square([200, 220], center=true);
//        translate([50, 15, 0])
//        square([100, 70], center=true);
//    }
//    
//}
//

module mount_tda2030a()
{
    xs=1267;
    ys=951;
    linear_extrude(100)
    difference() {
        square([xs+200,ys+200], center=true);
        square([xs-100,ys-100], center=true);
    }

    translate([0, 0, 99])
    linear_extrude(60)
    difference() {
        square([xs+200,ys+200], center=true);
        square([xs+20,ys+20], center=true);
    }

    translate([0, -250-ys/2, -160])
    linear_extrude(270)
    square([500, 300], center=true);
}

//scale(ViewScale)
//{
//    xs=1267;
//    ys=951;
//
//    translate([0, 0, 100])
//    rotate([0, 0, 180])
//    tda2030a();
//
//    mount_tda2030a();
//}
