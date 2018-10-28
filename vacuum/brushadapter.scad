ViewScale = [0.0254, 0.0254, 0.0254];

module adapter()
{
    linear_extrude(100)
    difference () {
    circle(240/2, $fn=6);
    circle(130/2, $fn=48);
    }

    translate([0, 0, 100])
    linear_extrude(50)
    intersection () {
    square([80, 240], center=true);
    difference () {
    circle(240/2, $fn=6);
    circle(130/2, $fn=48);
    }}
}


scale(ViewScale)
{
    adapter();
}
