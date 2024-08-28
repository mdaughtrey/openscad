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
    tube(id=1470,h=200,od=1700)
    attach(TOP,norot=1)
    tube(id=1300,id2=1250,od=1700,h=450,anchor=BOT)
    attach(TOP,norot=1)
    tube(id=1250,id2=1040,od=1700,h=1500,anchor=BOT);
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
