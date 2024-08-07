ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>
include <../BOSL2-master/rounding.scad>

$fn=96;

module forViewing()
{
    path = [
        square([1000,1000]),
        move([500,500], p = square([1000,1000]))
    ];
    q = union(path);
    r = round_corners(q,r=100);
    path_sweep(circle(d=100),r,closed=true);
}

scale(ViewScale)
{
    forViewing();
}
