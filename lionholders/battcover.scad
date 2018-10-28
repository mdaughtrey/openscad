ViewScale = [0.0254, 0.0254, 0.0254];
use <onescap.scad>

module oneCap(count, radius)
{
    space = 790;
    for (ii = [0: space: space * count - 1])
    {
        translate([ii, 0, 0]) {
            circle(radius/2, $fn=96);
    }}
}

module battcover()
{
    linear_extrude(2160)
    difference() {
    hull() {
    oneCap(3, 830);
    translate([400, 700, 0])
    oneCap(2, 830); }

    hull() {
    oneCap(3, 740);
    translate([400, 700, 0])
    oneCap(2, 740); 
    }
    translate([-450, -500, 0])
    square([2500, 500]);
    }
}

scale(ViewScale)
{
    battcover();
}

