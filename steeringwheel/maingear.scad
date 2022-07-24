use <../libs/MCAD/involute_gears.scad>

module mainGear()
{
    thick = 500;
    cdia = 160;
    difference()
    {
        gear(number_of_teeth=38,
            circular_pitch=140,
            gear_thickness = 165,
//           rim_thickness = 265,
            hub_thickness = 365,
//            bore_diameter = 326,
            hub_diameter=400,
            bore_diameter=0,
            pressure_angle = 25,
            circles=4,
            circle_diameter=400
            );

            translate([0, 0, -1])
            linear_extrude(600)
            intersection() {
                circle(250/2, $fn=96);
                translate([27, 0, 0])
                square([250, 250], center=true);
            }


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
    }
}

