module model_variable_lens()
{
    // Body 0
    linear_extrude(260)
    circle(550/2, $fn=96);

    // Body 1
    translate([0, 0, 259])
    {
        linear_extrude(421)
        circle(780/2, $fn=96);
        // W/T
        translate([780/2, 0, 210])
        rotate([0, 90, 0])
        linear_extrude(320)
        circle(160/2, $fn=16);

    }

    // Body 2
    translate([0, 0, 669])
    {
        linear_extrude(800)
        circle(1160/2, $fn=96);
        // W/T
        translate([780/2, 0, 400])
        rotate([0, 90, 0])
        linear_extrude(320)
        circle(160/2, $fn=16);

        translate([-400, 0, 0])
        linear_extrude(100)
        square([300, 980], center=true);
    }
}
