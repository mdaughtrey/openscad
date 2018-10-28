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

module terminals_cutout()
{
    // block
    translate([0, 0, -50])
    linear_extrude(400)
    union() {
    translate([-15, 0, 0])
    square([593+30+24, 306+30],center=true);
    translate([-593/2-12, 240-306/2, 0])
    square([24, 43], center=true);
    }
}

//scale(ViewScale)
//{
//    terminals();
//    #terminals_cutout();
//}

