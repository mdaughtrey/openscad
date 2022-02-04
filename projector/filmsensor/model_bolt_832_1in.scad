module model_bolt_832_1in()
{
    linear_extrude(161)
    circle(267/2, $fn=96);
    translate([0, 0, 160])
    linear_extrude(1000)
    circle(160/2, $fn=96);
}
