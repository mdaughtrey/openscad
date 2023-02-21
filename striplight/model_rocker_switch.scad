module model_rocker_switch()
{
    // body
    linear_extrude(550)
    circle(800/2, $fn=96);

    //pins
    translate([275, 0, 550])
    linear_extrude(300)
    square([31, 190], center=true);
    translate([-275, 0, 550])
    linear_extrude(300)
    square([31, 190], center=true);
    translate([0, 0, 550])
    linear_extrude(300)
    square([31, 190], center=true);

}
