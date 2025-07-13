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

module pipe()
{
    angle=67;
    up(2300) threadcap()
    position(BOT) tube(id=1400,od=1500,l=500,anchor=TOP);
    up(1560) right(875) yrot(-angle) zrot(180) xrot(90) pipe_elbow(angle_2=angle);
    up(284) right(1650) yrot(-angle) tube(id=1400,od=1500,l=2450);
    down(995) right(1200+1628/4*3) xrot(90) pipe_elbow(angle_2=angle);
//    down(1190) right(2080) tube(od2=1500,id2=1400,od1=1250,id1=1150,l=400)
//    position(BOT) tube(od=1250,id=1150,l=2000,anchor=TOP);
    down(995) right(2080+1628/4*3) tube(od=1500,id=1400,l=1000,anchor=TOP);
//    up(2500) yrot(90) ruler(length=5000);
//    ruler(length=5000);
}


module case()
{
}

module forViewing()
{
    //threadcap();
    pipe();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
