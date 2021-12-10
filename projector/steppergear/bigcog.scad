ViewScale = [0.0254, 0.0254, 0.0254];
use <../../libs/MCAD/involute_gears.scad>

module cutouts()
{
    difference()
    {
        circle(3000/2, $fn=96);
        circle(1000/2, $fn=96);
        square([3000, 500], center=true);
        square([500, 3000], center=true);
    }
}

module bigcog()
{
    thick = 500;
    cdia = 160;
    difference()
    {
        gear(number_of_teeth=86,
            circular_pitch=140,
            //circular_pitch=100,
            gear_thickness = 265,
            rim_thickness = 265,
            hub_thickness = 375,
            pressure_angle = 25);

            translate([0, 0, -1])
            linear_extrude(300)
            {
                for (ii = [0,90,180,270])
                {
                    #rotate([0, 0, ii])
                    translate([500, 0, 0])
                    circle(cdia/2, $fn=96);
                }
                cutouts();
            }
    }
}

scale(ViewScale)
{
    bigcog();
//    translate([0, 0, 700])
//    linear_extrude(100)
//    square([3500, 100], center=true);
}
