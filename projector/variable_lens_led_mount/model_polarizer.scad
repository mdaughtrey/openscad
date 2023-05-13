module model_polarizer()
{
    linear_extrude(75)
    difference() {
        circle(1095/2, $fn=96);
        circle(910/2, $fn=96);
    }
    translate([0, 0, 74])
    linear_extrude(585)
    circle(1180/2, $fn=96);
}
