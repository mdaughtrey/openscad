ViewScale = [0.0254, 0.0254, 0.0254];

module ma_section(dia)
{
    difference() {
        circle(dia/2, $fn=96);
        translate([560/2+30, 0, 0])
        square([200, 137], center=true);
        translate([-560/2-30, 0, 0])
        square([200, 137], center=true);
    }
}
module model_arm()
{
   // 162-76
    //1000m di

    linear_extrude(76)
    circle(750, $fn=96);

    linear_extrude(162)
    circle(500, $fn=96);

    translate([0, 0, 161])
    linear_extrude(370)
    ma_section(560);

    translate([0, 0, 369+161])
    linear_extrude(41)
    ma_section(530);

    translate([0, 0, 409+161])
    linear_extrude(41)
    ma_section(560);

    translate([0, 0, 449+161])
    linear_extrude(31)
    circle(350/2, $fn=96);

    translate([0, 0, 479+161])
    linear_extrude(357)
    circle(125/2, $fn=96);
}

//scale(ViewScale)
//{
//    model_arm();
//}
