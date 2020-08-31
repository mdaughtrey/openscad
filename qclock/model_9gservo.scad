//ViewScale = [0.0254, 0.0254, 0.0254];

module model_9gservo()
{
    // body
    servoL = 889;
    servoW = 484;
    linear_extrude(880)
    square([servoL, servoW], center=true);

    // tabs
    tabL = 1270;
    translate([0, 0, 630])
    linear_extrude(100)
    square([tabL, servoW], center=true);

    // big cog
    translate([servoL/2-230, 0, 879])
    linear_extrude(181)
    circle(460/2, $fn=96);

    // little cog
    translate([servoL/2-480, 0, 879])
    linear_extrude(181)
    circle(220/2, $fn=96);

    // shaft
    translate([servoL/2-230, 0, 1059])
    linear_extrude(125)
    circle(190/2, $fn=96);
}

// scale(ViewScale)
// {
//     color("cornflowerblue")
//     model_9gservo();
// }
