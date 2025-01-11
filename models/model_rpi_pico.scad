include <../BOSL2-master/std.scad>
rpi_pico_pcb_length = 2020;
rpi_pico_pcb_width = 830;

module model_rpi_pico(anchor=CENTER, spin=0, orient=UP)
{
    module model_rpi_pico_()
    {
        cuboid([rpi_pico_pcb_length, rpi_pico_pcb_width, 40])
        attach(LEFT+TOP, norot=1) left(53) cuboid([220, 300, 100], anchor=LEFT+BOT);
    }
    attachable(anchor,spin,orient,size=[rpi_pico_pcb_length, rpi_pico_pcb_width, 100])
    {
        model_rpi_pico_();
        children();
    }
}
