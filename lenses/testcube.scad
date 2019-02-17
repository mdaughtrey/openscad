ViewScale = [0.0254, 0.0254, 0.0254];

module cube()
{
    linear_extrude(300)
    square(500, 500);
}

scale(ViewScale)
{
    cube();
}
