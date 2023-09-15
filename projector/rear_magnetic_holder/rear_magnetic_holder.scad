ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

rodd=320;
rodgap=2260-rodd;

module model(anchor=CENTER,spin=0,orient=UP)
{
    $fn=96;
    module module_() {
        recolor("peachpuff")
        cuboid([3000,3000,300]) {
            recolor("lightyellow") // magnet
            attach(TOP) cyl(d=1241,h=183,anchor=BOT);
            // bottom of rods are 750 mils above the base
            up(750+rodd/2) yrot(90) { // rods
                recolor("darkkhaki") {
                    fwd(rodgap/2) cyl(l=3000,d=rodd);
                    back(rodgap/2) cyl(l=3000,d=rodd);
                }
            }
        }
    }
    attachable(anchor,spin,orient,size=[3000,3000,975]) {
        up(150) module_();
        children();
    }
}

module assembly(anchor=CENTER,spin=0,orient=UP)
{
    $fn=96;
    angle=70;
    length=535;
    diff() {
        cuboid([1600,1600,200],rounding=0,edges="Z",anchor=anchor)  {
            tag("keep") {
                attach(RIGHT+FRONT+BOT,norot=1) xrot(-angle)  cuboid([300,length,200],rounding=50,edges="Y",anchor=RIGHT+BACK+BOT)
                attach(FRONT,overlap=30) yrot(90) tube(id=rodd+20,od=535,l=300,anchor=RIGHT);
                attach(LEFT+FRONT+BOT,norot=1) xrot(-angle)  cuboid([300,length,200],rounding=50,edges="Y",anchor=LEFT+BACK+BOT)
                attach(FRONT,overlap=30) yrot(90) tube(id=rodd+20,od=535,l=300,anchor=RIGHT);

                attach(RIGHT+BACK+BOT,norot=1) xrot(angle)  cuboid([300,length,200],rounding=50,edges="Y",anchor=RIGHT+FRONT+BOT)
                attach(BACK,overlap=30) yrot(90) tube(id=rodd+20,od=535,l=300,anchor=RIGHT);
                attach(LEFT+BACK+BOT,norot=1) xrot(angle)  cuboid([300,length,200],rounding=50,edges="Y",anchor=LEFT+FRONT+BOT)
                attach(BACK,overlap=30) yrot(90) tube(id=rodd+20,od=535,l=300,anchor=RIGHT);
            }
            tag("remove") {
                attach(CENTER) cyl(d=1280,h=203);
            }
        }
    }
}

module forViewing()
{
    model();
    up(300)
    recolor("cornflowerblue")
    assembly(anchor=BOT);

}

module forPrinting()
{
    assembly();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
