ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>


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

//620x110
module elbow90()
{
    module reflector(anchor=CENTER) {
    attachable(anchor=CENTER,orient=UP,spin=0,size=[1500,1500,1500]) {
        union() {
            left(750) wedge([50,1500,1500]);
            right(700) wedge([50,1500,1500]);

            hypot = adj_ang_to_hyp(1500,45);
            up(850) back(850)
            xrot(135)
            //diff()  
            cuboid([1500,hypot,110],rounding=50,edges="Z")  {
//                tag("remove") attach(TOP){
//                    cuboid([800,100,30],anchor=TOP);
//                    cuboid([100,800,30],anchor=TOP);
//                }
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
//    forViewing();

//    diff() 
//        cuboid([1000,1000,100])
//        tag("remove") attach(TOP){
//            cuboid([800,100,30],anchor=TOP);
//            cuboid([100,800,30],anchor=TOP);
//        }
////    }
}
