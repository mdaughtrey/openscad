ViewScale = [0.0254, 0.0254, 0.0254];
include <curve.dat>


scale(ViewScale)
{
    linear_extrude(100)
    difference() {
        square([1500, 1500]);
        polygon(points=curve);
    }
}
