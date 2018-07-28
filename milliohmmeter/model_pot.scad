ViewScale = [0.0254, 0.0254, 0.0254];

module pot()
{
    // base
    linear_extrude(400)
    square([378,173], center=true);
    // knob
    translate([-379/2+45, 173/2-45, 400])
    linear_extrude(60)
    circle(90/2, $fn=96);

    // pins
    translate([0, 0, -238])
    linear_extrude(238)
    square([20, 20], center=true);

    translate([122, 0, -238])
    linear_extrude(238)
    square([20, 20], center=true);
    
    translate([-122, 0, -238])
    linear_extrude(238)
    square([20, 20], center=true);
}

module pot_cutout()
{
    // base
    translate([0, 0, -50])
    linear_extrude(400)
    square([378+30,173+30], center=true);
}

//scale(ViewScale)
//{
//    pot();
//    pot_cutout();
//}
