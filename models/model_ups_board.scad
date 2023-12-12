//ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>

ups_width=1660;
ups_length=3490;

module model_ups_board(anchor=CENTER,spin=0,orient=UP)
{
    hole_indent=140;
    module model_ups_board_()
    {
        recolor("green")
        diff()
        cuboid([ups_length,ups_width,65])  {
            tag("remove")  {
                attach(BOT,norot=1) grid_copies([3280,1460]) cyl(d=125,h=75,anchor=BOT);
                attach(BOT,norot=1) grid_copies([2850,830]) cyl(d=80,h=75,anchor=BOT);
            }
            tag("keep") {
                // Caps
                for (ii=[[1000,465],[1000,980],[2180,470],[2520,470]]) {
                    attach(FRONT+TOP+LEFT,norot=1) right(ii[0]) back(ii[1]) recolor("silver") cyl(d=260,h=300, anchor=BOT+LEFT+FRONT);
                }
                // Diodes
                for (ii=[[550,550],[550,880],[2260,1000]]) {
                    attach(FRONT+TOP+LEFT,norot=1) right(ii[0]) back(ii[1]) recolor("black") cuboid([320,230,100], anchor=BOT+LEFT+FRONT);
                }
                // Inductor
                attach(BACK+TOP+LEFT,norot=1) right(1500) fwd(350) recolor("dimgray") cuboid([430,430,150], anchor=BOT+LEFT+BACK);
                // Mini USB
                attach(TOP+LEFT,norot=1) left(10) recolor("silver") cuboid([226,300,90], anchor=BOT+LEFT);
            }
        }
    }
    attachable(anchor,spin,orient,size=[ups_length,ups_width,65+470])
    {
        model_ups_board_();
        children();
    }
}

// module forViewing()
// {
//     model_ups();
// //    ethernet();
// }
// 
// module forPrinting()
// {
// }
// 
// scale(ViewScale)
// {
//    forViewing();
// }
