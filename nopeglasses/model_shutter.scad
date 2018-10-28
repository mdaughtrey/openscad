ViewScale = [0.0254, 0.0254, 0.0254];

module lcdShutter()
{
    // glass
    linear_extrude(29)
    square([1420, 1420], center=true);

    translate([0, 40, 29])
    {
    // glass
    linear_extrude(75-29)
    square([1420, 1340], center=true);

    // contact
    translate([-105, -720, 0])
    linear_extrude(50)
    square([80, 100], center=true);

    // contact
    translate([105, -720, 0])
    linear_extrude(50)
    square([80, 100], center=true);

    // wire
    translate([105, -720, 25])
    rotate([90, 0, 0])
    linear_extrude(250)
    circle(20, $fn=96);

    // wire
    translate([-105, -720, 25])
    rotate([90, 0, 0])
    linear_extrude(250)
    circle(20, $fn=96);

    }

}

//scale(ViewScale)
//{
//    lcdShutter();
//}
