ViewScale = [0.0254, 0.0254, 0.0254];

$fn=16;
include <BOSL2-master/std.scad>

scale(ViewScale)
{
//    tube(id=25/64*1000,od=750,h=50);
    tube(od=550,id=410,h=200)
    {
        zrot_copies(n=4) right(250) cuboid([200,80,200]);
    }
}
