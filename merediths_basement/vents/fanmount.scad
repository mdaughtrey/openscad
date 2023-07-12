ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

$fn=96;
module case()
{
    diff() {
        cuboid([4100,4100,1000],rounding=400,edges="Z")   {
        {
            position(TOP) cuboid([4100,4100,200],rounding=400,edges="Z",anchor=BOT)
            {
            position(TOP) down(1) tube(ir=4030/2,wall=100,h=1000,anchor=BOT);
            tag("remove" ) position(BOT) cylinder(h=201,d=3500,anchor=BOT);
            }
        }
        tag("remove") down(1) position(BOT) cuboid([3800,3800,1002],rounding=400,edges="Z",anchor=BOT);
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
    case();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
