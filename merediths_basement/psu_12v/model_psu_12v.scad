ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>


module model_psu12v()
{
    module terminals()
    {
        recolor("slategrey")
        cuboid([3440,575,275],anchor=FRONT+BOT+RIGHT) {
        position(TOP) xcopies(l=3440-50,n=10) cuboid([50,575,200], anchor=BOT);
        position(TOP) recolor("silver") xcopies(l=3000,n=9) cyl(r=200/2,h=160,$fn=96, anchor=BOT);
        position(TOP) recolor("orange") up(200)  cuboid([3440,575,110]);
        }
    }
    recolor("cornflowerblue")
    diff() { cuboid([8740,4475,1960]) {
        tag("remove") {
        // Terminals
        position(TOP+RIGHT) up(1) right(1) cuboid([670,4400,1650],anchor=TOP+RIGHT);
        // Top Vents
        position(TOP+RIGHT) left(1770) fwd(1095) xcopies(270,n=5) cuboid([120,980,100],rounding=60,edges="Z");
        position(TOP+RIGHT) left(1770) back(1095)  xcopies(270,n=5) cuboid([120,980,100],rounding=60,edges="Z");
        // Fan
        position(TOP+LEFT+FRONT) back(1500) right(1920) cyl(r=2250/2,h=100);
        // Front right vents
        position(FRONT+RIGHT) left(520)  xcopies(270,n=3) cuboid([120,200,980],rounding=60,edges="Y");
        // Rear right vents
        position(BACK+RIGHT) left(520)  xcopies(270,n=3) cuboid([120,200,980],rounding=60,edges="Y");
        // Bottom front vents
        position(FRONT+BOT) fwd(200) down(60) xcopies(270,n=22) cuboid([120,1000,200,230],rounding=60,anchor=FRONT+BOT);
        // Bottom back vents
        position(BACK+BOT) back(200) down(60) xcopies(270,n=22) cuboid([120,1000,200,230],rounding=60,anchor=BACK+BOT);
        // Center front vents
        position(FRONT) xcopies(270,n=2) cuboid([120,200,980],rounding=60,edges="Y");
        }
        tag("keep") {
            position(RIGHT+BOT+BACK) fwd(250)  up(1960-1650)
            zrot(90) terminals();
        }
    }}
}

//module forViewing()
//{
//    model_psu12v();
//    terminals();
//}
//
//module forPrinting()
//{
//}
//
//scale(ViewScale)
//{
//    forViewing();
//}

