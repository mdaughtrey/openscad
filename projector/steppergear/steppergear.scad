ViewScale = [0.0254, 0.0254, 0.0254];
use <../../libs/MCAD/involute_gears.scad>
include <herringbone_gear.scad>

module shaft2d(pad)
{
    sq = 400;
    difference()
    {
        circle(pad+306/2, $fn=96);
        translate([sq/2+306/2-(316-275)+pad/2, 0, 0])
        square([sq, 1000], center=true);
    }

}

//    gear(number_of_teeth=24,
//        circular_pitch=5250,
//        gear_thickness=thick,
//        rim_thickness=thick,
//        rim_width=50,
//        bore_diameter = 316+10,
//        bore_sides = 96,
//        circles=0,
//        circle_diameter = cdia,
//        circle_rim_inner_dia=220,
//        circle_rim_thickness=100,
//        circle_rim_height=300);

module steppergear()
{
    thick = 500;
    difference()
    {
//        linear_extrude(100)
        gear(number_of_teeth=16,
            circular_pitch=140,
            //circular_pitch=100,
            gear_thickness = 500,
            rim_thickness = 500,
            hub_thickness = 500,
            pressure_angle = 25
            );
         //   gear_thickness=100,
          //  pressure_angle=25,
          //  rim_thickness=0);
    //        rim_width=50,
    //        bore_diameter = 316+10,
    //        bore_sides = 96,
    //        circles=0,
    //        circle_diameter = cdia,
    //        circle_rim_inner_dia=220,
    //        circle_rim_thickness=100,
    //        circle_rim_height=300);

    translate([0, 0, -10])
    linear_extrude(thick+20)
//        difference()
//        {
//            circle(400/2, $fn=96);
            shaft2d(10);
//        }
    }


    *linear_extrude(120)
    translate([150, 0, 0])
    square([180, 180], center=true);

    *translate([0, 0, 119])
    linear_extrude(41)
    difference() {
        circle(310, $fn=96);
        difference() {
            circle(90, $fn=96);
            translate([150, 0, 0])
            square([180, 180], center=true);
        }
    }
}

module sg_forViewing()
{
    *color("lightblue")
    linear_extrude(600)
    shaft2d(0);

    *linear_extrude(100)
    difference()
    {
        circle(300, $fn=96);
        shaft2d(5);
    }
    translate([0, 0, 300])
    *steppergear();

    // herringbone_gear(diam=20, number=10, h = 5, orient = 1) {
    difference()
    {
        herringbone_gear( 800, 13, 300, -1);
        translate([0, 0, -10])
        linear_extrude(600)
        shaft2d(5);
    }

    translate([0, 0, 299])
    linear_extrude(200)
    difference()
    {
        circle(500/2, $fn=96);
        shaft2d(10);
    }


}


scale(ViewScale)
{
    sg_forViewing();
//    steppergear();
//    color("CornflowerBlue")
//    square([762, 762], center=true);
}
