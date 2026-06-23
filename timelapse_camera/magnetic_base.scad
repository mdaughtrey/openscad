ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>

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

module model_magnet(anchor=CENTER,spin=0,orient=UP)
{
    module model_magnet_()
    {
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        model_magnet_();
        children();
    }
}

module magnetic_base(anchor=CENTER,spin=0,orient=UP,angle=0,turn=0)
{
    module magnetic_base_()
    {
        rmtag="phv24";
        diff(rmtag)
        cuboid([2500, 1000, 800], rounding=50, edges="Z")
        {
            tag(rmtag) position(BOT) up(50) cuboid([2380, 550, 200], anchor=BOT)
                position(TOP) left(1) cuboid([3004, 570, 400], anchor=BOT)
                position(TOP) down(1) cuboid([1300, 500, 202], anchor=BOT, rounding=50, edges="Z");
            position(TOP) back(400) zrot(turn) down(50) xrot(angle) rect_tube(isize=[1420, 825], wall=100, h=1000, anchor=BOT, rounding=50);
            

        }
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        magnetic_base_();
        children();
    }
}


module case()
{
}

module forViewing()
{
    magnetic_base(angle=10, turn=-60);
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
