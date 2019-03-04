ViewScale = [0.0254, 0.0254, 0.0254];

dia=1000;

module lens()
{
    difference() {
    sphere(dia/2, $fn=96);
    translate([0, 0, -300])
    cube(dia, center=true);
    }
}

module arm()
{
    translate([-500, 0, 0])
    square([500, 500], center=true);

    translate([-150, 0, 0])
    difference() {
    hull() {
    circle(500/2, $fn=96);
    translate([1000, 0, 0])
    circle(500/2, $fn=96);
    }

    hull() {
    circle(200/2, $fn=96);
    translate([1000, 0, 0])
    circle(200/2, $fn=96);
    }}

}

scale(ViewScale)
{
    translate([0, 0, -200])
    lens();
    translate([1000, 0, 0])
    linear_extrude(100)
    arm();
}
