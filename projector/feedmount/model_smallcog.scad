ViewScale = [0.0254, 0.0254, 0.0254];

module model_smallcog()
{
    linear_extrude(150)
    difference() {
        circle(530/2, $fn=96);
        circle(127/2, $fn=96);
    }

    translate([0, 0, 149])
    linear_extrude(352-150)
    difference() {
        circle(385/2, $fn=96);
        circle(127/2, $fn=96);
    }
}

//scale(ViewScale)
//{
//    model_smallcog();
//}
