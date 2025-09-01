ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

$fn=96;

// module modname(anchor=CENTER,spin=0,orient=UP)
//  {
//      module modname_()
//      {
//      }
//      attachable(anchor,spin,orient,size=)
//      {
//          modname_();
//          children();
//      }
//  }

module button_holder(anchor=CENTER,spin=0,orient=UP)
{
    module button_holder_()
    {
        rect_tube(isize=[560,560],size=[800,800],h=40)
        {
            position(TOP) rect_tube(size=[800,800], wall=50,h=500,anchor=BOT);
            position(BOT) rect_tube(size=[800,800], wall=50,h=300,anchor=TOP)
            position(LEFT+BOT) rect_tube(isize=[780,3560],wall=100,h=800,orient=FRONT,anchor=FRONT+RIGHT)
            position(RIGHT+BACK) fwd(1600) left(50) tube(od=400,wall=50,h=1000,orient=BACK,anchor=TOP+LEFT);
        }
    }
    attachable(anchor,spin,orient,size=[560,560,1000])
    {
        button_holder_();
        children();
    }
}


module forViewing()
{
    button_holder();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
