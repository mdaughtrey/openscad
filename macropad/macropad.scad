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


module board_surround(anchor=CENTER,spin=0,orient=UP)
{
    module _board_surround()
    {
        diff()
        cuboid([ssd1306_128_32_length+120,ssd1306_128_32_width+120,50],rounding=100,edges="Z")
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
            cuboid([300,ssd1306_128_32_width,60],anchor=RIGHT+BOT,rounding=50,edges="Z");

            // General Cutout
            tag("remove")
            attach(LEFT+BOT,norot=1)
            right(60)
            cuboid([300,ssd1306_128_32_width,60],anchor=LEFT+BOT,rounding=50,edges="Z");
            
            // Button Surround
            attach(BOT,norot=1)
            rect_tube(140,isize=[490,490],size=[590,ssd1306_128_32_width+120],anchor=TOP)
            tag("remove")
            attach(BOT,norot=1)
            cuboid([600,290,140],anchor=BOT);

            // Skirt
            attach(BOT,norot=1)
            rect_tube(140,size=[ssd1306_128_32_length+120,ssd1306_128_32_width+120],
                wall=60,rounding=100,anchor=TOP); 
        }
    }
    attachable(anchor,spin,orient,size=[ssd1306_128_32_length+120,ssd1306_128_32_width+120,190])
    {
        _board_surround();
        children();
    }
}

module facia(anchor=CENTER,spin=0,orient=UP)
{
    module facia_top(d=120)
    {
        rect_tube(h=50,rounding=d/2,wall=d,isize=[ssd1306_128_32_length-460-d,ssd1306_128_32_width-d])
        attach(TOP,norot=1)

        top_half(s=ssd1306_128_32_length*2)
        {
            ycopies(n=2,spacing=ssd1306_128_32_width)
            cyl(l=ssd1306_128_32_length-460,d=d,orient=LEFT)
            {
                attach(TOP) sphere(d=d);
                attach(BOT) sphere(d=d);
            }

            xcopies(n=2,spacing=ssd1306_128_32_length-460)
            cyl(l=ssd1306_128_32_width,d=d,orient=BACK)
            {
                attach(TOP) sphere(d=d);
                attach(BOT) sphere(d=d);
            }
        }
    }
    
    attachable(anchor,spin,orient,
        size=[ssd1306_128_32_length+120,ssd1306_128_32_width+120,145])
    {
        diff()
        cuboid([ssd1306_128_32_length+120,ssd1306_128_32_width+120,145],rounding=100,edges="Z")
        {
            tag("remove") {
                attach(BOT,norot=1) 
                cuboid([ssd1306_128_32_length+20,ssd1306_128_32_width+20,50],
                    rounding=100,edges="Z",anchor=BOT)
                attach(RIGHT+TOP,norot=1) left(230)  
                cuboid([ssd1306_128_32_length-230+20,ssd1306_128_32_width+20,70],
                    anchor=RIGHT+BOT)
                {
                    right(230/2)
                    {
                        tag("keep")
                        {
                            attach(TOP,norot=1) facia_top();
                        }
                        attach(TOP,norot=1) 
                        cuboid([ssd1306_128_32_length-460,ssd1306_128_32_width,26],anchor=BOT);
                    }
                }
             }
        }
        children();
    }
}

module forViewing()
{
    model_ssd1306_128_32();
    facia(anchor=BOT);
    board_surround();
    down(40)
    yrot(180)
    model_pushbutton_flat();
}

module forPrinting()
{
    facia();
    //board_surround();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
//    facia();
}
