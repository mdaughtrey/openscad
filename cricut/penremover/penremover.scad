ViewScale = [0.0254, 0.0254, 0.0254];

// pendia = 576m

scale(ViewScale)
{
    linear_extrude(200)
    difference() {
        circle(660/2, $fn=96);
        circle(600/2, $fn=96);
    }
}
