ViewScale = [0.0254, 0.0254, 0.0254];
include <../../../BOSL2-master/std.scad>

$fn=96;

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


module model_microscope(anchor=CENTER,spin=0,orient=UP)
{
    module model_microscope_()
    {
        recolor("darkgray")
        cyl(d=1540, h=860)
        attach(TOP) recolor("lightgray") cyl(d=1540,h=1970, anchor=BOT)
        attach(TOP) recolor("darkgray") cyl(d=1540,h=630,anchor=BOT);
    }
    attachable(anchor,spin,orient,d=1540,l=3460)
    {
        down(3460/2-860/2)
        model_microscope_();
        children();
    }
}

module collar_acceptor(anchor=CENTER,spin=0,orient=UP)
{
    attachable(anchor,spin,orient,size=[1500,1500,600]) {
        up(50) rect_tube(h=500,size=1500,isize=1400,rounding=50,anchor=CENTER)
            attach(BOT,overlap=1) rect_tube(size=[1500,1500],isize=[500,400],h=100,rounding=50,anchor=BOT);
        children();
    }
}

module collar_inserter(anchor=CENTER,spin=0,orient=UP)
{
    attachable(anchor,spin,orient,size=[1500,1500,600]) {
        down(300)
        union() {
            rect_tube(h=500,size=1380,isize=1280,rounding=50)
            attach(TOP,overlap=1)
            rect_tube(h=100,size=1500,isize=1280,rounding=50,anchor=BOT);
        }
        children();
    }
}

module filmguide(anchor=CENTER,spin=0,orient=UP)
{
    filmguidebase(width=1100) {
        attach(LEFT,overlap=1) collar_acceptor(anchor=BOT);
//        attach(RIGHT,overlap=1) rect_tube(h=100,size=[1500,1500],isize=[700,500],rounding=50);
        *attach(TOP,overlap=1) zflip() collar_inserter(anchor=TOP);
        attach(BOT,norot=1) cuboid([1100,200,570],anchor=TOP);
        *attach(BOT+BACK,norot=1) fwd(500) tube(id=180,od=480,h=570,anchor=TOP);
        *attach(BOT+FRONT,norot=1) back(500) tube(id=180,od=480,h=570,anchor=TOP);
    }
}

module filmguidebase(anchor=CENTER,spin=0,orient=UP,width=1000)
{
    module _filmguidebase() {
        $fn=96;
        diff()
        cuboid([width,2500,100],rounding=450,edges="Z") {
            tag("remove") attach(TOP+BACK,norot=1) fwd(500) up(1) cyl(d=180,h=104,anchor=TOP);
            tag("remove") attach(TOP+FRONT,norot=1) back(500) up(1) cyl(d=180,h=104,anchor=TOP);
            // Support tubes - print separately
            *attach(BOT+BACK,norot=1) fwd(500) tube(id=180,od=480,h=570,anchor=TOP);
            *attach(BOT+FRONT,norot=1) back(500) tube(id=180,od=480,h=570,anchor=TOP);
            tag("keep") attach(TOP+BACK,norot=1) fwd(500) tube(od=400,id=180,h=25,anchor=BOT) {
                attach(TOP) tube(od=300,id=180,h=130,anchor=BOT);
//                attach(TOP) recolor("silver")  tube(od=867,id=315,h=275,anchor=BOT);
            }
            tag("keep") attach(TOP+FRONT,norot=1) back(500) tube(od=400,id=180,h=25,anchor=BOT) {
                attach(TOP) tube(od=300,id=180,h=130,anchor=BOT);
//                attach(TOP) recolor("silver")  tube(od=867,id=315,h=275,anchor=BOT);
            }
//            tag("keep") attach(TOP) cuboid([width,200,500],anchor=TOP);
        }
    }

    attachable(anchor,spin,orient,size=[width,2300,200+25+130])
    {
        down(50+25+275/2) _filmguidebase();
        children();
    }
}

module ms_mount(anchor=CENTER,spin=0,orient=UP)
{
    module ms_mount_()
    {
        diff()
        tube(id=1560,od=1760,h=1350) {
            attach(LEFT+BOT,norot=1) right(100) tube(id=250,od=450,h=1250,anchor=BOT+RIGHT)
            attach(TOP) cyl(d=450,h=50,anchor=BOT);
            attach(RIGHT+BOT,norot=1) left(100) tube(id=250,od=450,h=1250,anchor=BOT+LEFT)
            attach(TOP) cyl(d=450,h=50,anchor=BOT);
            attach(TOP,overlap=1) cyl(h=100,d=1760,anchor=TOP) 
                tag("remove") attach(TOP)  cuboid([700,500,102],anchor=TOP);
        }
    }
    attachable(anchor,spin,orient,d=1740,l=1600)
    {
        ms_mount_();
        children();
    }
}

module vexmount(anchor=CENTER,spin=0,orient=UP)
{
    module vexmount_()
    {
        diff()
        cuboid([1860,200+170,170],rounding=330/2,edges="Z") {
        attach(BOT,norot=1) left(750) tube(id=180,od=370,h=490,anchor=TOP);
        attach(BOT,norot=1) right(750) tube(id=180,od=370,h=490,anchor=TOP);
        attach(TOP,norot=1) left(250) cuboid([170,170,100]);
        attach(TOP,norot=1) right(250) cuboid([170,170,100]);
        tag("remove") attach(TOP,norot=1) left(750) cyl(d=180,h=330,anchor=TOP);
        tag("remove") attach(TOP,norot=1) right(750) cyl(d=180,h=330,anchor=TOP);
        }
    }
    attachable(anchor,spin,orient,size=[2500,370,330])
    {
        vexmount_();
        children();
    }
}

module viewMount()
{
//    model_microscope();
    up(2000) ms_mount()
    attach(TOP,norot=1) up(430) zrot(90) yrot(90)  filmguide();
    fwd(840) up(3300)  xrot(90) vexmount();
}

module forViewing()
{
    viewMount();
}

module forPrinting()
{
//    ms_mount()
//    attach(TOP,norot=1) up(430) zrot(90) yrot(90)  filmguide();
    vexmount();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
