include <model_setscrew_bearing.scad>

ViewScale = [0.0254, 0.0254, 0.0254];

module cutout(v)
{
    difference()
    {
        union()
        {
            circle(v/2, $fn=96);
            translate([v/2, 0, 0])
            square([v, v], center = true);
        }
        translate([875, 0, 0])
        square([875, v], center = true);
    }
}

module vexmount_tab()
{
    linear_extrude(200)
    difference()
    {
        union()
        {
            circle(385/2, $fn=96);
            translate([285/2-1, 0, 0])
            square([285, 385], center = true);
        }
        circle(180/2, $fn=96);
    }
}

module vexmount_body()
{
    // Side
    linear_extrude(51)
    difference()
    {
        cutout(965);
        cutout(675);
    }

    // Middle
    translate([0, 0, 50])
    linear_extrude(295)
    difference()
    {
        cutout(965);
        cutout(875);
    }

    // Side
    translate([0, 0, 344])
    linear_extrude(51)
    difference()
    {
        cutout(965);
        cutout(675);
    }

    // Extend
    translate([0, 0, 394])
    linear_extrude(395)
    difference()
    {
        cutout(965);
        cutout(675);
    }
}

module vexmount()
{
    vexmount_body();
    *color("lightblue")
    {
        translate([0, 0, 60])
        model_setscrew_bearing();
    }
    translate([865/2-200, -750, 385/2])
    rotate([0, 90, 0])
    rotate([0, 0, 90])
    vexmount_tab();

    translate([865/2-200, 750, 385/2])
    rotate([0, 90, 0])
    rotate([0, 0, -90])
    vexmount_tab();
}

//scale(ViewScale)
//{
 //   forViewing();
//}
