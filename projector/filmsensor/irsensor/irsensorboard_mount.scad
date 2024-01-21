ViewScale = [0.0254, 0.0254, 0.0254];
include <../../../BOSL2-master/std.scad>

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

module model_pcb()
{
    recolor("goldenrod")
    cuboid([2580,890,50]) 
    {
        attach(LEFT+TOP,norot=1) right(160) recolor("white") cuboid([227,397,430],anchor=BOT+LEFT) 
        {
            attach(BOT+LEFT,norot=1) up(100) recolor("antiquewhite") cuboid([230,425,505],anchor=BOT+LEFT);
            attach(BOT+RIGHT,norot=1) recolor("darkgray") cuboid([770,500,350],anchor=BOT+LEFT);
        }

        attach(TOP,norot=1) recolor("white") cuboid([227,397,430],anchor=BOT)
        attach(BOT+LEFT,norot=1) up(100) recolor("antiquewhite") cuboid([230,425,505],anchor=BOT+LEFT);

        attach(RIGHT+TOP,norot=1) left(146) recolor("white") cuboid([227,397,430],anchor=BOT+RIGHT)
        {
            attach(BOT+LEFT,norot=1) up(100) recolor("antiquewhite") cuboid([230,425,505],anchor=BOT+LEFT);
            attach(BOT+LEFT,norot=1) recolor("darkgray") cuboid([770,500,350],anchor=BOT+RIGHT);
        }

        attach(BOT,norot=1) recolor("dimgray") cuboid([2190,420,100],anchor=TOP);
    }
}

module forViewing()
{
    model_pcb();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
