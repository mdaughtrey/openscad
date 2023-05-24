module model_enlarger_lens()
{
    linear_extrude(146) {
        difference() {
            circle(1525/2, $fn=96);
            circle(1450/2, $fn=96);
        }
        circle(985/2, $fn=96);
    }
    translate([0, 0, 145])
    linear_extrude(156)
    circle(1640/2, $fn=96);

    translate([0, 0, 300])
    linear_extrude(328)
    circle(1530/2, $fn=96);

    translate([0, 0, 627])
    linear_extrude(156)
    circle(1640/2, $fn=96);

    translate([0, 0, 782])
    linear_extrude(356)
    circle(1320/2, $fn=96);


}
