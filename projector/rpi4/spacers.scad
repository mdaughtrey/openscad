ViewScale = [0.0254, 0.0254, 0.0254];

scale(ViewScale)
{
    linear_extrude(407) 
    difference() {
        circle(170, $fn=96);
        circle(80, $fn=96);
    }
}
