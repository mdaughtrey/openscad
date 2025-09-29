ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

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

module model_board(anchor=CENTER,spin=0,orient=UP)
{
    module model_board_()
    {
        rmtag="vcq3rdsa";
        diff(rmtag)
        cuboid([2000, 2030, 115],rounding=50,edges="X")
        {
            tag(rmtag)
            position(TOP) up(1) cuboid([128, 980, 117],anchor=TOP);
        }
    }
    attachable(anchor,spin,orient,size=[2000,2030,115])
    {
        model_board_();
        children();
    }
}

module insert(anchor=CENTER,spin=0,orient=UP,num_boards=1)
{
    module insert_()
    {
        cuboid([120,950,200+120*num_boards],rounding=40,edges="Z")
        position(TOP) cuboid([300,1100,150],rounding=80,edges="Z",anchor=BOT);
    }
    attachable(anchor,spin,orient,size=[300,1100,200+120*num_boards])
    {
        insert_();
        children();
    }
}


module board_clip(anchor=CENTER,spin=0,orient=UP,length=2030,num_boards=1)
{
    module board_clip_()
    {
        rmtag="vt4r23";
        diff(rmtag)
        rect_tube(isize=[2040,120*num_boards],wall=100,h=length)
        {
            tag(rmtag) position(BACK) back(1) cuboid([1140,102,330],rounding=80,edges="Y",anchor=BACK);
            tag(rmtag) position(FRONT) fwd(1) cuboid([1010,102,128],rounding=50,edges="Y",anchor=FRONT);
            position(BACK+RIGHT) fwd(50) wire_holder(anchor=FRONT+RIGHT);
        }
    }

    attachable(anchor,spin,orient,size=[length,2000,320])
    {
        down(length/2)
        board_clip_();
        children();
    }
}

module wire_holder(anchor=CENTER,spin=0,orient=UP)
{
    module wire_holder_()
    {
        rmtag="vqwcrweq";
        diff(rmtag)
        {
            rect_tube(isize=[100,100],h=310,wall=100)
            tag(rmtag) position(LEFT+TOP) left(1) up(1) cuboid([102,55,312],anchor=LEFT+TOP);
        }
    }
    attachable(anchor,spin,orient,size=[300,300,310])
    {
        down(310/2)
        wire_holder_();
        children();
    }
}

module forViewing()
{
    *model_board();
//    *recolor("blue")
///    down(100)
    insert();
    /////zrot(90)
///    board_clip(orient=FRONT,length=2000,num_boards=2);
//    wire_holder();
}

module forPrinting()
{
    insert(num_boards=2);
//    board_clip(num_boards=2,length=3000);
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
