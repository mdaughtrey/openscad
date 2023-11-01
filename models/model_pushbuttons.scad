ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>

ups_width=1660;
ups_length=3490;

module model_ups()
{
    hole_indent=140;
    recolor("green")
    diff()
    cuboid([ups_length,ups_width,65])  {
        tag("remove")  {
            attach(BOT,norot=1) grid_copies([3280,1460]) cyl(d=125,h=75,anchor=BOT);
            attach(BOT,norot=1) grid_copies([2850,830]) cyl(d=80,h=75,anchor=BOT);
        }
        tag("keep") {
            // Caps
            for (ii=[[1000,465],[1000,980],[2180,470],[2520,470]]) {
                attach(FRONT+TOP+LEFT,norot=1) right(ii[0]) back(ii[1]) recolor("silver") cyl(d=260,h=300, anchor=BOT+LEFT+FRONT);
            }
            // Diodes
            for (ii=[[550,550],[550,880],[2260,1000]]) {
                attach(FRONT+TOP+LEFT,norot=1) right(ii[0]) back(ii[1]) recolor("black") cuboid([320,230,100], anchor=BOT+LEFT+FRONT);
            }
            // Inductor
            attach(BACK+TOP+LEFT,norot=1) right(1500) fwd(350) recolor("dimgray") cuboid([430,430,150], anchor=BOT+LEFT+BACK);
            // Mini USB
            attach(TOP+LEFT,norot=1) left(10) recolor("silver") cuboid([226,300,90], anchor=BOT+LEFT+BACK);
        }
    }
}

module model_buttontop(anchor=CENTER,spin=0,orient=UP)
{
    // thick 20
    $fn=96;
    attachable(anchor,spin,orient=orient,d=223,l=262) {
        down(262/2+-20) cyl(d1=223,d2=210,h=262);
        children();
    }
}

module model_pushbutton_base(anchor=CENTER,spin=0,orient=UP,shaftl=285)
{
    $fn=96;
    recolor("dimgray")
    attachable(anchor,spin,orient=orient,size=[237,237,120+shaftl]) {
        cuboid([237,237,120]) {
            attach(TOP) cyl(d1=136,d2=121,h=shaftl,anchor=BOT);
            attach(BOT, norot=1) grid_copies([176,250]) recolor("silver") cyl(d=25,h=170,anchor=TOP);
        }
        children();
    }
}

module forViewing()
{
//        model_buttontop();
    model_pushbutton_base(shaftl=200);
//    attach(TOP) recolor("green") model_buttontop();
}

module forPrinting()
{
}

scale(ViewScale)
{
   forViewing();
}
