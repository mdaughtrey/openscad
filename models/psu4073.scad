ViewScale = [0.0254, 0.0254, 0.0254];

module psu()
{
    color("Cyan")
    linear_extrude(47)
    square([1890,919], center=true);

    // solder pads
    xpos=1890/2-117/2-10;
    ypos=919/2-117/2-10;
    color("CornflowerBlue")
    translate([0, 0, 47])
    linear_extrude(50)
    {
        translate([xpos, ypos, 0])
        square([117,117],center=true);
        translate([xpos, -ypos, 0])
        square([117,117],center=true);
        translate([-xpos, ypos, 0])
        square([117,117],center=true);
        translate([-xpos, -ypos, 0])
        square([117,117],center=true);
    }

    // Pots
    color("CornflowerBlue")
    translate([0, 919/2-198/2, 47])
    linear_extrude(509-47)
    square([1168,198],center=true);

    // Cap
    color("CornflowerBlue")
    translate([-((1890/2)-(328/2)), 0, 47])
    linear_extrude(420)
    square([328,328],center=true);

    // Cap
    color("CornflowerBlue")
    translate([(1890/2)-(328/2)-190, 0, 47])
    linear_extrude(420)
    square([328,328],center=true);

    // Inductor
    color("CornflowerBlue")
    translate([(1890/2)-(472/2)-556, -((919/2)-(472/2)-36), 47])
    linear_extrude(420)
    square([472,472],center=true);

    // IC
    color("CornflowerBlue")
    translate([-((1890/2)-(388/2)-370), -((919/2)-(440/2)-173), 47])
    linear_extrude(420)
    square([388,440],center=true);

    // Diode
    color("CornflowerBlue")
    translate([-((1890/2)-(100/2)-158), ((919/2)-(275/2)-20), 47])
    linear_extrude(95)
    square([100,275],center=true);

    // Diode
    color("CornflowerBlue")
    translate([-((1890/2)-(220/2)-120), -((919/2)-(145/2)-11), 47])
    linear_extrude(90)
    square([220,145],center=true);
}

//scale(ViewScale)
//{
//    psu();
//}
