include <../BOSL2-master/std.scad>

module model_quad_relay_board(anchor=CENTER,spin=0,orient=UP)
{
    module model_quad_relay_board_()
    {
        diff("mqrb_remove")
        recolor("darkblue")
        cuboid([2950, 2188, 62], rounding=150, edges="Z")
        {
            // Terminals
            recolor("dodgerblue")
            attach(TOP+FRONT+LEFT, norot=1) right(210) back(167)
            cuboid([1177, 300, 400], anchor=BOT+FRONT+LEFT);

            recolor("dodgerblue")
            attach(TOP+FRONT+RIGHT, norot=1) left(210) back(167)
            cuboid([1177, 300, 400], anchor=BOT+FRONT+RIGHT);
        
            // Relays
            recolor("dodgerblue")
            attach(TOP+FRONT+LEFT, norot=1) right(182) back(510)
            cuboid([598, 735, 625], anchor=BOT+FRONT+LEFT)
            attach(RIGHT, norot=1) right(66) cuboid([598, 735, 625], anchor=LEFT)
            attach(RIGHT, norot=1) right(66) cuboid([598, 735, 625], anchor=LEFT)
            attach(RIGHT, norot=1) right(66) cuboid([598, 735, 625], anchor=LEFT);
                
            // Optoisolators
            recolor("dimgray")
            attach(BACK+LEFT+TOP, norot=1) right(266) fwd(283)
            cuboid([175, 320, 165], anchor=BOT+BACK+LEFT)
            attach(RIGHT, norot=1) right(487) cuboid([175, 320, 165], anchor=LEFT)
            attach(RIGHT, norot=1) right(487) cuboid([175, 320, 165], anchor=LEFT)
            attach(RIGHT, norot=1) right(487) cuboid([175, 320, 165], anchor=LEFT);

            // Power header
            recolor("dodgerblue")
            attach(BACK+LEFT+TOP, norot=1) right(30) fwd(475)
            cuboid([95, 200, 337], anchor=LEFT+BOT+BACK);

            // I/O header
            recolor("dimgray")
            attach(BACK+LEFT+TOP, norot=1) right(330) fwd(140)
            cuboid([610, 100, 330], anchor=LEFT+BOT+BACK);

            // Mounting holes
            tag("mqrb_remove")
            grid_copies([2675, 1880], n=2)
            cyl(h=65, d=100);
        
            
        }
    }
    attachable(anchor,spin,orient,size=[2950,2188,687])
    {
        up(62/2)
        model_quad_relay_board_();
        children();
    }
}
