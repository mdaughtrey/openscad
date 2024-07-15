//ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>

ssd1306_128_64_width=1086;
ssd1306_128_64_length=1100;

ssd1306_128_32_width=482;
ssd1306_128_32_length=1504;

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

module model_ssd1306_128_32(anchor=CENTER,spin=0,orient=UP)
{
    module _model_ssd1306_128_32()
    {
        recolor("steelblue")
        diff()
        cuboid([ssd1306_128_32_length,ssd1306_128_32_width,45])  {
            tag("remove")  {
                attach(BOT+RIGHT,norot=1)
                    left(80)
                    down(1)
                    ycopies(n=4,spacing=100)
                    cyl(d=50,h=78,anchor=BOT);
            }

            tag("keep") {
                // Display
                attach(TOP+LEFT,norot=1) recolor("grey") cuboid([230,433,75], anchor=BOT+LEFT)
                attach(RIGHT,norot=1) recolor("black") cuboid([1043,433,75], anchor=LEFT);
                // Connector
                *attach(BACK+BOT,norot=1) fwd(28) recolor("black") cuboid([322,95,315], anchor=TOP+BACK);
                // Components
                recolor("cyan")
                attach(BOT+LEFT+FRONT,norot=1)
                right(500) back(54)
                cuboid([76,395,20],anchor=TOP+LEFT+FRONT)

                attach(RIGHT,norot=1)
                right(165)
                back(148-54)
                cuboid([76,276,20],anchor=LEFT)

                attach(RIGHT,norot=1)
                right(236)
                cuboid([76,275,20],anchor=LEFT);

            }
        }
    }
    attachable(anchor,spin,orient,size=[ssd1306_128_32_width,ssd1306_128_32_length,120])
    {
        up(45/2)
        _model_ssd1306_128_32();
        children();
    }

}

