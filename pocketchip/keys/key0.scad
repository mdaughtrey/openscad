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

// 2610+275=2885
// 2990-2885=110
module cutout()
{
    difference() {
    translate([-2210, -110, 0])
    square([4420, 2990]);
include <keys.scad>
    translate([
-1400 449.2913
    }
}
module dirkeys()
{
    linear_extrude(100)
    difference () {
    translate([-1190, 2360, 0])
    rotate([0, 0, 45])
    square([800, 800], center=true);
    translate([-1190.00,2610.00,0])
    circle(300/2, $fn=96);
    translate([-1190.00,2140.00,0])
    circle(300/2, $fn=96);
    translate([-1430.00,2380.00,0])
    circle(300/2, $fn=96);
    translate([-960.00,2380.00,0])
    circle(300/2, $fn=96);
    }
}


scale(ViewScale)
{
//    key();
    cutout();
//    translate([400, -2000, 0])
//    dirkeys();
}
