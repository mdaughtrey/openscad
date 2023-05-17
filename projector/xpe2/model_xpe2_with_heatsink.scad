module model_xpe2()
{
    linear_extrude(62)
    circle(1310/2, $fn=96);
    translate([0, 0, 61])
    linear_extrude(82)
    circle(135/2, $fn=96);
}

module model_heatsink()
{
    linear_extrude(230)
    square([570, 570], center=true);
}
