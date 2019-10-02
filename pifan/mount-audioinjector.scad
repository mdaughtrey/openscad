ViewScale = [0.0254, 0.0254, 0.0254];
include <../models/pizerow.scad>

module mount_audioinjector_jaw()
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

module mount_audioinjector_cutouts()
{
    for(ii = [-1140:400:1140])
    {
        translate([ii+120, 500+250+25, 0])
        circle(80, $fn=96);
    }
}

module mount_audioinjector()
{
    for(ii = [0, 169, 356-10, 356+169-10])
    {
        translate([0, 0, ii])
        linear_extrude(100)
        difference()
        {
            mount_audioinjector_jaw();
//            mount_audioinjector_cutouts();
        }
    }

    for (ii=[99, 356-10+99])
    {
        translate([0, 0, ii])
        linear_extrude(70)
        difference()
        {
            translate([0, 250, 0])
            square([2280+250, 200], center=true);
        }
    }

    translate([0, 250, 250])
    linear_extrude(150)
    square([1000, 200], center=true);
}

//scale(ViewScale)
//{
//    mount_audioinjector();
//}
//*translate([0, 0, 2.54])
//pizerow();
