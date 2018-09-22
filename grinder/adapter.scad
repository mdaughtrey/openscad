ViewScale = [0.0254, 0.0254, 0.0254];

module adapter()
{
    linear_extrude(300)
    difference() {
    circle(280, $fn=96);
    circle(160, $fn=5);
    }
    translate([0, 0, 300])
    linear_extrude(100)
    circle(280, $fn=96);

    translate([0, 0, 400])
    linear_extrude(500)
    circle(180, $fn=6);
}

scale(ViewScale)
{
    adapter();
}
