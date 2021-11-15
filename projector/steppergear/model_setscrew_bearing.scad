module model_setscrew_bearing()
{
    linear_extrude(274)
    difference()
    {
        circle(865/2, $fn=96);
        circle(315/2, $fn=96);
    }

    translate([0, 0, 264])
    linear_extrude(184)
    difference()
    {
        circle(466/2, $fn=96);
        circle(315/2, $fn=96);
    }
}
