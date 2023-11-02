ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>
include <../models/model_rpi3.scad>
include <../models/model_ups_board.scad>
include <../models/model_lionpack.scad>
include <../models/model_fan_caizhu_1inch.scad>
include <../models/model_ssd1306.scad>
include <../models/model_slideswitch.scad>
include <../models/model_pushbuttons.scad>


module case()
{
}

module forViewing()
{
    zrot(180) model_ups_board();
    up(900) xrot(180) model_rpi3();
    up(200) back(500) model_lionpack_120mah();
    up(500) left(2200) yrot(90) model_fan_caizhu_1inch();
    up(1200) left(900) fwd(600) zrot(180)  model_ssd1306_128_64();
    left(1800) fwd(700) up(400) yrot(-90)  model_slideswitch();
    left(1800) back(800) up(400) yrot(-90) model_pushbutton_base(shaftl=200)
    attach(TOP) up(200) recolor("red") model_buttontop();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
