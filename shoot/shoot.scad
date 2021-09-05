include <model_shoot.scad>

ViewScale = [0.0254, 0.0254, 0.0254];

module surround()
{
//    color("black")
    linear_extrude(63)
    difference()
    {
        square([2030, 3990], center=true);
        square([1980, 3950], center=true);
    }
    translate([0, 0, 62])
    linear_extrude(50)
    difference()
    {
        square([2030, 3990], center=true);
        square([1930, 3920], center=true);
    }
}

module body0()
{
    ty = 3460;
    tx = 2030;
//    color("black")
    translate([0, -3430/2+ty/2-280, 112])
    difference()
    {
        linear_extrude(200, scale=0.9)
        square([tx, ty], center=true);

        translate([0, 0, -50])
        linear_extrude(200, scale=0.9)
        square([tx, ty], center=true);
    }
}

module test2()
{
    tx = 400;
    ty = 2030;
    color("black")
    translate([3990/2-tx/2, 0, 62])
    difference()
    {
        linear_extrude(200, scale=0.9)
        square([tx, ty], center=true);

        translate([0, 0, -50])
        linear_extrude(200, scale=0.9)
        square([tx, ty], center=true);
    }
}

module chipsurround14()
{
    translate([0, -395, 200])
    linear_extrude(110)
    difference()
    {
        translate([0, -5, 0])
        square([1700, 500], center=true);

        translate([-435, 0, 0])
        square([790, 410], center=true);
        translate([435, 0, 0])
        square([790, 410], center=true);
    }
}

module chipsurround14_cutout()
{
    //color("red")
    translate([0, -395, 200])
    linear_extrude(200)
    {
        translate([-435, 0, 0])
        square([790, 410], center=true);
        translate([435, 0, 0])
        square([790, 410], center=true);
    }
}

module chipsurround16()
{
    translate([0, 835, 63])
    linear_extrude(250)
    difference()
    {
        translate([0, -5, 0])
        square([1750, 500], center=true);

        translate([-435, 0, 0])
        square([820, 410], center=true);
        translate([435, 0, 0])
        square([820, 410], center=true);
    }
}

module chipsurround16_cutout()
{
    //color("red")
    translate([0, 835, 200])
    linear_extrude(300)
    {
        translate([-435, 0, 0])
        square([820, 410], center=true);
        translate([435, 0, 0])
        square([820, 410], center=true);
    }
}

module case()
{
    surround();
    difference()
    {
        body0();
        chipsurround14_cutout();
        chipsurround16_cutout();
    }
    chipsurround14();
    chipsurround16();
}

module forViewing()
{
    model_shoot();
    case();
}

scale(ViewScale)
{
    forViewing();
}
