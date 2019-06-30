ViewScale = [0.0254, 0.0254, 0.0254];

module lens()
{
    difference() {
    sphere(500, $fn=96);
    translate([0, 0, -200])
    cube(1000, center=true);
    }
}

scale(ViewScale)
{
    lens();
}
