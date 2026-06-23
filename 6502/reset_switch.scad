include <../BOSL2-master/std.scad>
include <../models/model_pcb_pushbuttons.scad>
$fn=96;

modelcolor = 1;
axis_d=1/25.4*2*1000; // switch axis

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

module button(anchor=CENTER,spin=0,orient=UP)
{
    module button_()
    {
        model_pushbutton_6_6(modelcolor=true, height_mm=6.5);
        *position(TOP) up(100)
        model_pushbutton_top(modelcolor=true,anchor=BOT);
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        button_();
        children();
    }
}

module paddle(anchor=CENTER,spin=0,orient=UP)
{
    module paddle_()
    {
        rmtag="rvqrq234e";
        diff(rmtag)
        {   
            x=400;
//            y=400;
//            z=150;
//            wedge([x, y, z])
//            position(FRONT)
//            wedge([x, y, z], spin=180,anchor=FRONT);
            angle=180;
            pie_slice(ang=angle, l=400, r=300, orient=LEFT, center=true,spin=-angle/2)
            {
                tag(rmtag) position(TOP) pie_slice(ang=angle, l=150, r=200, center=true);
                tag(rmtag) position(BOT) pie_slice(ang=angle, l=150, r=200, center=true);
//                zrot(0)
                position(BACK+BOT) fwd(50)
                prismoid(size1=[x, 150], size2=[x, 100], h=600,anchor=BOT+RIGHT,spin=90,orient=BACK);
                tag(rmtag) cyl(d=axis_d,h=x);
            }
            tube(h=x-150,id=axis_d,wall=50,orient=RIGHT);
            
//            color([0.5,0.5,0.5,0.5]) cube([x, y, z]);
//            cuboid([200,1000,400])
//            {
//                position(RIGHT) tag(rmtag) left(100) cyl(r=150,h=400,orient=LEFT,anchor=TOP);
//                position(LEFT) tag(rmtag) right(100) cyl(r=150,h=400,orient=RIGHT,anchor=TOP);
//            }
        }
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        paddle_();
        children();
    }
}

module base(anchor=CENTER,spin=0,orient=UP)
{
    module base_()
    {
        rmtag="rvcq53r";
        diff(rmtag)
        {
            cuboid([400,1000,131])
            {
                tag(rmtag) position(TOP) up(1)
                {
                    fwd(250) cuboid([250, 250, 133], anchor=TOP)
                    {
                        position(TOP+LEFT) translate([30, -145, 1]) cuboid([50,50,250], anchor=TOP);
                        position(TOP+LEFT) translate([30, 145, 1]) cuboid([50,50,250], anchor=TOP);
                        position(TOP+RIGHT) translate([-30, -145, 1]) cuboid([50,50,250], anchor=TOP);
                        position(TOP+RIGHT) translate([-30, 145, 1]) cuboid([50,50,250], anchor=TOP);
                    }
                    back(250) cuboid([250, 250, 133], anchor=TOP)
                    {
                        position(TOP+LEFT) translate([30, -145, 1]) cuboid([50,50,250], anchor=TOP);
                        position(TOP+LEFT) translate([30, 145, 1]) cuboid([50,50,250], anchor=TOP);
                        position(TOP+RIGHT) translate([-30, -145, 1]) cuboid([50,50,250], anchor=TOP);
                        position(TOP+RIGHT) translate([-30, 145, 1]) cuboid([50,50,250], anchor=TOP);
                    }
                }
                position(BOT) up(1) cuboid([400,1000,50], anchor=TOP);
                // Paddle Supports
                position(RIGHT+TOP) cuboid([70, 380, 335-210], anchor=BOT+RIGHT)
                position(TOP) cyl(d=380, h=70, orient=RIGHT)
                tag(rmtag) position(TOP) up(1) cyl(d=axis_d,h=200, anchor=TOP);

                position(LEFT+TOP) cuboid([70, 380, 335-210], anchor=BOT+LEFT)
                position(TOP) cyl(d=380, h=70, orient=RIGHT)
                tag(rmtag) position(TOP) up(1) cyl(d=axis_d,h=200, anchor=TOP);

            }
        }
    }
    attachable(anchor,spin,orient,size=[500,1000,133])
    {
        base_();
        children();
    }
}

module cover(anchor=CENTER,spin=0,orient=UP)
{
    module cover_()
    {
        rmtag="rf15cr";
        diff(rmtag)
        {  
            rect_tube(isize=[405, 1010], wall=30, h=620)
            {
                position(TOP) down(1)
                cuboid([480, 1070, 50], anchor=BOT)
                {
                    position(TOP) prismoid(size1=[580, 1110], size2=[480, 1070], h=50, anchor=TOP);
                    position(TOP)
                    {
                        tag(rmtag) up(1) cuboid([420, 200, 51], anchor=TOP);
                    }
                }
                position(BOT+FRONT) up(181) cuboid([430,100,100], anchor=BOT+FRONT);
                position(BOT+BACK) up(181) cuboid([430,100,100], anchor=BOT+BACK);
                // Front Retention Clip
                position(TOP+FRONT) down(70) wedge([200, 30, 100], anchor=BOT+FRONT, spin=180, orient=BOT)
                tag(rmtag)
                {
                    position(LEFT) back(50) cuboid([20, 150, 130], anchor=LEFT+BACK);
                    position(RIGHT) back(50) cuboid([20, 150, 130], anchor=RIGHT+BACK);
                    position(BOT)  cuboid([200, 150, 15], anchor=TOP);
                }
                // Rear Retention Clip
                position(TOP+BACK) down(70) wedge([200, 30, 100], spin=0, anchor=BOT+FRONT, orient=BOT)
                tag(rmtag)
                {
                    position(LEFT) back(50) cuboid([20, 150, 130], anchor=LEFT+BACK);
                    position(RIGHT) back(50) cuboid([20, 150, 130], anchor=RIGHT+BACK);
                    position(BOT)  cuboid([200, 150, 15], anchor=TOP);
                }
            }

        }
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        cover_();
        children();
    }
}

module panel(anchor=CENTER,spin=0,orient=UP)
{
    module panel_()
    {
        rmtag="r5132df";
        diff(rmtag)
        {
            rect_tube(isize=[470, 1080], wall=300, h=50);
        }
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        panel_();
        children();
    }
}


module reset_switch()
{
    paddle();
    down(250) fwd(250) button();
    down(250) back(250) button();
    down(190) base()
    position(BOT) down(50)
    cover();
}
