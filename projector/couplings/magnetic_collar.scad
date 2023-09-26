ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>
include <../../BOSL2-master/walls.scad>
include <magnetic_collar_lib.scad>

module forViewing()
{
    if (model) {
        recolor("peachpuff") {
            collar_acceptor();
//            model_magnet_8x3mm();
        }
    }
    recolor("cyan")
    magnetic_collar_v2()
    {
        recolor("palegreen") {
            attach(FRONT+TOP,norot=1) xrot(180) magnetholder(anchor=FRONT+TOP);
            attach(BACK+TOP,norot=1) xrot(180) magnetholder(anchor=BACK+TOP);
            attach(LEFT+TOP,norot=1) xrot(180) magnetholder(anchor=RIGHT+TOP);
            attach(RIGHT+TOP,norot=1) xrot(180) magnetholder(anchor=LEFT+TOP);
        }
    }
}

module forPrinting()
{
    magnetic_collar_v2(thick=100);
    back(400) right(400) magnetholder(anchor=BOT);
    back(400) left(400) magnetholder(anchor=BOT);
    fwd(400) right(400) magnetholder(anchor=BOT);
    fwd(400) left(400) magnetholder(anchor=BOT);
}

scale(ViewScale)
{
    //forViewing();
    forPrinting();
}
