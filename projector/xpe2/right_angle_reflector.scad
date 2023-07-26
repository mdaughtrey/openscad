ViewScale = [0.0254, 0.0254, 0.0254];
include <collars.scad>
include <../../BOSL2-master/std.scad>

module case()
{
    module pipe0()
    {
        $fn=96;
        difference()  {
            tube(od=1600,id=1360,h=1600,anchor=BOT);
            tag("remove") right(800) yrot(-45) cube([1200,2000,2400],anchor=LEFT+BOT);
            tag("remove") left(800) yrot(45) cube([1200,2000,1400],anchor=RIGHT+BOT);
        }
        intersection() {
            cyl(d=1600,h=1600,anchor=BOT);
            left(800) yrot(45) cube([100,2000,1132],anchor=RIGHT+BOT);
        }
    }
    tabbed_collar(h=400,anchor=TOP);
    pipe0();
    right(799) up(799) yrot(-90) zrot(180) pipe0();
    right(799)   yrot(90) tabbed_accept_collar(anchor=BOT+RIGHT);

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
