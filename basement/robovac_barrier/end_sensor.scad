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

module model_button(anchor=CENTER,spin=0,orient=UP)
 {
     module model_button_()
     {
        recolor("darkgrey")
        cyl(h=880,d=460)
        position(TOP) cyl(d=700,h=250,anchor=BOT)
        recolor("red")
        position(TOP) cyl(h=150,d=470,anchor=BOT);
     }
     attachable(anchor,spin,orient,r=700,h=1280)
     {
        up(440)
        down(1280/2)
         model_button_();
         children();
     }
 }

module button_holder_round(anchor=CENTER,spin=0,orient=UP)
{
    module button_holder_()
    {
        rect_tube(isize=[480,480],size=[900,900],h=100,irounding=240)
        {
            *position(TOP) rect_tube(size=[800,800], wall=50,h=500,anchor=BOT);
            position(BOT) rect_tube(isize=[800,800], wall=50,h=300,anchor=TOP)
            position(LEFT+BOT) rect_tube(isize=[780,3560],wall=100,h=900,orient=FRONT,anchor=FRONT+RIGHT)
            position(RIGHT+BACK) fwd(1000) left(50) tube(od=400,wall=50,h=1000,orient=BACK,anchor=TOP+LEFT);
        }
    }
    attachable(anchor,spin,orient,size=[560,560,1000])
    {
        button_holder_();
        children();
    }
}

module button_holder_square(anchor=CENTER,spin=0,orient=UP)
{
    module button_holder_()
    {
        rmtag="x1qdxn83";
        diff(rmtag)
        rect_tube(isize=[560,560],size=[800,800],h=40)
        {
            position(TOP) rect_tube(size=[800,800], wall=50,h=500,anchor=BOT);
            position(BOT) rect_tube(size=[800,800], wall=50,h=240,anchor=TOP)
            position(LEFT+BOT) rect_tube(isize=[780,3560],wall=100,h=800,orient=FRONT,anchor=FRONT+RIGHT)
            {
                tag(rmtag) position(BACK) back(20) cyl(d=150, h=200, orient=BACK, anchor=TOP);
                position(RIGHT+BACK) fwd(1600) left(50) tube(od=400,wall=50,h=1000,orient=BACK,anchor=TOP+LEFT);
            }
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
 //   up(240)
//    model_button(orient=DOWN);
//    model_button();
}

module forPrinting()
{
    button_holder_square();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
