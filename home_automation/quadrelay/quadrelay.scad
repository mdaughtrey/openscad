ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>
include <../../models/esp8266_d1_min.scad>
include <../../models/quad_relay_board.scad>

$fn = 96;

model = 1;

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


module base()
{
    wall = 100;
    outerX = 2950 + 50 + wall * 2;
    outerY = 3398 + 50 + wall * 2;
    diff("base_remove")
    cuboid([outerX, outerY, 100], anchor=BOT, rounding=200, edges="Z")
    {
        // Relay Screw Mounts
        attach(FRONT+TOP, norot=1) back(200+1880/2+50)
        grid_copies([2675, 1880], n=2)
        tube(h=200, od=200, id=100, anchor=BOT);

        // Wall
        attach(TOP, norot=1)
        rect_tube(h=300,size=[outerX, outerY], wall=100, rounding=200, anchor=BOT)

        // Power Cable Cutout
        tag("base_remove")
        attach(TOP+RIGHT+BACK, norot=1) fwd(300) up(50)
        cuboid([100, 200, 300], rounding=50, edges="X", anchor=RIGHT+TOP);

        // Power Cable Strain Relief
        attach(TOP+RIGHT+BACK, norot=1) fwd(200) left(500)
        rect_tube(h=500, size=[400, 400], wall=100, irounding=50, orient=LEFT, anchor=BOT+LEFT+BACK);

        // Interior Mounting Hole
        tag("base_remove")
        attach(BACK+TOP, norot=1) fwd(1000) right(500)
        cyl(h=100, d=150, anchor=BOT);
    }
}

module lid()
{
    wall = 100;
    outerX = 2950 + 300 + wall * 2;
    outerY = 3398 + 300 + wall * 2;
    diff("lid_remove")
    rect_tube(h=450,size=[outerX, outerY], wall=100, rounding=200)
    {
        attach(TOP+BACK, norot=1)
        rect_tube(h=350,size=[outerX, outerY-1550], wall=100, rounding=200, anchor=BOT+BACK)
        attach(TOP, norot=1)
        cuboid([outerX, outerY-1550, 100], rounding=200, edges="Z", anchor=BOT); 
        *tag("lid_remove")
        attach(BOT+FRONT, norot=1)
        cuboid([outerX-650,120,600], anchor=BOT+FRONT);

        // Side Screw Mounts
        attach(RIGHT+BOT, norot=1) cuboid([250, 500,200], anchor=LEFT+BOT)
        attach(RIGHT+BOT,norot=1) cyl(h=200,d=500,anchor=BOT)
        tag("lid_remove") attach(BOT, norot=1) cyl(h=200,d=200,anchor=BOT);

        attach(LEFT+BOT, norot=1) cuboid([250, 500,200], anchor=RIGHT+BOT)
        attach(LEFT+BOT,norot=1) cyl(h=200,d=500,anchor=BOT)
        tag("lid_remove") attach(BOT, norot=1) cyl(h=200,d=200,anchor=BOT);

        // Power Cable Cutout
        tag("lid_remove")
        attach(BOT+RIGHT+BACK, norot=1) fwd(425) down(50) 
        cuboid([100, 200, 400], rounding=50, edges="X", anchor=RIGHT+BOT);
    }
}

module models(anchor=CENTER,spin=0,orient=UP)
{
    module models_()
    {
//        ESP: pcbWidth = 1355; pcbHeight = 1010;
//        Relays: x 2950 y 2188, z 62
    // X = 2950
    // Y = 1010 + 200 + 2188 = 3398
    // H = 676
    // Back = [0, -1010/2]
        model_esp8266_d1_min()
        attach(FRONT+LEFT, norot=1) fwd(200)
        model_quad_relay_board(anchor=BACK+LEFT);
    }
     attachable(anchor,spin,orient,size=[2950, 3398, 687])
     {
        back(3398/2-1010/2)
         models_();
         children();
     }
}

module forViewing()
{
    base();
    up(300) fwd(25) left(125+1355/2) models();
    lid();
}

module forPrinting()
{
    lid();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
