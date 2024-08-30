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
    tube(id=1250,h=200,od=1500)
    attach(TOP,norot=1)
    tube(id=1150,id2=1050,od=1500,h=450,anchor=BOT)
    attach(TOP,norot=1)
    tube(id=950,od=1500,h=1000,anchor=BOT);
}

module pipe_tester()
{
    for (ii = [[0,1050],[199,950],[399,850],[599,750]])
    {
        up(ii[0])
        tube(id=ii[1],od=1200,h=200);
    }

}

module motor_tester()
{
    for (ii = [[0,1350],[199,1150],[399,950],[599,750]])
    {
        up(ii[0])
        tube(id=ii[1],od=1500,h=200);
    }

}
module forViewing()
{
    nozzle();
    //pipe_tester();
//    motor_tester();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
