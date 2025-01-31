ViewScale = [0.0254, 0.0254, 0.0254];

shaftR=500;

module mountring90(space,mounts, wiremount)
{
    linear_extrude(500)
    {
        difference()
        {
            circle(shaftR+70, $fn=96);
            circle(shaftR+20, $fn=96);
        }
        for (ii = [0:360/mounts:360])
        {
            rotate([0, 0, ii])
            {
                difference() 
                {
                    translate([shaftR+space/2+80, -200, 0])
                    square([space+100, 300], center=true);
                    circle(shaftR+20, $fn=96);

                    translate([shaftR+space/2+80, -100, 0])
                    square([space+20, 300], center=true);
                }
                translate([shaftR+200, -480, 0])
                difference() 
                {
                    circle(350/2, $fn=96);
                    circle(300/2, $fn=96);
                    rotate([0, 0, 45])
                    translate([100, 0, 0])
                    square([200, 100], center=true);
                }
            }
        }
    }
}

//scale(ViewScale)
//{
//    mountring90(270, 4, 1);
//}
