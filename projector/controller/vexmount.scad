include <../../models/veroboard.scad>

ViewScale = [0.0254, 0.0254, 0.0254];


module screwmount()
{
    linear_extrude(100)
    difference()
    {
        union()
        {
            translate([0, 250, 0])
            square([200, 500], center=true);
            hull()
            {
                translate([-270, 0, 0])
                circle(270, $fn=96);
                translate([270, 0, 0])
                circle(270, $fn=96);
            }
        }
        hull()
        {
            translate([-270, 0, 0])
            circle(190/2, $fn=96);
            translate([270, 0, 0])
            circle(190/2, $fn=96);
        }
    }
    translate([0, 0, 99])
    linear_extrude(51)
    difference()
    {
        translate([0, 250, 0])
        square([200, 500], center=true);
//        square([200, 1000], center=true);
        hull()
        {
            translate([-270, 0, 0])
            circle(270, $fn=96);
            translate([270, 0, 0])
            circle(270, $fn=96);
        }
    }
}

module boardsupport(len)
{
    linear_extrude(len)
    difference()
    {
        square([200, 180], center=true);
        translate([50, 0, 0])
        square([200, 80], center=true);
    }
}

module vexmount()
{
    // board mount
    translate([0, 270, 229])
    rotate([-90, 0, 0])
    boardsupport(2000);

    *translate([0, -270, 229])
    rotate([90, 0, 0])
    boardsupport(1000);

    screwmount();
}

module vexmount2()
{
    translate([-100, 450, 0])
    linear_extrude(151)
    square([200, 2000]);
    // board mount
    translate([0, 270, 229])
    rotate([-90, 0, 0])
    boardsupport(1000);

    translate([0, 2720, 229])
    rotate([90, 0, 0])
    boardsupport(1000);

    screwmount();
}

module forViewing()
{
//    model_Veroboard(20, 26);
    vexmount();
}

module forPrinting()
{
//    vexmount();
    translate([1500, 0, 0])
    scale([-1, 1, 1])
    vexmount2();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
