ViewScale = [0.0254, 0.0254, 0.0254];
include <model_optosensor.scad>
include <../../../models/veroboard.scad>
include <../encoder_enclosure.scad>

model = 1;

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
				pie_slice(r=500,a=180/slices);
			}
			circle(200);
		}
		circle(50, $fn=96);
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
    {
        difference()
        {
            circle(1520/2, $fn=96);
            circle(950/2, $fn=96);
        }
        sensorwheel();
    }

    *translate([0, 0, 99])
    linear_extrude(300)
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


module frontmount()
{
    linear_extrude(100)
    {
        difference()
        {
            circle(1520/2, $fn=96);
            circle(950/2, $fn=96);
        }
        sensorwheel();
    }

    translate([0, 0, 99])
    linear_extrude(300)
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

scale(ViewScale)
{
    if (model)
    {
        color("gray")
        rotate([0, 90, 0])
        translate([0, -450, -235/2])
        model_optosensor();
    }
	translate([0, 0, -50])
	linear_extrude(100)
    sensorwheel();
    translate([-300, -650, -600])
    rotate([90, 0, 0])
    veromount(6, 10);
    translate([0, 0, 499])
    frontmount();

    translate([0, 0, -500])
    rearmount();

    if (model)
    {
        translate([0, 0, 1000])
        color("cornflowerblue")
        encoder_enclosure();
    }
}

