ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

//    attachable(anchor,spin,orient,size=[1500,1500,600]) {

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
    attachable(anchor,spin,orient,size=[1500,1500,550]) {
    down(550/2)
    rect_tube(h=50,size=1500,isize=1300,rounding=50)
    attach(TOP) 
    rect_tube(h=500,size=1500,isize=1400,rounding=50,anchor=BOT);
    children();
    }
}

//620x110
module elbow90(anchor=CENTER,spin=0,orient=UP)
{
    module reflector(anchor=CENTER,orient=UP,spin=0) {
    attachable(anchor,spin,orient,size=[1500,1500,1500]) {
        union() {
            left(725) wedge([50,1500,1500],center=true);
            right(725) wedge([50,1500,1500],center=true);

            hypot = adj_ang_to_hyp(1500,45);
            up(100) back(100) xrot(135) diff()  
            cuboid([1500,hypot,110],rounding=50,edges="Z")  {
                tag("remove") attach(TOP){
                    cuboid([800,100,30],anchor=TOP);
                    cuboid([100,800,30],anchor=TOP);
                }
                tag("keep")attach(TOP) {
                    rect_tube(h=100,size=[1500,hypot],isize=[1400,hypot-100],rounding=50);
                    left(320) back(320) cuboid([200,200,110],anchor=RIGHT+FRONT+BOT);
                    left(320) fwd(320) cuboid([200,200,110],anchor=RIGHT+BACK+BOT);
                    right(320) back(320) cuboid([200,200,110],anchor=LEFT+FRONT+BOT);
                    right(320) fwd(320) cuboid([200,200,110],anchor=LEFT+BACK+BOT);
                }
            }
       }
        children();
    }
      }
    attachable(anchor,spin,orient) {
        union() {
//            down((600+1500+(sin(45)*210))/2-300)
//            down(300+750)
            up(300)
//            back((550/2+sin(45)*210)/2)
            collar_inserter() {
                    attach(TOP,overlap=1) reflector(anchor=BOT)
                    attach(FRONT,overlap=1) collar_acceptor(anchor=BOT);
            }
        }
        children();
    }
//    zrot(90) ruler(4000,anchor=CENTER+FRONT);
//    yrot(90) ruler(4000,anchor=CENTER+BACK);
}

module simplelength(anchor=CENTER,spin=0,orient=UP,l)
{
    assert(l>1150,"simple length must be >= 1150");
    module _simplelength(length)
    {
        collar_inserter()
        attach(TOP,overlap=1) rect_tube(size=1500,isize=1400,h=l-1150,anchor=BOT,rounding=50)
        attach(TOP) collar_acceptor(anchor=BOT);
    }

    attachable(anchor,spin,orient,size=[1500,1500,l+1150]) {
        _simplelength(l);
        children();
    }
}

include <../../models/model_fan_caizhu_1inch.scad>

module model_hexled_and_heatsink()
{
    recolor("tan")
    cube([880,890,30],anchor=CENTER) {
        position(BOT) recolor("silver") cube([568,568,200],anchor=TOP);
        position(TOP) recolor("grey") cyl(d=783,h=45,$fn=6,anchor=BOT)
        position(TOP) recolor("white") cyl(d=314,h=100,$fn=96)
        position(TOP) recolor("yellow") cyl(d=250,h=100,$fn=96);
//        attach(from=BOT, to=TOP) recolor("darkgrey") model_fan_caizhu_1inch();
    }
}


module hexled_mount(anchor=CENTER,spin=0,orient=UP)
{
    module _hexled_mount() {
        down(200)
        collar_inserter()
        attach(TOP,BOT,overlap=1) diff()   {
            cuboid([1500,1500,100],rounding=50,edges="Z") {
                tag("remove") cube([1500,200,100],anchor=CENTER);
                tag("remove") cyl(d=850,h=100,$fn=96);
                attach(TOP,BOT) 
                intersect("mask") { 
                    cube([1130,1130,350]) {
                        {
                            tag("remove") cube([900,900,351],anchor=CENTER);
                            tag("remove") cube([1300,500,351],anchor=CENTER);
                            tag("remove") cube([500,1300,351],anchor=CENTER);
                        } 
                        attach(TOP,BOT) rect_tube(500,isize=1020,size=1130,anchor=BOT,irounding=100)
                        tag("remove") up(1) back(200) left(100) position(RIGHT+TOP+FRONT) cube([200,200,201],anchor=LEFT+TOP+FRONT);
                    }
                    tag("mask") cyl(d=1460,h=751,$fn=96);
                }
            }
        }
    }
    attachable(anchor,spin,orient) {
        _hexled_mount();
        children();
    }
}

module forViewing()
{
//    hexled_mount();
     simplelength(l=2000)
    attach(TOP) 
    recolor("cyan") down(350) elbow90(anchor=BOT)
    attach(BOT,norot=1) zflip() up(1500) hexled_mount();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
