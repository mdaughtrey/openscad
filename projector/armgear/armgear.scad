ViewScale = [0.0254, 0.0254, 0.0254];
use <../../libs/MCAD/involute_gears.scad>

module armgear()
{
    gear(number_of_teeth=24,
        circular_pitch=5250,
        gear_thickness=120,
        rim_thickness=120,
        rim_width=50,
        bore_diameter = 180,
        bore_sides = 96,
        circles=0,
        circle_diameter = cdia,
        circle_rim_inner_dia=220,
        circle_rim_thickness=100,
        circle_rim_height=300);
    linear_extrude(120)
    translate([150, 0, 0])
    square([180, 180], center=true);

    translate([0, 0, 119])
    linear_extrude(41)
    difference() {
        circle(310, $fn=96);
        difference() {
            circle(90, $fn=96);
            translate([150, 0, 0])
            square([180, 180], center=true);
        }
    }
}

scale(ViewScale)
{
    armgear();
//    color("CornflowerBlue")
//    square([762, 762], center=true);
}
