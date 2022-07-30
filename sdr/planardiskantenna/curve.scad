ViewScale = [0.0254, 0.0254, 0.0254];
include <curve.dat>


scale(ViewScale)
{
    rotate_extrude(angle = 90, convexity=2, $fn=96)
//    linear_extrude(100)
//    difference() {
//        square([1000, 1000]);
        polygon(points=curve);
//    }
}
