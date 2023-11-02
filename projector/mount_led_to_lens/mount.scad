ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>
include <../../BOSL2-master/walls.scad>

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

module hood(anchor=CENTER,spin=0,orient=UP)
{
    $fn=96;
    diff()
    cuboid([3900,4400,200],rounding=175,edges="Z") {
        tag("remove") down(1) attach(BOT,norot=1) {
            back(1990) left(750) cyl(d=175,h=204,anchor=BOT);
            back(1990) right(750) cyl(d=175,h=204,anchor=BOT);

            fwd(1990) left(891) cyl(d=175,h=204,anchor=BOT);
            fwd(1990) right(891) cyl(d=175,h=204,anchor=BOT);

            right(3500/2) ycopies(500,8) cyl(d=175,h=204,anchor=BOT);
            left(3500/2) ycopies(500,8) cyl(d=175,h=204,anchor=BOT);
             fwd(150) down(1) cuboid([2400,2400,202],rounding=180,edges="Z",anchor=BOT);
        }
        tag("keep")
        attach(TOP) fwd(150) rect_tube(h=3250,size=[2500,2500],isize=[2400,2400],
            size2=[1500,1500],isize2=[1350,1350],rounding=50)
        attach(TOP) rect_tube(h=500,size=1500,isize=1400,rounding=50,anchor=BOT);
    }
}

module foot0()
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
        attach(TOP) fwd(150) rect_tube(h=3250,size=[2500,2500],isize=[2400,2400],
            size2=[1500,1500],isize2=[1350,1350],rounding=50)
//        attach(TOP) rect_tube(h=50,size=1500,isize=1300,rounding=50,anchor=BOT)
        attach(TOP) rect_tube(h=500,size=1500,isize=1400,rounding=50,anchor=BOT);
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
//            tag("keep") attach(TOP) cuboid([width,200,500],anchor=TOP);
        }
    }

    attachable(anchor,spin,orient,size=[width,2300,200+25+130])
    {
        down(50+25+275/2) _filmguides();
        children();
    }
}

module led_tube_body_support(anchor=CENTER,spin=0,orient=UP)
{
    module _led_tube_body_support()
    {
        rect_tube(isize=[1520,1520],size=[1620,1620],h=500,rounding=50) {
            attach(RIGHT+BOT,norot=1) 
                rect_tube(isize=[1000,180],size=[1200,380],rounding=100,
                    irounding=50,h=100,anchor=LEFT+BOT);
        }
    }
    module _ltb_arm(anchor=CENTER,spin=0,orient=UP,l=1000,wall=200,h=100)
    {
        attachable(anchor,spin,orient,size=[l,180+wall*2,h])
        {
            diff() { 
                hull() 
                    { left(l/2-wall) cuboid([wall+180,wall+180,h]); // cyl(d=wall+180,h=h);
                        right(l/2-wall) cyl(d=wall+180,h=h); }
                tag("remove") down(1) hull() 
                    { left(l/2-wall) cuboid([180,180,4+h]); // cyl(d=180,h=4+h);
                        right(l/2-wall) cyl(d=180,h=4+h); }
           }
           children();
        }
    }
    attachable(anchor,spin,orient,size=[1720,1620,500])
    {
        rect_tube(isize=[1520,1520],size=[1620,1620],h=500,rounding=50,anchor=CENTER) 
        {
            attach(BACK+RIGHT+BOT,norot=1) left(10) fwd(200) _ltb_arm(anchor=BACK+LEFT+BOT);
            attach(BACK+LEFT+BOT,norot=1) right(10) fwd(200) xflip() _ltb_arm(anchor=BACK+LEFT+BOT);
        }
        children();
    }
}

module stabilizer()
{
    module _tab(anchor=CENTER,spin=0,orient=UP)
    {
        down(50)
        attachable(anchor,spin,orient,size=[500,1900,200])
        {
            diff() cuboid([400,1900,100],rounding=180,edges=[RIGHT+FRONT,RIGHT+BACK])
            {
                tag("keep") ycopies(l=1500,n=2) attach(TOP,norot=1) cuboid([180,180,100],anchor=BOT);
                tag("remove") attach(TOP,norot=1) up(1) cyl(d=180,h=202,anchor=TOP,orient=UP);
            }
            children();
        }
    }
    sparse_wall(h=1900,l=3100,thick=100,strut=200,maxang=45,max_bridge=1500) 
    {
        attach(BACK) _tab(orient=LEFT,anchor=LEFT);
        attach(FRONT) _tab(orient=RIGHT,anchor=LEFT,spin=180);
    }
//    ruler(3500,anchor=CENTER,spin=90,alpha=0.3);
//    ruler(3200,anchor=CENTER,orient=FRONT,spin=90,alpha=0.3);

}

module simple_extender(anchor=CENTER,spin=0,orient=UP,length=2000)
{
    attachable(anchor,spin,orient,size=[1500,1500,length])
    {
        down(length/2)
        collar_inserter(anchor=BOT)
        attach(TOP,overlap=1) rect_tube(h=length-1100,size=1500,isize=1280,rounding=50,anchor=BOT)
        attach(TOP,overlap=1) rect_tube(h=500,size=1500,isize=1400,rounding=50);
        children();
    }
//    ruler(3200,orient=FRONT,spin=90,alpha=0.3);
}


module forViewing()
{
//    simple_extender(length=3500);
//    hood();
//    footmount();
    filmguides(width=1100) {
        attach(LEFT,overlap=1) collar_acceptor(anchor=BOT);
        attach(RIGHT,overlap=1) rect_tube(h=100,size=[1500,1500],isize=[500,400],rounding=50)
        attach(TOP,overlap=1) zflip() collar_inserter(anchor=TOP);
    }

 //   led_tube_body_support();
//    ruler(3000,500);
//    stabilizer();
}

module forPrinting()
{
//    hood();
    stabilizer();
}

scale(ViewScale)
{
    forViewing();
//    forPrinting();
}
