//ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>

ssd1306_128_64_width=1086;
ssd1306_128_64_length=1100;

module model_ssd1306_128_64()
{
    recolor("steelblue")
    diff()
    cuboid([ssd1306_128_64_length,ssd1306_128_64_width,45])  {
        tag("remove")  {
            attach(BOT,norot=1) grid_copies([919,943]) cyl(d=80,h=75,anchor=BOT);
        }
        tag("keep") {
            // Display
            attach(FRONT+TOP,norot=1) back(187) recolor("black") cuboid([1050,757,62], anchor=BOT+FRONT);
            // Connector
            attach(BACK+BOT,norot=1) fwd(28) recolor("black") cuboid([322,95,315], anchor=TOP+BACK);
        }
    }
}

// module forViewing()
// {
//     model_ssd1306_128_64();
// }
// 
// scale(ViewScale)
// {
//    forViewing();
// }
