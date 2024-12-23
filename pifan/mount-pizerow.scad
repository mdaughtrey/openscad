ViewScale = [0.0254, 0.0254, 0.0254];
include <../models/pizerow.scad>

module mount_pizerow_jaw()
{
    xpos=1140;
    //ypos=472;
    ypos=0;
    for(x=[xpos,-xpos])
    {
        translate([x, ypos, 0])
        {
            difference() 
            {
                union ()
                {
                    circle(250/2, $fn=96);
                    translate([0, 150, 0])
                    square([250, 300], center=true);
                }
                circle(50, $fn=96);
            }
        }
    }
    translate([0, 250, 0])
    square([xpos*2+250, 200], center=true);
}

module mount_pizerow_cutouts()
{
    for(ii = [-1140:400:1140])
    {
        translate([ii+120, 500+250+25, 0])
        circle(80, $fn=96);
    }
}

module mount_pizerow()
{
    for(ii = [0, 169])
    {
        translate([0, 0, ii])
        linear_extrude(100)
        difference()
        {
            mount_pizerow_jaw();
//            mount_pizerow_cutouts();
        }
    }

    translate([0, 0, 99])
    linear_extrude(70)
    difference()
    {
        translate([0, 250, 0])
        square([2280+250, 200], center=true);
//        mount_pizerow_cutouts();
    }
}

//scale(ViewScale)
//{
//    mount_pizerow();
//}
//*translate([0, 0, 2.54])
//pizerow();
