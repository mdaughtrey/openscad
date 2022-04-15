ViewScale = [0.0254, 0.0254, 0.0254];
include <model_optosensor.scad>
include <../../../models/veroboard.scad>
include <../encoder_enclosure.scad>

model = 0;
axleR = 50;

module pie_slice(r=3.0,a=30)
{
  $fn=64;
  intersection() {
    circle(r=r);
    square(r);
    rotate(a-90) square(r);
  }
}

module sensorwheel()
{
	difference()
	{
		union() {
			slices = 7;
			for(ii = [0:180/slices:360])
			{
				rotate([0, 0, ii*2])
				pie_slice(r=600,a=180/slices);
			}
			circle(200);
		}
        square([123, 123], center=true);
//		circle(axleR, $fn=96);
	}

}

module veromount(x,y)
{
    if (model)
    {
        translate([0, 0, -25])
        model_Veroboard(x, y);
    }
    rotate([-90, 0, 0])
    for (ii = [[1,0],[-1,x*100]])
    {
        linear_extrude((2+y) * 100)
        translate([ii[1], 0, 0])
        scale([ii[0], 1, 1])
        difference()
        {
            square([200, 200], center=true);
            translate([50, 0, 0])
            square([140, 75], center=true);
        }
    }

}

module rearmount()
{
    linear_extrude(100)
    difference()
    {
        union()
        {
            difference()
            {
                circle(1520/2, $fn=96);
                circle(1320/2, $fn=96);
            }
            difference()
            {
                union()
                {
                    circle(600/2, $fn=96);
                    for (ii=[0,90,180,270])
                    {
                        rotate([0, 0, ii+45])
                        translate([0, 400, 0])
                        square([150, 600], center=true);
                    }
                }
                circle(433/2, $fn=96);
            }
        }
        translate([0, -600, 0])
        square([300, 400], center=true);

        translate([0, -800, 0])
        square([700, 200], center=true);
    }

    translate([0, 0, -299])
    linear_extrude(300)
    for (ii = [0,90,180,270])
    {
        rotate([0, 0, ii+45])
        translate([650, 0, 0])
        difference()
        {
            circle(210/2, $fn=96);
            circle(60/2, $fn=96);
        }
    }
}


module frontmount()
{
    linear_extrude(100)
    difference()
    {
        union()
        {
            difference()
            {
                circle(1520/2, $fn=96);
                circle(1320/2, $fn=96);
            }
            difference()
            {
                union()
                {
                    circle(600/2, $fn=96);
                    for (ii=[0,120,240])
                    {
                        rotate([0, 0, ii+30])
                        translate([0, 400, 0])
                        square([200, 600], center=true);
                    }
                }
                circle(433/2, $fn=96);
            }
        }
    }

    translate([0, 0, 99])
    linear_extrude(400)
    for (ii = [0:120:360])
    {
        rotate([0, 0, ii])
        translate([546, 0, 0])
        difference()
        {
            circle(210/2, $fn=96);
            circle(60/2, $fn=96);
        }
    }
        //circle(805/2, $fn=96);
        //circle(1640/2, $fn=96);
//    }
}

module support()
{
    linear_extrude(1000)
    intersection()
    {
        difference()
        {
            circle(1520/2, $fn=96);
            circle(1320/2, $fn=96);
        }
        rotate([0, 0, 90])
        pie_slice(r=1520/2,a=15);
    }
}

scale(ViewScale)
{
    if (model)
    {
        color("gray")
        rotate([0, 90, 0])
        translate([0, -550, -235/2])
        model_optosensor();
    }
	translate([0, 0, -50])
	linear_extrude(100)
    sensorwheel();
    *translate([-300, -750, -600])
    rotate([90, 0, 0])
    veromount(6, 10);
    *translate([0, 0, 499])
    frontmount();

    *translate([0, 0, -600])
    rearmount();
    *translate([0, 0, -501])
    support();

    if (model)
    {
        translate([0, 0, 750])
        color("cornflowerblue")
        encoder_enclosure();
    }
}

