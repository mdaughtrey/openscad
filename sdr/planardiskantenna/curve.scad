ViewScale = [0.0254, 0.0254, 0.0254];
include <inner.dat>
include <outer.dat>

module inner()
{
    xshift = [for(ii=[len(inner)-1:-1:0]) [inner[ii].x-100,inner[ii].y+100]];
    ppoints = concat(inner,xshift);
    rotate_extrude(angle = 15, convexity=2, $fn=96)
    intersection()  {
        translate([5000, 0, 0])
        square([1560, 800]);
        polygon(points=ppoints);
    }
}

module outer()
{
    xshift = [for(ii=[len(outer)-1:-1:0]) [outer[ii].x,outer[ii].y-100]];
    ppoints = concat(outer,xshift);
    rotate_extrude(angle = 15, convexity=2, $fn=96)
    translate([-1560-6189, 100, 0])
    intersection()  {
        translate([0, -200, 0])
        square([1560, 800]);
        polygon(points=ppoints);
    }
}

scale(ViewScale)
{
    //inner();
    outer();
}
