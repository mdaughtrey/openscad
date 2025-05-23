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

module cutout(e, o, i)
{
    linear_extrude(e)
    difference()
    {
        circle(o/2, $fn=96);
        circle(i/2, $fn=96);
        square([o, i/2], center=true);
        square([i/2, o], center=true);
    }
}

module bigHerringbone()
{
    circles=0;
    teeth=17*5;
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
        }
        translate([0, 0, -height/2-1])
        {
            linear_extrude(340)
            {
                for (ii = [0,90,180,270])
                {
                    #rotate([0, 0, ii])
                    translate([500, 0, 0])
                    circle(160/2, $fn=96);
                }
                circle(326/2, $fn=96);
            }
            cutout(340, 3400, 800);
        }
    }
    translate([0, 0, height/2])
    linear_extrude(66)
    {
        for (ii = [0,90,180,270])
        {
            rotate([0, 0, ii])
            translate([500, 0, 0])
            difference()
            {
                circle(360/2, $fn=96);
                circle(160/2, $fn=96);
            }
        }
        difference()
        {
            circle(526/2, $fn=96);
            circle(326/2, $fn=96);
        }
    }
}


scale(ViewScale)
{
    //sg_forViewing();
    //translate([0, 0, 1000])
    bigHerringbone();

//    steppergear();
//    color("CornflowerBlue")
//    square([762, 762], center=true);
}
