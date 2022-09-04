module model_aaa()
{
    if (modelcolor) color("white")
    linear_extrude(1704)
    circle(407/2, $fn=96);
    if (modelcolor) color("silver")
    translate([0, 0, 1703])
    linear_extrude(56)
    circle(144/2, $fn=96);
}

