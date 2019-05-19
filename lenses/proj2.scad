ViewScale = [0.0254, 0.0254, 0.0254];

dia=2200;

module lens_model()
{
    translate([0, 0, -100])
    linear_extrude(100)
    circle(500, $fn=96);

    difference() {
    translate([0, 0, -dia/2+120])
    sphere(dia/2, $fn=384);
    translate([0, 0, -dia/2])
    cube(dia, center=true);
    }
    // grabber bit at the top
    translate([0, 0, 50])
    linear_extrude(200)
    circle(100, $fn=6);
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

//scale(ViewScale)
//{
//    translate([0, 0, -200])
//    lens();
//    translate([1000, 0, 0])
//    linear_extrude(100)
//    arm();
//}
