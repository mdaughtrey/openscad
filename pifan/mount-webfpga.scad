ViewScale = [0.0254, 0.0254, 0.0254];

include <../models/model_webfpga.scad>

module mount_webfpga()
{
    linear_extrude(85)
    difference() {
        square([2440, 1185], center=true);
        translate([100, 0, 0])
        square([2440, 985], center=true);
    }

    translate([0, 0, -40])
    linear_extrude(50)
    difference() {
        square([2440, 1185], center=true);
        translate([100, 0, 0])
        square([2240, 785], center=true);
    }

    translate([0, 0, 84])
    linear_extrude(50)
    difference() {
        square([2440, 1185], center=true);
        translate([100, 0, 0])
        square([2240, 785], center=true);
    }

    translate([-950, 700, -180])
    linear_extrude(270)
    square([500, 300],center=true);

    translate([750, 700, -180])
    linear_extrude(270)
    square([500, 300],center=true);


}

*scale(ViewScale)
{
    translate([0, 0, 10])
    model_webfpga();
    mount_webfpga();
}
