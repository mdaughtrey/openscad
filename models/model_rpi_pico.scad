include <../BOSL2-master/std.scad>
rpi_pico_pcb_length = 2020;
rpi_pico_pcb_width = 830;

module model_rpi_pico(anchor=CENTER, spin=0, orient=UP)
{
    module model_rpi_pico_()
    {
        diff("mrp_remove")
        recolor("green")
        cuboid([rpi_pico_pcb_length, rpi_pico_pcb_width, 40])
        {
            // USB Connector
            recolor("silver")
            position(LEFT+TOP) left(70) cuboid([353, 306, 125], spin=90, rounding=50, except=[FRONT, BACK], anchor=BOT+BACK);
            recolor("black") position(LEFT+BACK+TOP)
            {
                // Chips
                move([200,-137,0]) cuboid([100,70,40],anchor=LEFT+BOT)
                position(RIGHT+BOT) move([70,0,0]) cuboid([100,84,40],anchor=LEFT+BOT)
                position(LEFT+FRONT+BOT) move([5,-43,0]) cuboid([80,80,40],anchor=LEFT+BACK+BOT)
                {
                    recolor("saddlebrown") position(LEFT+BACK+BOT) move([-20,0,0]) cuboid([50,80,40],anchor=RIGHT+BACK+BOT);
                    recolor("saddlebrown") position(RIGHT+BACK+BOT) move([20,0,0]) cuboid([50,80,40],anchor=LEFT+BACK+BOT);
                }
                move([878,-280,0]) cuboid([275,275,20],anchor=LEFT+BOT+BACK);
                move([676,-530,0]) cuboid([120,80,30],anchor=LEFT+BOT+BACK);
                // Button
                recolor("silver") move([380,-490,0]) cuboid([165,135,100],anchor=LEFT+BOT+BACK);
                // Crystal
                recolor("silver") move([1310,-440,0]) cuboid([98,127,25],anchor=LEFT+BOT+BACK);
            }



//            position(LEFT+TOP) left(53) cuboid([220, 300, 100], anchor=LEFT+BOT);
//            tag("mrp_remove") attach(BOT, norot=1)
//            grid_copies(size=[1850, 450], n=2) cyl(d=80, h=40, anchor=BOT);
        }
    }
    attachable(anchor,spin,orient,size=[rpi_pico_pcb_length, rpi_pico_pcb_width, 140])
    {
        up(20)
        down(70)
        model_rpi_pico_();
        children();
    }
}
