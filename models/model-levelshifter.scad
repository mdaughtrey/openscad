ViewScale = [0.0254, 0.0254, 0.0254];

module model_levelshifter()
{
    color("Cyan")
    linear_extrude(66)
    square([600, 510], center=true);

    color("CornflowerBlue")
    {
        // FETs
        translate([0, 0, 65])
        linear_extrude(40)
        square([600, 51], center=true);

        // Resistors
        translate([0, 510/2-20/2-110, 65])
        linear_extrude(20)
        square([600, 32], center=true);

        translate([0, -510/2+20/2+110, 65])
        linear_extrude(20)
        square([600, 32], center=true);
    }


}

//scale(ViewScale)
//{
//    model_levelshifter();
//}
