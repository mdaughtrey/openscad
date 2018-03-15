ViewScale = [0.0254, 0.0254, 0.0254];
rroll = 500;
dplanethole = 3.5/25.4*1000;

module rods()
{
    for(ii = [0:72:360])
    {
        linear_extrude(500)
        rotate([0, 0, ii])
        translate([rroll,0,0])
        circle(dplanethole/2-10, $fn=96);
    }
}

scale(ViewScale)
{
    translate([0, 0, 50])
    rods();
    linear_extrude(50)
    difference() {
    circle(rroll+100, $fn=96);
    circle(rroll-100, $fn=96);
    }
}
