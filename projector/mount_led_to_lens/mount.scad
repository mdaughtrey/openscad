ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

//3200 across 
//3000 up

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

module collar_acceptor(anchor=CENTER,spin=0,orient=UP)
{
    attachable(anchor,spin,orient,size=[1500,1500,600]) {
        up(50) rect_tube(h=500,size=1500,isize=1400,rounding=50,anchor=CENTER)
            attach(BOT,overlap=1) rect_tube(size=[1500,1500],isize=[500,300],h=100,rounding=50,anchor=BOT);
        children();
    }
}

module foot()
{
    $fn=96;
    diff() 
    cuboid([3600,3400,200],rounding=180,edges="Z")
    {
        tag("remove") {
            attach(TOP+BACK+RIGHT,norot=1) left(200) fwd(200) up(1) cyl(d=180,h=202,anchor=TOP,orient=UP);
            attach(TOP+BACK+LEFT,norot=1) right(200) fwd(200) up(1) cyl(d=180,h=202,anchor=TOP,orient=UP);
            attach(TOP+FWD+RIGHT,norot=1) left(200) back(200) up(1) cyl(d=180,h=202,anchor=TOP,orient=UP);
            attach(TOP+FWD+LEFT,norot=1) right(200) back(200) up(1) cyl(d=180,h=202,anchor=TOP,orient=UP);
            attach(TOP) fwd(150) up(1) cuboid([2400,2400,202],rounding=180,edges="Z",anchor=TOP);
        }
        tag("keep")
        attach(TOP) fwd(150) rect_tube(h=4000,size=[2500,2500],rounding=180,size2=[1500,1500],wall=50);
    }
}

module filmguides(anchor=CENTER,spin=0,orient=UP,width=1000)
{
    module _filmguides() {
        $fn=96;
        diff()
        cuboid([width,2300,100],rounding=450,edges="Z") {
            tag("remove") attach(TOP+BACK,norot=1) fwd(500) up(1) cyl(d=180,h=104,anchor=TOP);
            tag("remove") attach(TOP+FRONT,norot=1) back(500) up(1) cyl(d=180,h=104,anchor=TOP);
            tag("keep") attach(TOP+BACK,norot=1) fwd(500) tube(od=400,id=180,h=25,anchor=BOT) {
                attach(TOP) tube(od=300,id=180,h=130,anchor=BOT);
//                attach(TOP) recolor("silver")  tube(od=867,id=315,h=275,anchor=BOT);
            }
            tag("keep") attach(TOP+FRONT,norot=1) back(500) tube(od=400,id=180,h=25,anchor=BOT) {
                attach(TOP) tube(od=300,id=180,h=130,anchor=BOT);
//                attach(TOP) recolor("silver")  tube(od=867,id=315,h=275,anchor=BOT);
            }
            tag("keep") attach(TOP) cuboid([width,200,500],anchor=TOP);
        }
    }

    attachable(anchor,spin,orient,size=[width,2300,200+25+130])
    {
        down(50+25+275/2) _filmguides();
        children();
    }
}

module forViewing()
{
//    foot();

    filmguides(width=1100) {
        attach(LEFT,overlap=1) collar_acceptor(anchor=BOT);
        attach(RIGHT,overlap=1) rect_tube(h=100,size=[1500,1500],isize=[500,400],rounding=50)
        attach(TOP,overlap=1) zflip() collar_inserter(anchor=TOP);
    }


}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
