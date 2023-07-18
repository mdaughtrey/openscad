ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

$fn=96;

module model_fan_120mm(anchor=CENTER)
{
    diff()
    cuboid([4700, 4700, 1000], rounding=250, edges="Z", anchor=anchor) {
        tag("remove") down(1) left(250) fwd(250) position(RIGHT+BACK) cyl(d=160, h=1003);
        tag("remove") down(1) right(250) fwd(250) position(LEFT+BACK) cyl(d=160, h=1003);
        tag("remove") down(1) left(250) back(250) position(RIGHT+FRONT) cyl(d=160, h=1003);
        tag("remove") down(1) right(250) back(250) position(LEFT+FRONT) cyl(d=160, h=1003);
        tag("remove") down(1) tube(od=4570, id=1540,h=1003);
    }
}

module case()
{
    diff() {
        cuboid([4930,4930,1000],rounding=300,edges="Z")   {
        {
            position(TOP) cuboid([4930,4930,200],rounding=250,edges="Z",anchor=BOT)
            {
                ofs=365;
                tag("remove") down(1) left(ofs) fwd(ofs) position(RIGHT+BACK) cyl(d=200, h=1003);
                tag("remove") down(1) right(ofs) fwd(ofs) position(LEFT+BACK) cyl(d=200, h=1003);
                tag("remove") down(1) left(ofs) back(ofs) position(RIGHT+FRONT) cyl(d=200, h=1003);
                tag("remove") down(1) right(ofs) back(ofs) position(LEFT+FRONT) cyl(d=200, h=1003);
                position(TOP) down(1) tube(ir=4570/2,or=4770/2, h=1000,ir2=3840/2,or2=3940/2,anchor=BOT)
                position(TOP) down(1) tube(ir=3840/2,or=3940/2,h=3000,anchor=BOT);
                tag("remove" ) position(BOT) cylinder(h=201,d=4570,anchor=BOT);
            }
        }
        tag("remove") down(1) position(BOT) cuboid([4730,4730,1002],rounding=250,edges="Z",anchor=BOT);
        }
    }
//    tube(ir=4030/2,wall=100,h=1000);
//
//
//        {
//        }

//    rect([4000,4000],rounding=400)
//    rect([3800,3800],rounding=385);
//    }
}

module forViewing()
{
    recolor("cyan") model_fan_120mm();
    case();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
