ViewScale = [0.0254, 0.0254, 0.0254];


// 2610+275=2885
// 2990-2885=110
module keyplate()
{
    linear_extrude(100)
    difference() {
    translate([-2210, -110, 0])
    square([4420, 2990]);
include <keys.scad>
// pencil keyplate
    translate([1399, 439, 0])
    circle(330/2, $fn=6);
    // pen keyplate
    translate([-1400, 450, 0])
    circle(330/2, $fn=96);
    }
    // sides
    translate([-2210, -110, -120])
    linear_extrude(120)
    difference() {
        square([4420, 2990]);
        translate([100, 100, 0])
        square([4220, 2890]);
    }
    //bottom tab
    translate([-800, -110, -200])
    linear_extrude(80)
    square([1600, 100]);

    translate([-800, -110, -300])
    linear_extrude(100)
    square([1600, 250]);


}

scale(ViewScale)
{
    keyplate();
}
