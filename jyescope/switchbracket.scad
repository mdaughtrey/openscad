ViewScale = [0.0254, 0.0254, 0.0254];

scale(ViewScale)
{
    linear_extrude(250)
    square([700, 50], center=true);
}
