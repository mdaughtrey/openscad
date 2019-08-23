ViewScale = [0.0254, 0.0254, 0.0254];

module cap()
{
    linear_extrude(50)
    circle(220/2, $fn=96);
    translate([0, 0, 49])
    linear_extrude(180)
    circle(180/2, $fn=96);
    translate([0, 0, 229])
    linear_extrude(20)
    circle(50/2, $fn=96);
}

scale(ViewScale)
{
    cap();
}
