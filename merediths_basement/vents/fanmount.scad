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

module pipemount()
{
    screwdia=300;
    tabthick=500;

    diff()  {
        cyl(d=4160,h=2000,$fn=96,anchor=BOT) {
            position(RIGHT+BOT) conv_hull("remove")
                cyl(d=1000,h=tabthick,$fn=96,anchor=BOT) position(RIGHT) tube(od=1000,id=500,h=tabthick,$fn=96)
                tag("remove") position(BOT) down(1) cyl(d=screwdia,h=tabthick+2,$fn=96,anchor=BOT); 
            position(LEFT+BOT) conv_hull("remove")
                cyl(d=1000,h=tabthick,$fn=96,anchor=BOT) position(LEFT) tube(od=1000,id=500,h=tabthick,$fn=96)
                tag("remove") position(BOT) down(1) cyl(d=screwdia,h=tabthick+2,$fn=96,anchor=BOT); 
        }
        tag("remove") down(1) cyl(d=3960,h=2002,$fn=96,anchor=BOT);
        tag("keep") up(1000) tube(od=4000,id=3800,h=200,$fn=96);
    }
}

module outervent()
{
//    rounding_edge_mask(l=100, r=25, orient=UP, anchor=BOTTOM);
    $fn=96;
    angle=10;
    height = adj_ang_to_opp(adj=5000,ang=10);
    diff()
    // Against the wall
    wedge([5000,5000,height],orient=DOWN,center=true) 
    {
        // tube holder
        attach(BOT,overlap=1) cuboid([5000,5000,500],anchor=BOT) {
            // frame for duct
           attach(TOP) up(1) cuboid([5000,5000,1000],anchor=BOT) {
                tag("remove") cuboid([4600,4600,1010]);
                // duct cover
                attach(TOP) wedge([5000,5000,2000],spin=180,anchor=BOT) {
                    tag("remove") attach(BOT,norot=1) fwd(200) wedge([4600,4800,1900],anchor=BOT);
                    attach(FRONT) cuboid([5000,2000,200],anchor=BOT)
                    tag("remove") grid_copies(300, n=[14,6], size=[5000,2000]) cuboid([200,200,220]);
                }
            }
        }
        tag("remove") cyl(d=3960,3000);
    }

}


module forViewing()
{
    outervent();
//    pipemount();
//    recolor("cyan") model_fan_120mm();
//    case();
}

module forPrinting()
{
    diff() {
        cuboid([4930,4930,100],rounding=300,edges="Z")   
        tag("remove") down(1) position(BOT) cuboid([4730,4730,102],rounding=250,edges="Z",anchor=BOT);
        }
}

scale(ViewScale)
{
    forViewing();
//    forPrinting();
}
