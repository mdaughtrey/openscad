ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>

$fn=96;

//module modname(anchor=CENTER,spin=0,orient=UP)
//{
//    module modname_()
//    {
//    }
//    attachable(anchor,spin,orient,size=)
//    {
//        modname_();
//        children();
//    }
//}


module nozzle()
{
    tube(id=1370,h=200,od=1700)
    attach(TOP,norot=1)
    tube(id=1200,id2=1150,od=1700,h=450,anchor=BOT)
    attach(TOP,norot=1)
    tube(id=1250,id2=940,od=1700,h=1500,anchor=BOT);
}

module forViewing()
{
    nozzle();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
