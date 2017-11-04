ViewScale = [0.0254, 0.0254, 0.0254];

module brace()
{
    rotate([90, 0, 0])
    linear_extrude(50)
    polygon(points = [[0, 0], [900, 0], [0, 500]]);
}

scale(ViewScale)
{
    linear_extrude(50)
    difference() {
        square([1000, 1000], center = true);
        translate([50, 0, 0]) circle(238, $fn=96);
    }
    // spine
    translate([-550, 0, 0]) linear_extrude(550) square([100, 280], center=true); 
    // side
    translate([-450, 0, 50]) linear_extrude(500) square([100, 1000], center=true);
    // braces
    translate([-400, -450, 50]) brace();
    translate([-400, 500, 50]) brace();
}
