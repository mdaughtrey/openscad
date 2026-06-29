ViewScale = [0.0254, 0.0254, 0.0254];
include <../../../BOSL2-master/std.scad>
include <../../../models/locking_collar.scad>

$fn=96;
id=5000+(15/16*1000);
od=6125;

module inner_ring(od=5000+(9/16*1000), wall=250)
{
    rmtag="rvqdf34";
    itag="ivqdf34";
    intersection()
    {
        tube(od=od, wall=wall, length=76, anchor=TOP);
        { 
            pie_slice(ang=100,h=76,d=od, anchor=TOP);
            translate([2900,0,0]) zrot(-40) cuboid([5000,1200,76], anchor=RIGHT+FRONT+TOP); 
        }
    }
}

module endring(anchor=CENTER,spin=0,orient=UP)
{
    module endring_()
    {
        tube(id=5000+(5/16*1000), od=od, length=90)
        {
            position(TOP) tube(od=od, id=id, length=430, anchor=BOT) 
            {
                position(TOP) down(70) inner_ring(od=id+20,wall=250);
                zrot(180) position(TOP) down(130) inner_ring(od=id+20,wall=250);
            }
        }
    }
    attachable(anchor,spin,orient,r=od/2,l=520)
    {
        up(45) down(520/2)
        endring_();
        children();
    }
}

module forViewing()
{
    endring()
    position(BOT) 
    locking_collar(od=od,id=id,orient=DOWN,tabout=200);
    recolor("blue")
    down(795)
    zrot(49.5)
    endring(orient=DOWN)
    position(TOP)
    locking_collar(female=true,id=od-10,od=od+110,tabout=200,tabdown=250,h=1000,orient=DOWN,anchor=BOT);
}

module forPrinting()
{
    endring(orient=DOWN)
    position(TOP)
    locking_collar(female=true,id=od-10,od=od+110,tabout=200,tabdown=250,h=1000,orient=DOWN,anchor=BOT);
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
