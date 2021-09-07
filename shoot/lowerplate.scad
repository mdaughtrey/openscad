ViewScale = [0.0254, 0.0254, 0.0254];
include <model_shoot.scad>

module chipsurround14_cutout()
{
    translate([-435, 0, 0])
    square([790, 410], center=true);
    translate([435, 0, 0])
    square([790, 410], center=true);
}

module chipsurround16_cutout()
{
    translate([-435, 0, 0])
    square([820, 410], center=true);
    translate([435, 0, 0])
    square([820, 410], center=true);
}


module surround()
{
//    color("black")

    linear_extrude(40)
    square([2030, 3990], center=true);
    translate([0, 0, 39])
    linear_extrude(60)
    difference()
    {
        square([2030, 3990], center=true);
        translate([0, 835, 0])
        chipsurround16_cutout();
        translate([0, -395, 0])
        chipsurround14_cutout();
        translate([0, -1300, 0])
        square([1600, 900], center = true);
        translate([0, 200, 0])
        square([1600, 400], center = true);

        translate([0, 1500, 0])
        square([1600, 700], center = true);
    }

    linear_extrude(63)
    difference()
    {
        square([2030, 3990], center=true);
        square([1980, 3950], center=true);
    }
    translate([0, 0, 99])
    linear_extrude(65)
    difference()
    {
        square([2030, 3990], center=true);
        square([1930, 3920], center=true);
    }
}

module forViewing()
{
    *translate([0, 0, 200])
    model_shoot();
    surround();
}


scale(ViewScale)
{
    forViewing();
}
