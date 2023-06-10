ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>
include <model_aviation_connector_3pin.scad>
include <model_power_switch.scad>

model=0;

module cutout(a=LEFT,d=0,l=0)
{
    conv_hull() 
        cuboid([1000+l+d,100+d,101],anchor=a)
        position(RIGHT) fwd(50+d/2)
        cyl(r=25+d/2,100,$fn=96,anchor=LEFT);
}


module upper_clip()
{
    cuboid([2780,2080,100],rounding=100,edges="Z",anchor=LEFT) {
        attach(BOT+RIGHT+BACK,norot=1) left(200) zrot(180) yflip() cutout(a=TOP+LEFT+BACK,d=-20,l=-40); 
        attach(BOT+RIGHT+BACK,norot=1) left(200) down(20) zrot(180) yflip() cutout(a=TOP+LEFT+BACK,d=-20,l=-40); 
        attach(BOT+RIGHT+FRONT,norot=1) left(200) zrot(180) cutout(a=TOP+LEFT+BACK,d=-20,l=-40); 
        attach(BOT+RIGHT+FRONT,norot=1) left(200) down(20) zrot(180)  cutout(a=TOP+LEFT+BACK,d=-20,l=-40); 
        attach(BOT+LEFT,norot=1) cuboid([1000,2080,120],rounding=100,edges="Z",anchor=TOP+LEFT);
        tag("keep") attach(LEFT+BOT,norot=1) right(99) zrot(-90) pie_slice(r=180,l=121,ang=180,$fn=96,anchor=TOP);

        tag("remove") right(200) cuboid([2780,1730,121],rounding=100,edges="Z");
        tag("remove") right(100) attach(BOT+LEFT,norot=1) cuboid([1000,1880,121],rounding=100,edges="Z",anchor=TOP+LEFT);
    }
}

module model_boost_buck_converter()
{
    recolor("grey")
    diff() {
        cuboid([3100,1660,80],rounding=70,edges="Z") {
            tag("remove") attach(CENTER) cuboid([2650,1280,81]);    // display cutout
            recolor("silver") left(310) attach(TOP+RIGHT,norot=1) cyl(r=567/2,h=540,$fn=96, anchor=BOT+RIGHT); // big silver knob
            recolor("cornflowerblue") tag("keep") right(338) fwd(550/2) attach(LEFT,norot=1) cyl(r=230/2,h=50,$fn=96,anchor=LEFT); // button
            recolor("cornflowerblue") tag("keep") right(338) back(550/2) attach(LEFT,norot=1) cyl(r=230/2,h=50,$fn=96,anchor=LEFT); // button
            tag("keep") attach(BOT,norot=1) cuboid([2800,1530,900],anchor=TOP) {
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

module model_banana_jack(c)
{
    recolor(c)
    cyl(r=430/2,h=910,$fn=96) {
        attach(BOT,norot=1) recolor("silver") cyl(r=480/2,h=130,$fn=6,anchor=TOP);
        attach(BOT,norot=1) recolor(c) intersection() {
            cyl(r=300/2,h=450,$fn=96,anchor=TOP);
            cuboid([256,310,450],anchor=TOP);
        }
        down(450) attach(BOT,norot=1) recolor("silver") cyl(r=85/2,h=275,$fn=96);
    }
}

module screwmount()
{
    xrot(-90)
    tube(ir=30,or=100,h=500,anchor=TOP) {
    attach(RIGHT,norot=1) left(10) cuboid([200,50,500],anchor=LEFT);
    attach(FRONT,norot=1) up(10) cuboid([50,200,500],anchor=BACK);
    }
}

module enclosure()
{
    diff() {
        cuboid([4000,2300,2000],rounding=100,edges=[LEFT+FRONT,RIGHT+FRONT]) {
        tag("remove") down(0) back(100) cuboid([3800,2200,1800]);
//        #tag("remove") fwd(1) attach(BACK,norot=1) cuboid([3800,200,1800]);
        tag("remove") fwd(2) right(250) attach(FRONT+LEFT,norot=1) cuboid([2830,201,1560],anchor=FRONT+LEFT) {  // panel cutout
            attach(LEFT,norot=1) right(1) cuboid([81,200,510],anchor=RIGHT); // left tab cutout
            attach(RIGHT,norot=1) left(1) cuboid([81,200,510],anchor=LEFT); // right tab cutout
        }
        // Banana jack holes
        tag("remove") attach(FRONT+RIGHT,norot=1) zcopies(n=2,l=800) fwd(100) left(400) xrot(90) 
        intersection() {
            cyl(r=300/2,h=450,$fn=96,anchor=TOP);
            cuboid([256,310,450],anchor=TOP);
        }
        attach(TOP+LEFT,norot=1) up(170) upper_clip();
        // Screw mounts
        fwd(200) {
            tag("keep") attach(RIGHT+BACK+TOP,norot=1) down(350) left(350) screwmount();
            tag("keep") attach(LEFT+BACK+TOP,norot=1) down(350) right(350) yrot(-90) screwmount();
            tag("keep") attach(LEFT+BACK+BOT,norot=1) up(350) right(350) yrot(180) screwmount();
            tag("keep") attach(RIGHT+BACK+BOT,norot=1) up(350) left(350) yrot(90) screwmount();
        }
        // Bottom slider mounts
        tag("keep") {
            attach(BOT,norot=1) {
            left(500) tube(ir=230,or=330,h=220,$fn=96,anchor=TOP);
            right(500) tube(ir=230,or=330,h=220,$fn=96,anchor=TOP);
            }
        }
        }
    }
    //upper_clip();
}

module lid()
{
    diff() {
        // cuboid([4000,2000,200],rounding=100,edges=TOP) {
        cuboid([3770,1770,200]) {
        // Inside scooped out
        tag("remove") down(100) cuboid([3600,1600,200]) ;
        // Screw mounts
        tag("remove") attach(RIGHT+BACK,norot=1) fwd(235) left(235) cyl(r=50,h=202,$fn=96);
        tag("keep")   attach(RIGHT+BACK+TOP,norot=1) fwd(235) left(235) down(99) tube(ir=50,or=100,h=80,$fn=96,anchor=TOP);
        tag("remove") attach(LEFT+BACK,norot=1) fwd(235) right(235) cyl(r=50,h=202,$fn=96);
        tag("keep")   attach(LEFT+BACK+TOP,norot=1) fwd(235) right(235) down(99) tube(ir=50,or=100,h=80,$fn=96,anchor=TOP);
        tag("remove") attach(LEFT+FRONT,norot=1) back(235) right(235) cyl(r=50,h=202,$fn=96);
        tag("keep")   attach(LEFT+FRONT+TOP,norot=1) back(235) right(235) down(99) tube(ir=50,or=100,h=80,$fn=96,anchor=TOP);
        tag("remove") attach(RIGHT+FRONT,norot=1) back(235) left(235)  cyl(r=50,h=202,$fn=96);
        tag("keep")   attach(RIGHT+FRONT+TOP,norot=1) back(235) left(235) down(99) tube(ir=50,or=100,h=80,$fn=96,anchor=TOP);

        // Connector Hole
        tag("remove") attach(TOP,norot=1) down(1) right(0)  intersection() {
                cyl(r=488/2,200,$fn=96); cuboid([453,1000,200]); }
        tag("remove") attach(TOP,norot=1) down(1) left(1000)  intersection() {
                cyl(r=488/2,200,$fn=96); cuboid([453,1000,200]); }
        // Power switch hole
        tag("remove") attach(TOP,norot=1)  right(1200) zrot(180) {
            cyl(r=790/2,h=550,$fn=96)
            {
              up(1) cuboid([150,840,154],anchor=TOP);
//            position(BACK+TOP) fwd(10) cuboid([150,130,440],anchor=TOP+FRONT);
            zrot(90) position(BACK+TOP) fwd(10) cuboid([100,50,450],anchor=TOP+FRONT);
            }
        }

        // Vents
        tag("remove") attach(TOP+BACK,norot=1) fwd(150) down(1) cuboid([2400,100,201],rounding=50,edges="Z");
        tag("remove") attach(TOP+FRONT,norot=1) back(150) down(1) cuboid([2400,100,201],rounding=50,edges="Z");
        }
    }
    
    if (model)
    {
        color("oldlace") {
        right(0)  down(100) model_aviation_connector_3pin();
        left(1000)  down(100) model_aviation_connector_3pin();
        // Power switch 
        up(150) right(1200) zrot(180) model_power_switch();
        }
    }
}


module forViewing()
{
//    up(4000)
    if (model) {
        left(330) fwd(1200) xrot(90) model_boost_buck_converter();
//         model_boost_buck_converter();
    }
//    recolor("silver") back(400) down(400) right(1570) yrot(90) model_aviation_connector_3pin();
    enclosure();
    back(1050) xrot(-90) lid();
    if (model) {
    zcopies(n=2,l=800) fwd(1600) right(1600) xrot(90) model_banana_jack("red");
    model_power_switch();
    }
}

module forPrinting()
{
//    upper_clip();
    lid();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
