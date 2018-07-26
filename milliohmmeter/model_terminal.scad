ViewScale = [0.0254, 0.0254, 0.0254];

module terminals()
{
    // block
    linear_extrude(400)
    difference() {
    union() {
    square([593, 306],center=true);
    translate([-593/2-12, 240-306/2, 0])
    square([24, 43], center=true);
    }
    translate([593/2-24, 240-306/2, 0])
    square([24, 43], center=true);
    }
    // pins
    translate([0, 23, -140])
    linear_extrude(140)
    circle(38/2, $fn=96);

    translate([186, 23, -140])
    linear_extrude(140)
    circle(38/2, $fn=96);

    translate([-186, 23, -140])
    linear_extrude(140)
    circle(38/2, $fn=96);
}

//scale(ViewScale)
//{
//    terminals();
//}

