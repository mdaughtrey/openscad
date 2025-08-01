ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>
include <../BOSL2-master/threading.scad>

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

module pipe_elbow(radius=1500/2, 
        inner_radius=1400/2,
        bend_radius=300/2,
        angle_1=0,
        angle_2=45,
        length_1=1000,
        length_2=1000)
{
    path=arc(n=floor(angle_2/2),r=bend_radius+(radius+inner_radius)/2,angle=angle_2);
    echo("path ",path);
    path_sweep(
        ring(n=96,r1=inner_radius,r2=radius),
        path
);

}


module threadcap(anchor=CENTER,spin=0,orient=UP)
{
    module threadcap_()
    {
        rmtag="1234h53";
        diff(rmtag)
        //threaded_rod(d=1866,l=500,pitch=80)
        //threaded_rod(d=[1500,65,1628],l=500,pitch=80)
        threaded_rod(d=1628,l=500,pitch=80)
        {
            tag(rmtag) cyl(d=1400,l=500);
//            tag("keep") position(BOT) cuboid([1600,200,200],anchor=BOT);
        }
    }
    attachable(anchor,spin,orient,d=1866,h=500)
    {
        threadcap_();
        children();
    }
}

module male_thread(anchor=CENTER,spin=0,orient=UP)
{
    module male_thread_()
    {
        rmtag="134h53";
        diff(rmtag)
        //threaded_rod(d=1866,l=500,pitch=80)
        //threaded_rod(d=[1500,65,1628],l=500,pitch=80)
        threaded_rod(d=1620,l=350,pitch=87)
        {
            tag(rmtag) cyl(d=1100,l=500);
//            tag("keep") position(BOT) cuboid([1500,200,200],anchor=BOT);
        }
    }
    attachable(anchor,spin,orient,d=1866,h=350)
    {
        male_thread_();
        children();
    }
}

// offset 450, height > 4000
module pipe()
{
    angle=10;
    up(2300) male_thread()
    position(BOT) tube(id=1100,od=1200,l=500,anchor=TOP);
    up(1630) right(725) yrot(-angle) zrot(180) xrot(90) pipe_elbow(angle_2=angle,inner_radius=1100/2,radius=1200/2);
    up(384) right(209) yrot(-angle) tube(id=1100,od=1200,l=2300);
    down(865) left(306) xrot(90) pipe_elbow(angle_2=angle,inner_radius=1100/2,radius=1200/2);
//    down(1190) right(2080) tube(od2=1500,id2=1400,od1=1250,id1=1150,l=400)
//    position(BOT) tube(od=1250,id=1150,l=2000,anchor=TOP);
    down(865) right(419) tube(od=1200,id=1100,l=1000,anchor=TOP);
//    down(2000) right(419) flange();
//    up(2500) yrot(90) ruler(length=5000);
//    ruler(length=5000);
}

module main_drain_flange(anchor=CENTER,spin=0,orient=UP)
{
    module flange_()
    {
        tube(od1=1750,od2=1400,id=1230,h=300);
    }
    attachable(anchor,spin,orient,d=1500,h=600)
    {
        up(50)
        down(300)
        flange_();
        children();
    }
}

module flange(anchor=CENTER,spin=0,orient=UP)
{
    module flange_()
    {
        tube(od=1500,id=1100,h=100)
        position(TOP) tube(id=1205,od=1300,h=500,anchor=BOT);
    }
    attachable(anchor,spin,orient,d=1500,h=600)
    {
        up(50)
        down(300)
        flange_();
        children();
    }
}


module case()
{
}

module forViewing()
{
//    main_drain_flange();
    //threadcap();
    pipe();
//    flange();
//    tube(od=1200,id=1100,l=1000)
//    position(BOT)
//    right(1500) flange(anchor=BOT);
//    male_thread();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
