ViewScale = [0.0254, 0.0254, 0.0254];
use <wiggle.scad>

module letterL(len)
{
    sphereR = 400;
    // base
    *sphere(sphereR, $fn=96);
    // vertical
    translate([0, 0, 200])
    wiggleTube(len);
    intersection() {
        translate([0, 0, 200])
        linear_extrude(300)
        square(500, center=true);
        translate([0, 0, -sphereR/4])
        sphere(sphereR, $fn=96);
    }
    // bottom knob
    translate([0, 0, 0])
    linear_extrude(200)
    square(200, center=true);

    // support surround
    linear_extrude(180)
    difference() {
        square(500, center=true);
        square(250, center=true);
    }

    translate([0, 0, len-100])
    intersection() {
        linear_extrude(300)
        square(500, center=true);
        translate([0, 0, sphereR+sphereR/2])
        sphere(sphereR, $fn=96);
    }
    // top knob
    translate([0, 0, len+200])
    linear_extrude(200)
    square(200, center=true);
}

scale(ViewScale)
{
    letterL(3000);
}
