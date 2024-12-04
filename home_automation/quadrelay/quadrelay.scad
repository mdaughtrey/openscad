ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>
include <../../models/esp8266_d1_min.scad>
include <../../models/quad_relay_board.scad>

$fn = 96;

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
    model_esp8266_d1_min()
    attach(FRONT, norot=1)
    model_quad_relay_board(anchor=BACK);
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
