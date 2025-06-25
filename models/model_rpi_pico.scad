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
            recolor("black")
            attach(LEFT+TOP, norot=1) left(53) cuboid([220, 300, 100], anchor=LEFT+BOT);
            tag("mrp_remove") attach(BOT, norot=1)
            grid_copies(size=[1850, 450], n=2) cyl(d=80, h=40, anchor=BOT);
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
