ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>


module case()
{
    diff()
    cuboid([2000,1000,500],rounding=100,edges="Z")
    tag("remove") attach(TOP) cuboid([1600,800,300],anchor=TOP);
    sphere(r=100);
    }
}

module forViewing()
{
    case();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
