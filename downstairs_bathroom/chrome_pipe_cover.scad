ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>

$fn=96;

module cover(anchor=CENTER,spin=0,orient=UP)
{
    module cover_()
    {
        tube(id=1270,wall=50,l=2000)
        position(TOP) tube(id1=1270,id2=1800,wall=50,l=500,anchor=BOT)
        position(TOP) tube(id=1800,wall=50,l=1100,anchor=BOT);
        
        
    }
    attachable(anchor,spin,orient,d=1900,l=3600)
    {
        cover_();
        children();
    }
}


module case()
{
}

module forViewing()
{
    cover();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
