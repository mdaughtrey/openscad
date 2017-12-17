ViewScale = [0.0254, 0.0254, 0.0254];

scale(ViewScale)
{
    linear_extrude(400) {
    difference() {
    circle(500, $fn=96, center=true);
    circle(200, $fn=96, center=true);
    }
    translate([1800, 0, 0])
    difference() {
    circle(500, $fn=96, center=true);
    circle(200, $fn=96, center=true);
    }
    #translate([900, 0, 0])
    square([1000, 500], center=true);
    }
}

