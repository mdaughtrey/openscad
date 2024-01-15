ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

module modname(anchor=CENTER,spin=0,orient=UP)
{
    module modname_()
    {
    }
    attachable(anchor,spin,orient,size=)
    {
        modname_();
        children();
    }
}


module case()
{
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
