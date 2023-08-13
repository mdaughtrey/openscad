ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

holedia = 1000*(3+15/16);
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
    $fn=96;
    screwdia=300;
    tabthick=500;

    diff()  {
        conv_hull("remove") {
            tube(h=200,od=holedia+200,id=holedia-450)
            xcopies(n=2,l=holedia+800) cyl(d=600,h=200);
            tag("remove") xcopies(n=2,l=holedia+800) cyl(d=200,h=300);
            tag("remove") cyl(h=3000,d=holedia-400);
        }
        up(99) tube(h=1000,od=holedia-50,wall=100,anchor=BOT);
        down(99) tube(h=1000,od=holedia-50,wall=100,anchor=TOP);
//        tag("remove") #cyl(d=80,h=200);
    }
//        tag("remove") xcopies(n=2,l=holedia+800) cyl(d=200,h=300);

//        tube(h=1000,od=holedia-50,wall=100)  
//        attach(TOP, overlap=1)
//        attach(TOP,overlap=1) tube(h=1000,od=holedia-50,wall=100,anchor=BOT);
//    }

    *diff()
    tube(h=1000,od=holedia-50,wall=100)  {
        attach(TOP,overlap=1) tube(h=200,od=holedia+1500,id=holedia-450,anchor=BOT) {
            tag("remove") xcopies(n=2,l=holedia+800) cyl(d=200,h=300);
            attach(TOP,overlap=1) tube(h=1000,od=holedia-50,wall=100,anchor=BOT);
        }
    }

    *diff()  {
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
    $fn=96;
    angle=5;
    rounding=200;
    height = adj_ang_to_opp(adj=5000,ang=angle);
    tube(h=2000,od=holedia-50,wall=100)
    attach(TOP)  down(200) diff()
    // Against the wall
    wedge([5000,5000,height],orient=DOWN,center=true) 
    {
        edge_mask(["Z"]) rounding_edge_mask(l=height,r=rounding);
        // tube holder
        attach(BOT,overlap=1) cuboid([5000,5000,500],anchor=BOT) {
            edge_mask(["Z"]) rounding_edge_mask(l=500,r=rounding);
            // frame for duct
           attach(TOP) up(1) cuboid([5000,5000,1000],anchor=BOT) {
            edge_mask(["Z"]) rounding_edge_mask(l=1000,r=rounding);
                tag("remove") cuboid([4600,4600,1010]);
                // duct cover
                attach(TOP) wedge([5000,5000,2000],spin=180,anchor=BOT) {
                    edge_mask(["Z"],except=[FRONT]) rounding_edge_mask(l=2000,r=rounding);
                    xrot(-21.8) down(1000)
                    edge_mask([TOP+LEFT,TOP+RIGHT]) rounding_edge_mask(l=5800,r=rounding);
                    tag("remove") attach(BOT,norot=1) fwd(200)
                    wedge([4600,4800,1900],anchor=BOT);
                    attach(FRONT) fwd(50) cuboid([5000,2100,200],anchor=BOT) {
                        edge_mask([TOP]) rounding_edge_mask(l=5000,r=rounding);
                        tag("remove") grid_copies(300, n=[14,5], size=[5000,2000])
                            cuboid([200,200,220]);
                    }
                }
            }
        }
        tag("remove") cyl(d=holedia-300,3000);
    }

}

module masktest()
{
    diff()
    cuboid([1000,1000,1000])
    edge_mask([TOP,"Z"])
    rounding_edge_mask(l=1000,r=100);
}

module forViewing()
{
//    masktest();
//    outervent();
    pipemount();
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
