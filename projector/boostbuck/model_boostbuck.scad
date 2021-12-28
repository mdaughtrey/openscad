ViewScale = [0.0254, 0.0254, 0.0254];

module model_boostbuck()
{
    linear_extrude(65)
    difference()
    {
        square([1875, 955]);
        translate([1624, 133, 0])
        circle(125/2, $fn=96);
        translate([256, 855, 0])
        circle(125/2, $fn=96);
    }

    // Inductors
    translate([467, 442, 65])
    linear_extrude(300)
    square([480, 480]);

    translate([1028, 275, 65])
    linear_extrude(300)
    square([480, 480]);

    // Caps
    translate([140, 375+140, 65])
    linear_extrude(430)
    circle(280/2, $fn=96);

    translate([1565+140, 334+140, 65])
    linear_extrude(430)
    circle(280/2, $fn=96);

    // Pot
    translate([1100, 45, 65])
    linear_extrude(430)
    square([375, 190]);

    // Chip
    translate([465, 15, 65])
    linear_extrude(35)
    square([330, 370]);
}

//module forViewing()
//{
//    model_boostbuck();
//}
//
//module forPrinting()
//{
//}
//
//scale(ViewScale)
//{
//    forViewing();
//}
