ViewScale = [0.0254, 0.0254, 0.0254];

scale(ViewScale)
{
    linear_extrude(130) circle(266, $fn=96);
    translate([0, 1000, 0])
    linear_extrude(130)
    difference()
    {
        circle(266, $fn=96);
        circle(125, $fn=96);
    }

}
