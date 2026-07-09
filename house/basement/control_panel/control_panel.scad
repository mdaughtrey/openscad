ViewScale = [0.0254, 0.0254, 0.0254];
include <../../../BOSL2-master/std.scad>
include <../../../BOSL2-master/hinges.scad>
include <../../../BOSL2-master/joiners.scad>
include <../../../models/nodes_and_edges.scad>
include <../../../models/model_esp32_devkit_v1.scad>
include <toggle_switch.scad>

$fn=64;

models=0;

esp32_holes = [
    [0, 0, 0], // 0
    [930, 0, 0], // 1
    [0, -1840, 0], // 2
    [930, -1840, 0], // 3
];
 
esp32_nodes = [
   [930/2, 0, 0], // 4
   [930/2, -1840, 0], // 5
];
 
esp32_edges = [
    [0,4],
    [2,5],
    [4,1,5],
    [5,3]
];

mcp23017_holes = [
    [0, 0, 0], // 1
    [1750, 0, 0], // 2
    [0, -1550, 0], // 3
    [1750, -1550, 0], // 3
];

mcp23017_nodes= [];

mcp23017_edges = [
    [0, 1, 2],
    [1, 3],
    [2, 3],
];

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

module mounting_box_back_panel(anchor=CENTER,spin=0,orient=UP)
{
    module mounting_box_back_panel_()
    {
        rmtag="rfcr1q2";
        diff(rmtag)
        cuboid([2300, 2200, 100], edges="Z", rounding=100)
        {
            tag(rmtag)
            {
                offset = 182/2+20;
                // Mounting esp32_holes - Left
                translate([offset, -offset, 0]) position(BOT+BACK+LEFT) cyl(d=200, h=51, anchor=BOT)
                position(TOP) down(1) cyl(d=100,h=52,anchor=BOT);
                translate([offset, offset, 0]) position(BOT+FRONT+LEFT) cyl(d=200, h=51, anchor=BOT)
                position(TOP) down(1) cyl(d=100,h=52,anchor=BOT);

                // Mounting esp32_holes - Right
                translate([-offset, -offset, 0]) position(BOT+BACK+RIGHT) cyl(d=200, h=51, anchor=BOT)
                position(TOP) down(1) cyl(d=100,h=52,anchor=BOT);
                translate([-offset, offset, 0]) position(BOT+FRONT+RIGHT) cyl(d=200, h=51, anchor=BOT)
                position(TOP) down(1) cyl(d=100,h=52,anchor=BOT);
            }
        }
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        mounting_box_back_panel_();
        children();
    }
}

module mounting_box(anchor=CENTER,spin=0,orient=UP)
{
    module mounting_box_()
    {
        rmtag="r3215vaw";
        diff(rmtag)
        {
            cuboid([2300, 2200, 100], edges="Z", rounding=100)
            position(BOT) rect_tube(size=[2300, 2200], rounding=100, wall=100, h=816, anchor=TOP)
            {
                offset = 182/2+20;
                tag(rmtag) left(200) position(TOP+RIGHT) cuboid([1530, 2300, 826], anchor=TOP+RIGHT);
                // Mounting Holes - Left
                translate([offset, -offset, 0]) position(TOP+BACK+LEFT) cyl(d=182, h=816, anchor=TOP)
                tag(rmtag) position(TOP) cyl(d=82, h=826, anchor=TOP);
                translate([offset, offset, 0]) position(TOP+FRONT+LEFT) cyl(d=182, h=816, anchor=TOP)
                tag(rmtag) position(TOP) cyl(d=82, h=826, anchor=TOP);

                // Mounting Holes - Right
                translate([-offset, -offset, 0]) position(TOP+BACK+RIGHT) cyl(d=182, h=816, anchor=TOP)
                tag(rmtag) position(TOP) cyl(d=82, h=826, anchor=TOP);
                translate([-offset, offset, 0]) position(TOP+FRONT+RIGHT) cyl(d=182, h=816, anchor=TOP)
                tag(rmtag) position(TOP) cyl(d=82, h=826, anchor=TOP);

                // Mounting Holes - Center
                *translate([200, -offset, 0]) position(TOP+BACK) cyl(d=182, h=816, anchor=TOP)
                tag(rmtag) position(TOP) cyl(d=82, h=826, anchor=TOP);
                *translate([200, offset, 0]) position(TOP+FRONT) cyl(d=182, h=816, anchor=TOP)
                tag(rmtag) position(TOP) cyl(d=82, h=826, anchor=TOP);

                // Dovetail angle
                position(LEFT) up(916/2+50) yrot(15)
                pie_slice(ang=15, r=800, h=2000, orient=FRONT,spin=-90,anchor=CENTER);

                // Dovetail
                //position(LEFT+FRONT) back(100)  yrot(15,cp=[-2300/2,0,50])//  up(100)
                position(LEFT+FRONT) back(100)  yrot(15, cp=[0,0,916/2])  up(100)
                dovetail("male", width=500, height=200, slide=1800, taper=1, orient=LEFT,anchor=FRONT+BOT);
            }
        }
    }
    attachable(anchor,spin,orient,size=[3300,1500,916])
    {
        down(50) up(916/2)
        mounting_box_();
        children();
    }
}

module switch_box_dovetail(anchor=CENTER,spin=0,orient=UP)
{
    module switch_box_dovetail_()
    { 
        rmtag="rf513ac";
        diff(rmtag)
        {
            cuboid([500, 2000, 800], edges="Z", rounding=100)
            position(RIGHT+FRONT) 
            tag(rmtag) dovetail("female", width=500, height=200, slide=1800, taper=1, orient=LEFT,anchor=FRONT+BOT);
        }
    }
    attachable(anchor,spin,orient,size=[500, 2000,800])
    {
        switch_box_dovetail_();
        children();
    }
}

module model_mcp23017(anchor=CENTER,spin=0,orient=UP)
{
    module model_mcp23017_()
    {
        rmtag="rrr351q";
        diff(rmtag)
        cuboid([1900, 1750, 63], rounding=50, edges="Z")
        {
            tag(rmtag) position(TOP) up(1) grid_copies(size=[1750, 1550],n=2) cyl(d=80, h=65, anchor=TOP);
            position(TOP) cuboid([1380, 330, 150], anchor=BOT);
        }
    }
    attachable(anchor,spin,orient,size=[1900, 1750, 63+150])
    {
        model_mcp23017_();
        children();
    }
}

module bottom_panel(anchor=CENTER,spin=0,orient=UP)
{
    module bottom_panel_()
    {
        rmtag="rvrt3q142";
        diff(rmtag)
        {
            cuboid([3300, 4300, 100], edges="Z", rounding=100)
            tag(rmtag) down(1)
            {
                offset = 182/2+20;
                // Mounting esp32_holes - Left
                translate([offset, -offset, 0]) position(BOT+BACK+LEFT) cyl(d=200, h=51, anchor=BOT)
                position(TOP) down(1) cyl(d=100,h=52,anchor=BOT);
                translate([offset, offset, 0]) position(BOT+FRONT+LEFT) cyl(d=200, h=51, anchor=BOT)
                position(TOP) down(1) cyl(d=100,h=52,anchor=BOT);

                // Mounting esp32_holes - Right
                translate([-offset, -offset, 0]) position(BOT+BACK+RIGHT) cyl(d=200, h=51, anchor=BOT)
                position(TOP) down(1) cyl(d=100,h=52,anchor=BOT);
                translate([-offset, offset, 0]) position(BOT+FRONT+RIGHT) cyl(d=200, h=51, anchor=BOT)
                position(TOP) down(1) cyl(d=100,h=52,anchor=BOT);

                // Mounting esp32_holes - Center
                *translate([200, -offset, 0]) position(TOP+BACK) cyl(d=200, h=51, anchor=TOP)
                position(BOT) up(1) cyl(d=100,h=52,anchor=TOP);
                *translate([200, offset, 0]) position(TOP+FRONT) cyl(d=200, h=51, anchor=TOP)
                position(BOT) up(1) cyl(d=100,h=52,anchor=TOP);
            }
            // ESP32 Mount
            position(TOP+FRONT) back(350) 
            spacer(holes=esp32_holes,nodes=esp32_nodes,edges=esp32_edges, anchor=BOT+FRONT, upper_space=50)
            if (models)
            {
                position(TOP) up(50) model_esp32_devkit_v1(anchor=BOT, spin=90);
            }
            // MCP23017 Mount
            position(TOP+BACK) fwd(300) 
            spacer(holes=mcp23017_holes,nodes=mcp23017_nodes,edges=mcp23017_edges, anchor=BOT+BACK, upper_space=50)
            if (models)
            {
                recolor("grey")
                position(TOP) model_mcp23017(anchor=BOT);
            }
        }
    }
    attachable(anchor,spin,orient,size=[3300, 4300, 100])
    {
        bottom_panel_();
        children();
    }
}


module switch_box(anchor=CENTER,spin=0,orient=UP)
{
    module switch_box_()
    {
        rmtag="rv125";
        diff(rmtag)
        {
            cuboid([3300, 4300, 100], edges="Z", rounding=100)
            {
                // Switch Cutouts
                tag(rmtag) position(TOP) up(1)
                {
                    grid_copies(n=[3,3], spacing=[1000,1300]) 
                    {
                        cuboid([420, 200, 110], anchor=TOP);
                        position(BOT) 
                        tag("keep") rect_tube(isize=[500, 1090], h=200, wall=50, anchor=TOP);
                        if (models)
                        {
                            tag("norm") position(BOT) recolor("cornflowerblue") toggle_switch_inside_mount(anchor=TOP);
                        }
                    }
                }
                position(BOT) rect_tube(size=[3300, 4300], rounding=100, wall=100, h=1316, anchor=TOP)
                {
                    position(RIGHT+BOT) switch_box_dovetail(anchor=LEFT+BOT);
                    *position(RIGHT+BOT) orient(anchor=RIGHT) 
                        knuckle_hinge(length=1000, segs=5, offset=300, arm_height=100,
                        pin_diam=200, knuckle_diam=400,anchor=BACK+BOT,spin=180);
                    offset = 182/2+20;
                    *tag(rmtag) left(200) position(TOP+RIGHT) cuboid([1500, 1980, 826], anchor=TOP+RIGHT);
                    // Mounting esp32_holes - Left
                    translate([offset, -offset, 0]) position(TOP+BACK+LEFT) cyl(d=182, h=1316, anchor=TOP)
                    tag(rmtag) position(TOP) cyl(d=82, h=1326, anchor=TOP);
                    translate([offset, offset, 0]) position(TOP+FRONT+LEFT) cyl(d=182, h=1316, anchor=TOP)
                    tag(rmtag) position(TOP) cyl(d=82, h=1326, anchor=TOP);

                    // Mounting esp32_holes - Right
                    translate([-offset, -offset, 0]) position(TOP+BACK+RIGHT) cyl(d=182, h=1316, anchor=TOP)
                    tag(rmtag) position(TOP) cyl(d=82, h=1326, anchor=TOP);
                    translate([-offset, offset, 0]) position(TOP+FRONT+RIGHT) cyl(d=182, h=1316, anchor=TOP)
                    tag(rmtag) position(TOP) cyl(d=82, h=1326, anchor=TOP);

                    // Mounting esp32_holes - Center
                    *translate([200, -offset, 0]) position(TOP+BACK) cyl(d=182, h=816, anchor=TOP)
                    tag(rmtag) position(TOP) cyl(d=82, h=826, anchor=TOP);
                    *translate([200, offset, 0]) position(TOP+FRONT) cyl(d=182, h=816, anchor=TOP)
                    tag(rmtag) position(TOP) cyl(d=82, h=826, anchor=TOP);
                    // USB Connector Cutout
                    tag(rmtag) position(FRONT+BOT) up(120) fwd(1) cuboid([500, 110, 250], edges="Y", rounding=100, anchor=BOT+FRONT);
                }
            }
        }
    }
    attachable(anchor,spin,orient,size=[3300, 4300, 1416])
    {
        down(50) up(916/2)
        switch_box_();
        children();
    }
}


module forViewing()
{
//    switch_box_dovetail();
//    switch_box()
//    down(300)
//    position(BOT) bottom_panel(anchor=TOP);
//    bottom_panel(anchor=TOP);
    mounting_box()
    position(BOT) recolor("cornflowerblue")
    mounting_box_back_panel(anchor=TOP);
}

module forPrinting()
{
//    toggle_switch_inside_mount();
//        cover_inside_mount();
//    switch_box();
//    bottom_panel();
    mounting_box_back_panel();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
