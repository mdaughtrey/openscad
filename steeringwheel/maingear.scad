use <MCAD/involute_gears.scad>

module mainGear()
{
    thick = 500;
    cdia = 160;
//    difference()
//    {
        gear(number_of_teeth=38,
            circular_pitch=140,
            //circular_pitch=100,
            gear_thickness = 265,
            rim_thickness = 265,
            hub_thickness = 375,
            bore_diameter = 326,
            pressure_angle = 25);

//            translate([0, 0, -1])
//            linear_extrude(300)
//            {
//                for (ii = [0,90,180,270])
//                {
//                    #rotate([0, 0, ii])
//                    translate([500, 0, 0])
//                    circle(cdia/2, $fn=96);
//                }
//                cutouts();
//            }
//    }
}
