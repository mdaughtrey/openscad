ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

ft = function(in) in * 12 * 1000;
in = function(in) in * 1000;

ikea_shelf = [in(68),in(20), in(72)];

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

module modname(anchor=CENTER,spin=0,orient=UP)
{
    module modname_()
    {
    }
    attachable(anchor,spin,orient,size=[0,0,0])
    {
        modname_();
        children();
    }
}


module layout0()
{
    cuboid([ft(21), in(6), in(84)]) // West
    {
        // Drain
        attach(FRONT+RIGHT+BOT,norot=1) left(in(21)) fwd(in(8))
        cyl(d=in(7),h=in(20), anchor=BACK+BOT);
        // Gas Meter
        attach(FRONT+RIGHT+BOT,norot=1) left(in(84)) up(in(16))
        cuboid([in(36), in(16), ft(3)], anchor=BACK+BOT);
        // Electronics Desk
        recolor("cornflowerblue")
        move([-in(6), -in(6), 0])
        attach(FRONT+RIGHT+BOT,norot=1)
        cuboid([in(24), in(56), in(30)], anchor=BACK+BOT+RIGHT)
        {
            // Microwave Cart
            recolor("Aquamarine")
            attach(FRONT+BOT,norot=1)
            cuboid([in(21),in(15),in(36)], anchor=BACK+BOT);
            // Computer Desk    
            attach(FRONT+LEFT+BOT,norot=1)
            cuboid([in(41), in(26), in(48)], anchor=BACK+BOT+RIGHT);
        }
        attach(RIGHT+FRONT, norot=1)
        cuboid([in(6), ft(12), in(84)],anchor=BACK+LEFT) // North
        attach([LEFT+FRONT], norot=1) left(in(39))
        cuboid([in(72), in(6), in(84)], anchor=BACK+RIGHT) // NE
        recolor("cornflowerblue") attach(BACK+BOT,norot=1)
        cuboid(ikea_shelf, anchor=FRONT+BOT);
        attach(LEFT+FRONT, norot=1)
        cuboid([in(6), ft(16), in(84)],anchor=BACK+RIGHT) // South
        attach(RIGHT+FRONT,norot=1) 
        cuboid([in(34), in(6), in(84)], anchor=BACK+LEFT); // SE
    }
}

module layout()
{
    cuboid([ft(21), in(6), in(84)]) // West
    {
        // Couch
        attach(FRONT+LEFT+BOT, norot=1)
        move([ft(2), -ft(1), 0])
        recolor("Wheat")
        cuboid([in(76), in(36), in(36)], anchor=BACK+LEFT+BOT);
        // Drain
        attach(FRONT+RIGHT+BOT,norot=1) left(in(21)) fwd(in(8))
        cyl(d=in(7),h=in(20), anchor=BACK+BOT);
        // Gas Meter
        attach(FRONT+RIGHT+BOT,norot=1) left(in(84)) up(in(16))
        cuboid([in(36), in(16), ft(3)], anchor=BACK+BOT);
        // Electronics Desk
        recolor("cornflowerblue")
        move([-in(6), -in(6), 0])
        attach(FRONT+RIGHT+BOT,norot=1)
        cuboid([in(56), in(24), in(30)], anchor=BACK+BOT+RIGHT)
        // Chair
        attach(FRONT,norot=1)
        fwd(ft(1)) left(ft(1))
        recolor("orangered")
        cuboid([in(26), in(24), in(56)],anchor=BACK+BOT);

        // Computer Desk    
        recolor("cornflowerblue")
        attach(FRONT+RIGHT+BOT,norot=1) move([-in(72), -in(30), 0])
        cuboid([in(26), in(41), in(48)], anchor=BACK+BOT+RIGHT)
        // Desk
        recolor("aquamarine")
        attach(LEFT+BOT,norot=1) left(in(6))
        cuboid([in(26), in(41), in(30)], anchor=RIGHT+BOT)
        // Microwave Cart
        recolor("Aquamarine")
        attach(LEFT+BACK+BOT,norot=1)
        back(in(6))
        cuboid([in(21),in(15),in(36)], anchor=LEFT+FRONT+BOT);

        attach(RIGHT+FRONT, norot=1)
        cuboid([in(6), ft(12), in(84)],anchor=BACK+LEFT) // North
        {
            // Window
            attach(LEFT+BACK+BOT,norot=1)
            recolor("white") up(ft(5.5)) fwd(in(34))
            cuboid([in(3), in(34), in(20)], anchor=RIGHT+BACK);

            attach([LEFT+FRONT], norot=1) left(in(39))
            cuboid([in(72), in(6), in(84)], anchor=BACK+RIGHT) // NE
            recolor("cornflowerblue") attach(BACK+BOT,norot=1)
            cuboid(ikea_shelf, anchor=FRONT+BOT);
            // Metro Shelf
            attach(LEFT+BACK+BOT,norot=1)
            move([-in(6), -ft(6), 0])
            recolor("cornflowerblue")
            cuboid([in(18), in(24), in(72)], anchor=BACK+RIGHT+BOT)
            // Tool Drawers
            recolor("aquamarine")
            attach(FRONT+BOT, norot=1) fwd(in(6))
            cuboid([in(18), in(18), in(51)], anchor=BACK+BOT);
        }
        attach(LEFT+FRONT, norot=1)
        cuboid([in(6), ft(16), in(84)],anchor=BACK+RIGHT) // South
        attach(RIGHT+FRONT,norot=1) 
        cuboid([in(34), in(6), in(84)], anchor=BACK+LEFT); // SE
    }
}

module forViewing()
{
    layout();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
