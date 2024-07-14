ViewScale = [0.0254, 0.0254, 0.0254];
include </../BOSL2-master/std.scad>
include <../models/model_ssd1306.scad>
include <../models/pushbutton.scad>

//module modname(anchor=CENTER,spin=0,orient=UP)
//{
//    module modname_()
//    {
//    }
//    attachable(anchor,spin,orient,size=)
//    {
//        modname_();
//        children();
//    }
//}


module board_surround(anchor=CENTER,spin=0,orient=UP)
{
    module _board_surround()
    {
        diff()
        cuboid([ssd1306_128_32_length+120,ssd1306_128_32_width+120,50])
        {
            // Components
            tag("remove")
            right(60) back(60)
            attach(BOT+LEFT+FRONT,norot=1)
            right(475) back(54)
            cuboid([76+50,395+50,60],anchor=BOT+LEFT+FRONT)

            attach(RIGHT,norot=1)
            right(120)
            back(148-75)
            cuboid([76+50,276+50,60],anchor=LEFT)

            attach(RIGHT,norot=1)
            right(211-25)
            cuboid([76+50,275+50,60],anchor=LEFT);

            // Signal Connections
            tag("remove")
            attach(RIGHT+BOT,norot=1)
            left(60)
            cuboid([300,ssd1306_128_32_width,60],anchor=RIGHT+BOT);
            
            // Button Surround
            attach(BOT,norot=1)
            rect_tube(140,isize=[490,490],size=[590,ssd1306_128_32_width+120],anchor=TOP)
            tag("remove")
            attach(BOT,norot=1)
            cuboid([600,290,140],anchor=BOT);

            // Skirt
            attach(BOT,norot=1)
            rect_tube(140,size=[ssd1306_128_32_length+120,ssd1306_128_32_width+120],
                wall=60,anchor=TOP); 
        }
    }
    attachable(anchor,spin,orient,size=[ssd1306_128_32_length+120,ssd1306_128_32_width+120,190])
    {
        _board_surround();
        children();
    }
}

module facia()
{
}

module forViewing()
{
    yrot(180)
    model_pushbutton_flat();
    up(100)
    model_ssd1306_128_32()
    attach(CENTER,norot=1) down(20) board_surround();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
