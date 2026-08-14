ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>
include <../../models/model_esp32_devkit_v1.scad>
include <../../models/nodes_and_edges.scad>

esp32_holes = [
    [0, 0, 0], // 0
    [930, 0, 0], // 1
    [0, -1840, 0], // 2
    [930, -1840, 0], // 3
];
 
esp32_nodes = [];
//   [930/2, 0, 0], // 4
//   [930/2, -1840, 0], // 5
//];
 
esp32_edges = [
    [0,1],
    [2,3],
//    [4,1,5],
//    [5,3]
];

box_width=1500;
box_length=2700;
box_height=1000;

module box(anchor=CENTER,spin=0,orient=UP)
{
    module box_()
    {
        rmtag="rc54123q";
        diff(rmtag)
        cuboid([box_width, box_length, 50], edges="Z", rounding=50)
        {
            position(BOT)
            spacer(holes=esp32_holes,nodes=esp32_nodes,edges=esp32_edges, lower_space=200, hole_id=70, anchor=TOP);
            tag(rmtag)
            position(TOP) up(1) cuboid([300, box_length-1000, 52], edges="Z", rounding=100, anchor=TOP);
            position(BOT)
            rect_tube(size=[box_width, box_length], h=box_height-50, anchor=TOP, rounding=50, wall=50)
            {
                tag(rmtag) position(LEFT+TOP+FRONT)
                translate([1180, 65, -400]) cuboid([200,70,1100], anchor=TOP+BACK, edges="Y", rounding=100);
                tag(rmtag)
                {
                    position(LEFT+TOP) translate([-1, 0, -600])
                    cuboid([52, box_length-1000, 200], edges="X", rounding=100, anchor=LEFT);
                    position(RIGHT+TOP) translate([1, 0, -600])
                    cuboid([52, box_length-1000, 200], edges="X", rounding=100, anchor=RIGHT);
                }
                position(LEFT+BOT)
                cuboid([500, box_length-500, 150], edges=[FRONT+LEFT,BACK+LEFT], rounding=100, anchor=RIGHT+BOT)
                {
                    tag(rmtag) up(1)  position(TOP+BACK) fwd(300) cyl(d=200,h=152, anchor=TOP);
                    tag(rmtag) up(1)  position(TOP+FRONT) back(300) cyl(d=200,h=152, anchor=TOP);
                }
                position(RIGHT+BOT)
                cuboid([500, box_length-500, 150], edges=[FRONT+RIGHT,BACK+RIGHT], rounding=100, anchor=LEFT+BOT)
                {
                    tag(rmtag) up(1)  position(TOP+BACK) fwd(300) cyl(d=200,h=152, anchor=TOP);
                    tag(rmtag) up(1)  position(TOP+FRONT) back(300) cyl(d=200,h=152, anchor=TOP);
                }
            }
        }
    }
    attachable(anchor,spin,orient,size=[box_width,box_length,box_height])
    {
        box_();
        children();
    }
}

module lid(anchor=CENTER,spin=0,orient=UP)
{
    module lid_()
    {
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        lid_();
        children();
    }
}


module forViewing()
{
    model_esp32_devkit_v1()
    position(FRONT+TOP+RIGHT) 
    { 
        translate([-100,180,70]) cyl(d=140,l=1000,orient=RIGHT);
        translate([-100,180,-120]) cyl(d=140,l=1000,orient=RIGHT);
        translate([-100,200,-250]) cuboid([1000,200,120],edges="X", rounding=20);
    }
    up(400)
    box(spin=90);
}

module forPrinting()
{
    box();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
