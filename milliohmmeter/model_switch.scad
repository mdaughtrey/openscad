ViewScale = [0.0254, 0.0254, 0.0254];

module switch()
{
    // body
    linear_extrude(388)
    square([510, 318], center=true);

    // screw
    translate([0, 0, 380])
    linear_extrude(355)
    circle(233/2, $fn=96);

     // toggle
    translate([0, 0, 380+355])
    linear_extrude(420)
    circle(114/2, $fn=96);

    // pins
    translate([0, 0, -153])
    linear_extrude(153)
    square([30, 80], center=true);

    translate([204-30, 0, -153])
    linear_extrude(153)
    square([30, 80], center=true);

    translate([-204+30, 0, -153])
    linear_extrude(153)
    square([30, 80], center=true);
}

//scale(ViewScale)
//`{
//`    switch();
//`}
