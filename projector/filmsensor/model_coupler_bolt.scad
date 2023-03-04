module model_coupler_bolt()
{
    linear_extrude(115)
    circle(215/2, $fn=96);
    translate([0, 0, 114])
    linear_extrude(306)
    circle(118/2, $fn=96);
}

module model_coupler_nut()
{
    linear_extrude(94)
    circle(245/2, $fn=6);
}

module model_coupler_lockwasher()
{
    linear_extrude(28)
    circle(200/2, $fn=96);
}
