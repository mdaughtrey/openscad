ViewScale = [0.0254, 0.0254, 0.0254];

include <../models/model-levelshifter.scad>

module mount_levelshifter()
{
    linear_extrude(76)
    difference() {
        square([800, 710], center=true);
        translate([-50, 0, 0])
        square([720, 530], center=true);
    }

    translate([0, 0, 75])
    linear_extrude(50)
    difference() {
        square([800, 710], center=true);
        translate([-50, 0, 0])
        square([720, 470], center=true);
    }

    translate([0, 0, -49])
    linear_extrude(50)
    difference() {
        square([800, 710], center=true);
        translate([-50, 0, 0])
        square([720, 470], center=true);
    }
}

//scale(ViewScale)
//{
//   model_levelshifter();
//    mount_levelshifter();
//}
