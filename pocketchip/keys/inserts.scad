ViewScale = [0.0254, 0.0254, 0.0254];

PLATELIFT=140;
RINGTHICKNESS=80;

scale(ViewScale)
{
    // pen support
    translate([-400, 520, -PLATELIFT])
    linear_extrude(PLATELIFT*4)
    difference() {
        circle(346/2-10, $fn=96);
        circle(246/2, $fn=96);
    }
    // pencil support
    translate([300, 509, -PLATELIFT])
    linear_extrude(PLATELIFT*4)
    difference() {
        circle(360/2-10, $fn=6);
        circle(260/2, $fn=6);
    }
}

