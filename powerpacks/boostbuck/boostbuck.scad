ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>
include <model_aviation_connector_3pin.scad>

model=0;

module model_boost_buck_converter()
{
    recolor("grey")
    diff() {
        cuboid([3100,1660,80],rounding=70,edges="Z") {
            tag("remove") attach(CENTER) cuboid([2650,1280,81]);    // display cutout
            recolor("silver") left(310) attach(TOP+RIGHT,norot=1) cyl(r=567/2,h=540,$fn=96, anchor=BOT+RIGHT); // big silver knob
            recolor("cornflowerblue") tag("keep") right(338) fwd(550/2) attach(LEFT,norot=1) cyl(r=230/2,h=50,$fn=96,anchor=LEFT); // button
            recolor("cornflowerblue") tag("keep") right(338) back(550/2) attach(LEFT,norot=1) cyl(r=230/2,h=50,$fn=96,anchor=LEFT); // button
            tag("keep") attach(BOT,norot=1) cuboid([2800,1530,690],anchor=TOP) {
                recolor("green")
                attach(LEFT+TOP,norot=1) cuboid([60,470,480],anchor=RIGHT+TOP); // left tab cutout
                recolor("green")
                attach(RIGHT+TOP,norot=1) cuboid([60,470,480],anchor=LEFT+TOP); // right tab cutout
                recolor("green")
                left(398/2+250) back(398/2+370) attach(RIGHT+BOT+FRONT,norot=1) cyl(r=398/2,h=450,$fn=96,anchor=TOP); // electrolytic
                recolor("green")
                right(398/2+80) back(398/2+100) attach(LEFT+BOT+FRONT,norot=1) cyl(r=398/2,h=450,$fn=96,anchor=TOP); // electrolytic
                recolor("green")
                right(398/2+260) fwd(398/2+300) attach(LEFT+BOT+BACK,norot=1) cyl(r=398/2,h=450,$fn=96,anchor=TOP); // electrolytic
                recolor("silver")
                attach(BOT,norot=1) cuboid([980,980,370],anchor=TOP); // heatsink
                recolor("cornflowerblue")
                right(0) fwd(0) attach(BOT+FRONT,norot=1) cuboid([790,300,300],anchor=FRONT+TOP); // terminals
                recolor("orangered")
                fwd(100) down(775/2) right(775/2) attach(LEFT+BOT,norot=1) xrot(90) cyl(r=775/2,h=360,$fn=96); // electrolytic
                //right(398/2+260) fwd(398/2+300) attach(LEFT+BOT+BACK,norot=1) cyl(r=398/2,h=450,$fn=96,anchor=TOP); // electrolytic
            }
        }
    }
}

module enclosure()
{
    diff() {
        cuboid([3500,2300,2000],rounding=100,edges="Z") {
        tag("remove") down(100) cuboid([3300,2100,1900],rounding=100,edges="Z");
//        tag("remove") fwd(100) #cuboid([3300,2300,1800]);
        tag("remove") fwd(2) attach(FRONT,norot=1) cuboid([2830,201,1560],anchor=FRONT) {  // panel cutout
               attach(LEFT,norot=1) right(1) cuboid([81,200,510],anchor=RIGHT); // left tab cutout
                attach(RIGHT,norot=1) left(1) cuboid([81,200,510],anchor=LEFT); // right tab cutout
            }
        }
    }
}


module forViewing()
{
//    up(4000)
//    fwd(1200) xrot(90) model_boost_buck_converter();
     model_boost_buck_converter();
//    recolor("silver") back(400) down(400) right(1570) yrot(90) model_aviation_connector_3pin();
//    enclosure();
}

module forPrinting()
{
    upper_clip();
}

scale(ViewScale)
{
    forViewing();
//    forPrinting();
}
