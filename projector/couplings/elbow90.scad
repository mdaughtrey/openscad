ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>


module collar_acceptor()
{
    rect_tube(h=500,size=1500,isize=1400,rounding=50);
}

module collar_inserter(anchor=CENTER,spin=0,orient=UP)
{
    attachable(anchor,spin,orient,size=[1500,1500,600]) {
        union() {
            rect_tube(h=500,size=1380,isize=1280,rounding=50)
            attach(TOP,overlap=1)
            rect_tube(h=100,size=1500,isize=1280,rounding=50,anchor=BOT);
        }
        children();
    }
}

module elbow90()
{
    // Acceptor
//    rect_tube(h=500,size=1500,isize=1400,rounding=50)
//    attach(BOT) diff() {
//    diff() {
//        rect_tube(h=1500,size=1500,isize=1400)
//        tag("remove") attach(FRONT,norot=1) yrot(45) cuboid([1500,1500,2500],anchor=LEFT+FRONT);
//    }
//    attach(LEFT+BOT,norot=1) yrot(90) collar_inserter(anchor=LEFT+TOP);
    module reflector(anchor=CENTER) {
    attachable(anchor=CENTER,orient=UP,spin=0,size=[1500,1500,1500]) {
        union() {
            left(750) wedge([50,1500,1500]);
            right(700) wedge([50,1500,1500]);

            hypot = adj_ang_to_hyp(1500,45);
            up(850) back(850)
            xrot(135)
            cuboid([1500,hypot,100],rounding=50,edges="Z")
            attach(TOP) rect_tube(h=100,size=[1500,hypot],isize=[1400,hypot-100],rounding=50);
        }
        children();
    }
    }
    reflector(anchor=FRONT) {
        attach(FRONT) down(450) zflip() collar_inserter(anchor=TOP+FRONT);
        attach(BOT) down(250) rect_tube(h=500,size=1500,isize=1400,rounding=50,anchor=TOP+FRONT);
    }
}


module forViewing()
{
    elbow90();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
