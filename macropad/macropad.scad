ViewScale = [0.0254, 0.0254, 0.0254];
include </../BOSL2-master/std.scad>
include <../models/model_ssd1306.scad>
include <../models/pushbutton.scad>

$fn=96;

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


module board_surround(anchor=CENTER,spin=0,orient=UP,twobuttons=0)
{
    l = ssd1306_128_32_length;
    w = ssd1306_128_32_width;

    module _board_surround()
    {
        diff()
        cuboid([l+110,w+110,50],rounding=100,edges="Z")
        {
            // Components
            tag("remove")
            attach(TOP+LEFT,norot=1)
            right(535) 
            cuboid([160,w,50],anchor=TOP+LEFT);

            tag("remove")
            attach(TOP+LEFT,norot=1)
            right(765)
            cuboid([160,w,50],anchor=TOP+LEFT);

            tag("remove")
            attach(TOP+LEFT,norot=1)
            right(1035)
            cuboid([210,w,50],anchor=TOP+LEFT);

            // Signal Connections
            tag("remove")
            attach(RIGHT+BOT,norot=1)
            left(60)
            cuboid([200,w,60],anchor=RIGHT+BOT,rounding=50,edges="Z");

            // Wire Channel
            tag("remove")
            attach(LEFT+BOT,norot=1)
            right(60)
            cuboid([l-60,200,60],anchor=LEFT+BOT);

            // General Cutout
            *tag("remove")
            attach(LEFT+BOT,norot=1)
            right(60)
            cuboid([380,w,60],anchor=LEFT+BOT,rounding=50,edges="Z");
            
            if (twobuttons)
            {
                // Button Surround
                attach(LEFT+BOT,norot=1) right(180)
                rect_tube(140,isize=[480,480],size=[590,w+110],anchor=TOP+LEFT)
                tag("remove")
                attach(BOT,norot=1)
                cuboid([600,290,140],anchor=BOT);

                // Button Surround
                attach(RIGHT+BOT,norot=1) left(180)
                rect_tube(140,isize=[480,480],size=[590,w+110],anchor=TOP+RIGHT)
                tag("remove")
                attach(BOT,norot=1)
                cuboid([600,290,140],anchor=BOT);
            }
            else
            {
                // Button Surround
                attach(BOT,norot=1)
                rect_tube(140,isize=[480,480],size=[590,w+120],anchor=TOP)
                tag("remove")
                attach(BOT,norot=1)
                cuboid([600,290,140],anchor=BOT);

            }
            // Skirt
            attach(BOT,norot=1)
            rect_tube(140,size=[l+110,w+110],
                wall=60,rounding=100,anchor=TOP); 
        }
    }
    attachable(anchor,spin,orient,size=[l+120,w+120,190])
    {
        _board_surround();
        children();
    }
}

module facia(anchor=CENTER,spin=0,orient=UP)
{
    l = ssd1306_128_32_length;
    w = ssd1306_128_32_width;

    module facia_top(d=120)
    {
        rect_tube(h=50,rounding=d/2,wall=d,isize=[l-460-d,w-d])
        attach(TOP,norot=1)

        top_half(s=l*2)
        {
            ycopies(n=2,spacing=w)
            cyl(l=l-460,d=d,orient=LEFT)
            {
                attach(TOP) sphere(d=d);
                attach(BOT) sphere(d=d);
            }

            xcopies(n=2,spacing=l-460)
            cyl(l=w,d=d,orient=BACK)
            {
                attach(TOP) sphere(d=d);
                attach(BOT) sphere(d=d);
            }
        }
    }
    
    attachable(anchor,spin,orient,
        size=[l+120,w+120,175])
    {
        diff()
        cuboid([l+120,w+120,150],rounding=100,edges="Z")
        {
            tag("remove") {
                attach(BOT,norot=1) 
                cuboid([l+20,w+20,60],anchor=BOT)
                attach(RIGHT+TOP,norot=1,overlap=1) left(230)  
                cuboid([l-230+20,w+20,75],
                    anchor=RIGHT+BOT)
                {
                    right(230/2)
                    {
                        tag("keep")
                        {
                            attach(TOP,norot=1) facia_top(); 
                        }
                        attach(TOP,norot=1) 
                        cuboid([l-460,w,26],anchor=BOT);
                    }
                }
             }
        }
        children();
    }
}

module enclosure(anchor=CENTER,spin=0,orient=UP,tapeinsert=0)
{
    l = ssd1306_128_32_length;
    w = ssd1306_128_32_width;

    extra = tapeinsert ? 5 : 0;

    module _enclosure()
    {
        d=120;
        //rect_tube(h=425,isize=[l+140,w+140],irounding=115,wall=30)
        rect_tube(h=475,isize=[l+140+extra,w+140+extra],wall=70-extra)
        attach(TOP,norot=1)
        diff()
        cuboid([l+280-extra,w+280-extra,35],anchor=BOT)
        tag("remove") attach(CENTER)
        cuboid([l-460-d+240+30+extra,w+150-d+110+extra,51],rounding=75,edges="Z");
        //cuboid([l-460-d+240+30+extra,w+150-d+110+extra,51],rounding=75,edges="Z");
    }
    attachable(anchor,spin,orient,
        size=[l+140+extra,w+140+extra,510])
    {
        _enclosure();
        children();
    }
}

module backstop(anchor=CENTER,spin=0,orient=UP)
{
    l = ssd1306_128_32_length;
    w = ssd1306_128_32_width;

    module backstop_()
    {
        diff()
        cuboid([l+140+80,w+140+80,50])
        {
            //attach(TOP,norot=1) cuboid([l+130,w+130,50],anchor=BOT);
            attach(TOP,norot=1) rect_tube(h=50,size=[l+130,w+130],wall=50,anchor=BOT)
            {
                attach(LEFT+BOT,norot=1) right(390/2+180+90)
                cyl(h=50,d=310,anchor=BOT);
                attach(RIGHT+BOT,norot=1) left(390/2+180+90)
                cyl(h=50,d=310,anchor=BOT);
            }
            tag("remove") attach(RIGHT+BOT,norot=1) left(100) cuboid([300,500,101],rounding=100,edges="Z",anchor=BOT+RIGHT);
        }
    }
    attachable(anchor,spin,orient,size=[l+140,w+140,100])
    {
        backstop_();
        children();
    }
}

module buttonblank()
{
    rect_tube(190,size=[ssd1306_128_32_length+120,ssd1306_128_32_width+120],
        wall=60,rounding=100) 
    attach(TOP,norot=1) facia(anchor=BOT);
}

module forViewing()
{
//    backstop();
//    up(400)
    board_surround(twobuttons=1);
}

module forPrinting()
{
//    buttonblank();
//   facia();
    board_surround(twobuttons=1);
//    enclosure();
//    backstop();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
//    facia();
}
