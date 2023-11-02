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

module fanmount()
{
    //tube(h=2000,od=holedia-50,wall=100)
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
                //position(TOP) down(1) tube(ir=4570/2,or=4770/2, h=1000,ir2=3840/2,or2=3940/2,anchor=BOT)
                position(TOP) down(1) tube(id1=4570,id2=holedia-20,wall=100,h=1000,anchor=BOT)
                position(TOP) down(1) tube(id=holedia-20,wall=100,h=1000,anchor=BOT);
                tag("remove" ) position(BOT) cylinder(h=201,d=4570,anchor=BOT);
            }
        }
        tag("remove") down(1) position(BOT) cuboid([4730,4730,1002],rounding=250,edges="Z",anchor=BOT);
        }
    }
}

module pipemount()
{
    $fn=96;

    diff()  {
        conv_hull("remove") {
            tube(h=200,od=holedia+200,id=holedia-450)
            xcopies(n=2,l=holedia+800) cyl(d=600,h=200);
            tag("remove") xcopies(n=2,l=holedia+800) cyl(d=200,h=300);
            tag("remove") cyl(h=3000,d=holedia-400);
        }
        up(99) tube(h=1000,od=holedia-50,wall=100,anchor=BOT);
        down(99) tube(h=1000,od=holedia-50,wall=100,anchor=TOP);
    }
}

module outervent_0()
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
        tag("remove") attach(TOP) zrot(-45) xcopies(n=2,l=5000) cyl(h=600,d=180,anchor=TOP);
        // tube holder
        attach(BOT,overlap=1) cuboid([5000,5000,500],anchor=BOT) {
            tag("remove") attach(TOP) zrot(45) xcopies(n=2,l=5000) cyl(h=400,d=500,anchor=TOP);
            edge_mask(["Z"]) rounding_edge_mask(l=500,r=rounding);
            // frame for duct
           attach(TOP) up(1) cuboid([5000,5000,1000],anchor=BOT) {
            edge_mask(["Z"]) rounding_edge_mask(l=1000,r=rounding);
                tag("remove") cuboid([4600,4600,1010]);
                // duct cover
                *attach(TOP) wedge([5000,5000,2000],spin=180,anchor=BOT) {
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

module outervent_1()
{
    $fn=96;
    angle=5;
    rounding=200;
    rect_tube(isize=5040,size=5440,l=1000,rounding=rounding,irounding=rounding)
    attach(TOP, overlap=1) diff() {
        rect_tube(isize=4640,size=5440,l=100,rounding=rounding,irounding=rounding,anchor=BOT)
        attach(TOP) wedge([5440,5440,2000],anchor=BOT) {
            edge_mask(["Z"],except=[FRONT]) rounding_edge_mask(l=2000,r=rounding);
            xrot(-20.18) down(999)
            edge_mask([TOP+LEFT,TOP+RIGHT]) rounding_edge_mask(l=5800,r=rounding);
            tag("remove") attach(BOT,norot=1) fwd(200)
            wedge([5040,5240,1900],anchor=BOT);
            attach(FRONT, overlap=1) fwd(50) cuboid([5440,2100,200],anchor=BOT) {
                edge_mask([TOP]) rounding_edge_mask(l=5700,r=rounding);
                tag("remove") grid_copies(300, n=[16,5], size=[5440,2000])
                    cuboid([200,200,220]);
            }
        }
    }
}

module masktest()
{
    diff()
    cuboid([1000,1000,1000])
    edge_mask([TOP,"Z"])
    rounding_edge_mask(l=1000,r=100);
}

module fan_and_pipe_mount()
{
    diff() {
        cuboid([4930,4930,1000],rounding=300,edges="Z")   {
        {
            position(TOP) cuboid([4930,4930,200],rounding=300,edges="Z",anchor=BOT)
            {
                ofs=365;
                tag("remove") down(1) left(ofs) fwd(ofs) position(RIGHT+BACK) cyl(d=200, h=1003);
                tag("remove") down(1) right(ofs) fwd(ofs) position(LEFT+BACK) cyl(d=200, h=1003);
                tag("remove") down(1) left(ofs) back(ofs) position(RIGHT+FRONT) cyl(d=200, h=1003);
                tag("remove") down(1) right(ofs) back(ofs) position(LEFT+FRONT) cyl(d=200, h=1003);
                //position(TOP) down(1) tube(ir=4570/2,or=4770/2, h=1000,ir2=3840/2,or2=3940/2,anchor=BOT)
                position(TOP) down(1) tube(id1=4570,od=4870,id2=holedia-400,od2=holedia+200,h=1000,anchor=BOT)
//                position(TOP) down(1) tube(id=holedia-20,wall=100,h=1000,anchor=BOT)
                attach(TOP) {
                    conv_hull("remove") {
                        cyl(h=200,d=holedia+200,anchor=BOT) {
                        xcopies(n=2,l=holedia+1800) cyl(d=600,h=200);
                        tag("remove") attach(CENTER) xcopies(n=2,l=holedia+1800)
                        cyl(d=200,h=300,anchor=CENTER);
                        tag("remove") cyl(h=205,d=holedia-400);
                        }
                    }
                    up(99) tube(h=1000,od=holedia-50,wall=100,anchor=BOT);
                }
                tag("remove" ) position(BOT) cylinder(h=201,d=4570,anchor=BOT);
            }
        }
        tag("remove") down(1) position(BOT) cuboid([4730,4730,1002],rounding=250,edges="Z",anchor=BOT);
        }
    }
}

module forViewing()
{
//    fan_and_pipe_mount();
//    fanmount();
//    up(4000) pipemount();
//    up(6500) outervent();
//    masktest();
//    up(4500)
//    outervent_0();
//    up(2400)
    outervent_0();
//    recolor("cyan") model_fan_120mm();
}

module forPrinting()
{
    outervent_0();
//    fan_and_pipe_mount();
//    outervent_0();
}

scale(ViewScale)
{
   forViewing();
//    forPrinting();
}
