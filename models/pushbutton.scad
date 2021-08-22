module model_pushbutton_flat()
{
    color("CornflowerBlue")
    {

   // linear_extrude(141)
        linear_extrude(40)
        {
            square([470, 470], center=true);
            translate([470/2+167/2, 150/2+20, 0])
            square([167, 40], center=true);
            translate([470/2+167/2, -150/2-20, 0])
            square([167, 40], center=true);

            translate([-470/2-167/2, 150/2+20, 0])
            square([167, 40], center=true);
            translate([-470/2-167/2, -150/2-20, 0])
            square([167, 40], center=true);
        }
        translate([0, 0, 39])
        linear_extrude(101)
        square([470, 470], center=true);
    }
    color("SteelBlue")
    {
        translate([0, 0, 139])
        linear_extrude(11)
        circle(400/2, $fn=96);
    }

    color("PowderBlue")
    {
        translate([0, 0, 149])
        linear_extrude(36)
        circle(310/2, $fn=96);
    }
}
