ViewScale = [0.0254, 0.0254, 0.0254];

module key()
{
    linear_extrude(150)
    circle(270/2, $fn=96);
    translate([0, 0, 149])
    linear_extrude(50)
    circle(320/2, $fn=96);
    translate([0, 0, 199])
    linear_extrude(50)
    circle(100/2, $fn=96);
}

scale(ViewScale)
{
    key();
}
