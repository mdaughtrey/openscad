ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>
$fn=96;

idim=3125-100;
moat=500;


module base(anchor=CENTER,spin=0,orient=UP)
{
    
    module base_()
    {
        rmtag="rvc4qv";
        diff(rmtag)
        cuboid([idim+moat*2+200,idim+moat*2+200,200], edges="Z", rounding=1100)
        {
            recolor("cornflowerblue")
            rect_tube(isize=[idim-500,idim-500], irounding=800,rounding=950,wall=300,h=300);
            position(TOP)
            {
                rect_tube(isize=[idim,idim], irounding=1000,rounding=1050,wall=100,h=700)
                {
                    tag(rmtag)
                    {
                        position(BOT)
                        {
                            cuboid([500,idim+300,1000], anchor=BOT);
                            cuboid([idim+300,500,1000], anchor=BOT);
                        }
                    }
                 }
                rect_tube(isize=[idim+moat*2,idim+moat*2], irounding=1000,rounding=1100,wall=100,h=200);
            }
        }
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        base_();
        children();
    }
}

module top(anchor=CENTER,spin=0,orient=UP)
{
    
    module top_()
    {
        rmtag="rvc4qv";
        diff(rmtag)
        cuboid([idim+moat*2+200,idim+moat*2+200,200], edges="Z", rounding=1100)
        {
            position(TOP)
            {
                rect_tube(isize=[idim,idim], irounding=1000,rounding=1050,wall=100,h=700)
                {
                    tag(rmtag)
                    {
                        position(BOT)
                        {
                            top_half(s=idim+200) cuboid([1000,idim+300,200],edges="Y", rounding=100);
                            top_half(s=idim+200) cuboid([idim+300,1000,200],edges="X", rounding=100);
                        }
                    }
                 }
                rect_tube(isize=[idim+moat*2,idim+moat*2], irounding=1000,rounding=1100,wall=100,h=200);
            }
        }
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        top_();
        children();
    }
}

//module bottom(anchor=CENTER,spin=0,orient=UP)
//{
//    module bottom_()
//    {
//    }
//    attachable(anchor,spin,orient,size=)
//    {
//        bottom_();
//        children();
//    }
//}


scale(ViewScale)
{
//    top();
    base();
}
