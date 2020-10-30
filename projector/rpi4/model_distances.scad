ViewScale = [0.0254, 0.0254, 0.0254];

module distances()
{
    linear_extrude(200)
    circle(500, $fn=96);
}

scale(ViewScale)
{
    distances();
}
