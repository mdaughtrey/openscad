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

module vexmount(anchor=CENTER,spin=0,orient=UP)
{
    $fn=96;
    module vexmount_()
    {
        diff()
        cyl(d=380,h=200) 
        {
            tag("remove") cyl(d=180,h=200);
            attach(CENTER,norot=1) cuboid([380,500,200],anchor=BACK) ;
        }
    }
    attachable(anchor,spin,orient,size=[380,690,200])
    {
        back((690/2)-190)
        vexmount_();
        children();
    }
}

module upperlid()
{
    rect_tube(isize=[2580+20,890+20],wall=50,h=260)
    {
        attach(BACK+BOT,norot=1) vexmount(anchor=FRONT+BOT);
        attach(TOP,norot=1) rect_tube(isize=[2580-50,890-50],wall=85,h=350)
        attach(TOP,norot=1)  
        diff()
        cuboid([2700,1010,50],anchor=BOT) 
        {
            tag("remove")
            {
                attach(LEFT+BOT,norot=1) right(160+85/2) cuboid([227+30,397+50,50],anchor=BOT+LEFT);
                attach(BOT,norot=1) cuboid([227+30,397+50,50],anchor=BOT);
                attach(RIGHT+BOT,norot=1) left(146+85/2) cuboid([227+30,397+50,50],anchor=BOT+RIGHT);
            }
        }
    }
}


module forViewing()
{
//    *model_pcb();
//    *down(220)
    upperlid();
    rect_tube(size=[2580,890],h=70,wall=100);
//    vexmount();
}

module forPrinting()
{
    //upperlid();
    rect_tube(size=[2580,890],h=170,wall=100);
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
