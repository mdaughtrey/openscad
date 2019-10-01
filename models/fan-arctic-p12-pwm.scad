ViewScale = [0.0254, 0.0254, 0.0254];

module flange()
{
    linear_extrude(198)
    difference()
    {
        square([4710, 4710], center=true);
        circle(4500/2, $fn=96);
        translate([4135/2,4135/2,0])
        circle(175/2, $fn=96);
        translate([4135/2,-4135/2,0])
        circle(175/2, $fn=96);
        translate([4135/2,4135/2,0])
        circle(175/2, $fn=96);
        translate([-4135/2,4135/2,0])
        circle(175/2, $fn=96);
        translate([-4135/2,-4135/2,0])
        circle(175/2, $fn=96);
    }
}

module artic_p12_pwm()
{
    color("Cyan")
    {
        flange();
        translate([0, 0, 197])
        linear_extrude(600)
        {
            difference()
            {
                circle(4690/2, $fn=96);
                circle(4500/2, $fn=96);
            }
            for(ii=[0:90:360])
            {
                rotate([0, 0, 45+ii])
                translate([4690/2+440/2, 0, 0])
                square([440, 85], center=true);
            }
        }
        translate([0, 0, 797])
        flange();
    }
}


//scale(ViewScale)
//{
//    artic_p12_pwm();
//}
