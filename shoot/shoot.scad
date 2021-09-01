include <model_shoot.scad>

ViewScale = [0.0254, 0.0254, 0.0254];

module case()
{
    color("black")
    linear_extrude(63)
    difference()
    {
        square([3990, 2030], center=true);
        square([3950, 1980], center=true);
    }
}

module test()
{
    tx = 3430;
    ty = 2030;
    color("black")
    translate([-3990/2+tx/2, 0, 62])
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


module forViewing()
{
    model_shoot();
    *case();
    *test();
    *test2();
}

scale(ViewScale)
{
    forViewing();
}
