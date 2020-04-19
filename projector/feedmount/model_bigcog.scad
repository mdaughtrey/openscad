ViewScale = [0.0254, 0.0254, 0.0254];

module model_bigcog()
{
    linear_extrude(103)
    difference() {
        circle(1250/2, $fn=96);
        circle(127/2, $fn=96);
    }

    translate([0, 0, 102])
    linear_extrude(350-103)
    difference() {
        circle(385/2, $fn=96);
        circle(127/2, $fn=96);
    }
}

//scale(ViewScale)
//{
//    model_bigcog();
//}
