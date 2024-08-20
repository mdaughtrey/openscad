ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>

$fn=96;

// module modname(anchor=CENTER,spin=0,orient=UP)
// {
//     module modname_()
//     {
//     }
//     attachable(anchor,spin,orient,size=)
//     {
//         modname_();
//         children();
//     }
// }


module case()
{
}

module forViewing()
{
    //tube(id=142,wall=200, l=500);
    tube(id=100,od=400, l=100)
    attach(TOP, norot=1)
    tube(id=170,od=400, l=200)
    attach(TOP, norot=1)
    tube(id=250,od=400, l=200);
    
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
