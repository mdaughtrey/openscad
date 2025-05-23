ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>

$fn=96;

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
boardX = 2668;
boardY = 910;
boardZ = 50;

module model_board(anchor=CENTER,spin=0,orient=UP)
{
    x = boardX;
    y = boardY;
    z = boardZ;
    module model_board_()
    {
        cuboid([x, y, 50])
        {
            attach(LEFT+BOT+BACK, norot=1) fwd(223)
            // Sensor tab
            cuboid([280, 350, 50], anchor=RIGHT+BOT+BACK);
            // Components
            recolor("gray")
            attach(TOP, norot=1)
            cuboid([x, y, 303], anchor=BOT);
            // LED
            recolor("red")
            attach(TOP+FRONT+RIGHT, norot=1) left(1693) back(160)
            cyl(d=195, h=465, anchor=BOT);
            // Terminals
            recolor("silver")
            attach(TOP+BACK+RIGHT, norot=1) left(1000) fwd(200)
            cyl(d=179, h=665, anchor=BOT)
            attach(BOT, norot=1)
            fwd(300)
            cyl(d=179, h=665, anchor=BOT);
            // USB-C Connector
            recolor("blue")
            attach(TOP+RIGHT+BACK, norot=1) fwd(180) left(730)
            cuboid([1096, 421, 63], anchor=LEFT+BOT+BACK)
            attach(BOT+RIGHT, norot=1)
            recolor("silver")
            cuboid([290, 422,127], anchor=TOP+RIGHT);
        }
    }
    attachable(anchor,spin,orient,size=[x+280+366, y, z+303])
    {
        down(303/2)
        left((366-280)/2)
        model_board_();
        children();
    }
}

module lid(anchor=CENTER,spin=0,orient=UP)
{
    wall = 50;
    space = 20;
    lidX = boardX + 366 + wall * 2 + space * 2;
    lidY = boardY + wall * 2 + space * 2;

    module lid_()
    {
        rmtag="lid12ADV";
        diff(rmtag)
        cuboid([lidX, lidY, 50],rounding=100, edges="Z")
        {
            tag(rmtag) 
            {
                // LED
                attach(BOT+FRONT+RIGHT, norot=1)
                left(366) back(wall+space)
                left(1693) back(160)
                cyl(d=215, h=105, anchor=BOT);
                // Terminals
                attach(BOT+BACK+RIGHT, norot=1) left(1000) fwd(200)
                left(366) fwd(wall+space)
                cyl(d=199, h=105, anchor=BOT)
                attach(BOT, norot=1)
                fwd(300)
                cyl(d=199, h=105, anchor=BOT);
            }
            // Terminal surrounds
            attach(BOT+BACK+RIGHT, norot=1) left(1000) fwd(200)
            left(366) fwd(wall+space)
            tube(id=219, wall=40, h=303, anchor=TOP)
            {
                attach(BOT, norot=1)
                fwd(300)
                tube(id=219, wall=40, h=303, anchor=BOT);
                // Board support
                attach(TOP, norot=1) left(710) fwd(150)
                tube(id=219, wall=40, h=303, anchor=TOP);
            }

            // Board Surround
            attach(BOT+RIGHT+BACK, norot=1)
            left(366-wall-space)
            rect_tube(isize=[boardX+30,boardY+30], h=353,
                wall=50,
                anchor=TOP+RIGHT+BACK)
            {
                // Sensor Cutout
                tag(rmtag)
                attach(BOT+LEFT+BACK, norot=1) fwd(223+wall+space/2)
                cuboid([100, 370, 50+20], anchor=BOT+LEFT+BACK);
                // USB Cutout
                tag(rmtag)
                attach(BOT+RIGHT+BACK, norot=1) fwd(180+wall+space/2)
                cuboid([100, 450, 166+20], anchor=BOT+RIGHT+BACK);
            }
            // Outer Walls
            attach(BOT, norot=1)
            rect_tube(h=550,size=[lidX, lidY], wall=wall, rounding=100, anchor=TOP)
            {
                tag(rmtag)
                // Sensor Cutout
                tag(rmtag)
                attach(BOT+LEFT+BACK, norot=1) fwd(223+wall+space/2)
                cuboid([100, 370, 270], anchor=BOT+LEFT+BACK);
                // USB Cutout
                tag(rmtag)
                attach(BOT+RIGHT+BACK, norot=1) fwd(180+wall+space/2)
                cuboid([100, 450, 320], anchor=BOT+RIGHT+BACK);
            }
        }
    }
    attachable(anchor,spin,orient,size=[lidX, lidY, 50])
    {
        lid_();
        children();
    }
}

module base(anchor=CENTER,spin=0,orient=UP)
{
    rmtag="avawe4";
    wall = 50;
    space = 20;
    lidX = boardX + 366 + wall * 2 + space * 2;
    lidY = boardY + wall * 2 + space * 2;
    module base_()
    {
        diff(rmtag)
        cuboid([lidX, lidY, 50],rounding=100, edges="Z")
        attach(TOP, norot=1)
        rect_tube(h=190,size=[lidX-wall-space-30, lidY-wall-space-30], wall=wall, rounding=100, anchor=BOT)
        tag(rmtag)
        attach(TOP+RIGHT+BACK, norot=1) fwd(180+wall-space)
        cuboid([100,450,90],anchor=TOP+RIGHT+BACK);
    }
    attachable(anchor,spin,orient,size=[lidX,lidY,50])
    {
        base_();
        children();
    }
}

module sensor_protector(anchor=CENTER,spin=0,orient=UP)
{
    module sensor_protector_()
    {
        rmtag = "afg412qc";
        diff(rmtag)
        cuboid([600,600,230],rounding=100,edges="Z")
        {
            attach(BOT+FRONT, norot=1)
            tag(rmtag)
            cuboid([400,300,230], anchor=BOT+FRONT)
            attach(TOP+BACK, norot=1)
            cuboid([200, 250,100], anchor=FRONT+TOP);
            attach(TOP, norot=1)
            rect_tube(h=100,size=[600,600],wall=50,rounding=100);
        }
    }
    attachable(anchor,spin,orient,size=[600, 600, 160])
    {
        sensor_protector_();
        children();
    }
}


module forViewing()
{
    lid(anchor=RIGHT)
    attach(RIGHT+BOT, norot=1)
    model_board(anchor=TOP+RIGHT);
    down(800)
    base(anchor=RIGHT);
}

module forPrinting()
{
    sensor_protector();
//    base();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
