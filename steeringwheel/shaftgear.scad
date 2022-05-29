use <../libs/MCAD/involute_gears.scad>

module shaftGear()
{
    cdia = 160;
    difference()
    {
        gear(number_of_teeth=38,
            circular_pitch=140,
            gear_thickness = 275,
           rim_thickness = 275,
            hub_thickness = 375+50,
//            bore_diameter = 326,
            hub_diameter=400,
            bore_diameter=0,
            pressure_angle = 25,
            circles=4,
            circle_diameter=400
            );

            *linear_extrude(500)
            circle(400/2, $fn=96);

            translate([0, 0, -1])
            linear_extrude(600)
            intersection() {
                circle(188/2, $fn=96);
                translate([20, 0, 0])
                square([188, 188], center=true);
            }
    }
}
