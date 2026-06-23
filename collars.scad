ViewScale = [0.0254, 0.0254, 0.0254];
include <./BOSL2-master/std.scad>


scale(ViewScale)
{
    $fn=96;
    tube(id=125,h=400,wall=50);
}
