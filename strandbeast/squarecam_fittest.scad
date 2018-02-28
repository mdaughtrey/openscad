include <defs.scad>
include <model_squareinsert.scad>
include <squareinsertcam.scad>

scale(ViewScale)
{
    translate([0, 1200, 0]) cam();
    cam2();
   //translate([0, 0, InsertY+LayerUnit-50]) rotate([90, 0, 0])
   //translate([0, 0, LayerUnit-50]) rotate([0, 0, 90])
//   translate([-InsertE/2, 0, (InsertX)+LayerUnit-100]) rotate([0, 0, 90])
//    color("CornflowerBlue") insert();

//            // central shaft lower section with square cutout
//            translate([MagicM,0,0])
//            linear_extrude(250)
//            difference() {
//                circle(JointR, $fn=96);
//                rotate([0, 0, 120])
//                square([InsertE+30, InsertCapX+30], center=true);
//                //circle(InsertR, $fn=6);
//            }
}

