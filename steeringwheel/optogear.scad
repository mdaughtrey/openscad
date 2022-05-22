ViewScale = [0.0254, 0.0254, 0.0254];
use <../../libs/MCAD/involute_gears.scad>

$fn = 180;
function hb_base_face (r, d, mod) = [for(angle = [0: 360/$fn: 360-360/$fn]) [
    cos(angle)*(r + abs(angle%mod-mod/2)/mod*2*d - d/2),
    sin(angle)*(r + abs(angle%mod-mod/2)/mod*2*d - d/2)
  ]];

module hb_gear_base(diam=20, number=10) {
  render()
    polygon(hb_base_face(diam/2, diam/number*1.5, 360/number));
}

module herringbone_gear(diam=20, number=10, h = 5, orient = 1) {
  render()
    linear_extrude(height = h/2, twist = sign(orient)*90*h/diam)
      hb_gear_base(diam, number);
  translate([0, 0, h/2])
    rotate(-sign(orient) * 90*h/diam)
      render()
        linear_extrude(height = h/2, twist = -sign(orient) * 90*h/diam)
          hb_gear_base(diam, number);
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
            bore_diameter = 326,
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

module bigcogh()
{
    // herringbone_gear(diam=20, number=10, h = 5, orient = 1) {
    //herringbone_gear( 800, 20, 300, -1);
    difference()
    {
        herringbone_gear(4000, 65, 300, -1);
        translate([0, 0, -1])
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
    translate([0, 0, 299])
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

//    thick = 500;
//    cdia = 160;
//    difference()
//    {
//        gear(number_of_teeth=86,
//            circular_pitch=140,
//            //circular_pitch=100,
//            gear_thickness = 265,
//            rim_thickness = 265,
//            hub_thickness = 375,
//            bore_diameter = 326,
//            pressure_angle = 25);
//
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

scale(ViewScale)
{
//    bigcog();
//    translate([0, 0, 500])
    bigcogh();
//    translate([0, 0, 700])
//    linear_extrude(100)
//    square([3500, 100], center=true);
}
