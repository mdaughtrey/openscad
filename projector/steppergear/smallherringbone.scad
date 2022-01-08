ViewScale = [0.0254, 0.0254, 0.0254];
//use <../../libs/MCAD/involute_gears.scad>
use <parametric_involute_gear_v5.0.scad>
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
//    translate([0, 0, 300])
//    *steppergear();

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

module smallHerringbone()
{
    circles=0;
    teeth=17;
    pitch=8300;
    twist=200;
    height=300;

    pressure_angle=30;
    difference()
    {
        union(){
        gear (number_of_teeth=teeth,
            circular_pitch=pitch,
            pressure_angle=pressure_angle,
            clearance = 0.2,
            gear_thickness = height/2,
            rim_thickness = height/2,
            rim_width = 5,
            hub_thickness = height/2,
            hub_diameter=25,
            bore_diameter=0,
            circles=circles,
            twist=twist/teeth);
        scale([1.0, 1.0, -1.0])
        gear (number_of_teeth=teeth,
            circular_pitch=pitch,
            pressure_angle=pressure_angle,
            clearance = 0.2,
            gear_thickness = height/2,
            rim_thickness = height/2,
            rim_width = 5,
            hub_thickness = height/2,
            hub_diameter=25,
            bore_diameter=0,
            circles=circles,
            twist=twist/teeth);
        translate([0, 0, height/2-1])
        linear_extrude(200)
            circle(500/2, $fn=96);
        }
        translate([0, 0, -height/2-1])
        linear_extrude(height*2+1)
        shaft2d(5);
    }
}


scale(ViewScale)
{
    //sg_forViewing();
    //translate([0, 0, 1000])
    smallHerringbone();

//    steppergear();
//    color("CornflowerBlue")
//    square([762, 762], center=true);
}
