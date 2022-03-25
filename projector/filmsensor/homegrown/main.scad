ViewScale = [0.0254, 0.0254, 0.0254];
include <model_optosensor.scad>
include <../../../models/veroboard.scad>
include <../encoder_enclosure.scad>


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
	translate([0, 0, -50])
	linear_extrude(100)
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

module forViewing()
{
    color("gray")
	rotate([0, 90, 0])
	translate([0, -450, -235/2])
    model_optosensor();
    sensorwheel();

    translate([-300, -650, -500])
    rotate([90, 0, 0])
    model_Veroboard(6, 10);

    translate([0, 0, 1000])
    encoder_enclosure();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
