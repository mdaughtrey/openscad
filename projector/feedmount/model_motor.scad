ViewScale = [0.0254, 0.0254, 0.0254];

module model_motor()
{
    linear_extrude(500)
    difference() {
        circle(700, $fn=96);
        translate([492, 0, 0])
        circle(120/2, $fn=96);
        translate([-492, 0, 0])
        circle(120/2, $fn=96);
    }

    translate([0, 0, 499])
    linear_extrude(191)
    circle(510/2, $fn=96);

    translate([0, 0, 689])
    linear_extrude(450)
    circle(126/2, $fn=96);
}

//scale(ViewScale)
//{
//    model_motor();
//}
