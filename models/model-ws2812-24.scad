ViewScale = [0.0254, 0.0254, 0.0254];

module model_ws2812_24()
{
    color("Cyan")
    linear_extrude(65)
    difference() {
        circle(3550/2, $fn=96);
        circle(2960/2, $fn=96);
    }
    color("CornflowerBlue")
    for (ii=[0:15:360])
    rotate([0, 0, ii])
    translate([3550/2-100, 0, 66])
    linear_extrude(75)
    square([200,200], center=true);

}


//scale(ViewScale)
//{
//    model_ws2812_24();
//}
