ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

// Circle translate, extrude, diameter, fh
module cted(t,e,d,f=96) { translate(t) linear_extrude(e) circle(d/2, $fn=f); }
// Square translate, extrude, x, y
module stexy(t,e,xy) { translate(t) linear_extrude(e) square(xy, center=true); }

module base0()
{
    module click()
    {
        intersection() {
            difference() {
                cuboid([2000,50,110], anchor=BOT+BACK)
                position(TOP+BACK) cuboid([2000,200,110],anchor=BACK+BOT);
                cuboid([1030,61,111],anchor=BOT+BACK);
            }
            cuboid([2000,400,400],rounding=100,edges="Z", anchor=BACK);
        }
    }
    module support()
    {
        difference() {
            cuboid([2000,1900,100], rounding=100, edges="Z") {
            attach(TOP) position(BACK) click();
            attach(TOP) position(FRONT) yflip() click();
            }
            cuboid([1600,1600,101], rounding=100, edges="Z");
        }
    }
    difference() {
        support();
        #cyl(r=1000,h=400,$fn=96, anchor=BOT);
    }
}

module base()
{
    difference() {
        cuboid([2000,1900,320], rounding=100, edges="Z",anchor=BOT);
        cuboid([1600,1500,101], rounding=100, edges="Z",anchor=BOT);
        tag("remove") up(100) cuboid([2100,1820,120],anchor=BOT);
        tag("remove") up(220) cuboid([2100,1480,100],anchor=BOT);
        tag("remove") up(100) cuboid([1040,2100,120],anchor=BOT);
    }
}

// Depth is 825
module sliderhalf()
{
    module hook()
    {
    cuboid([1000,50,100])
    position(RIGHT+FRONT)
    intersect()   
    tube(ir=75,or=125,h=100, anchor=FRONT)
    tag("intersect") cuboid([200, 400,100], anchor=LEFT);
    }
    hook();
    back(200) xflip() hook();
    back(400) right(50) cuboid([1100,50,100]);
    back(450) cuboid([1000,50,100]);
    back(525) intersect()
    cyl(r=2000,h=100,$fn=96,anchor=BACK, rounding=20)
    tag("intersect") position(BACK) cuboid([1000,100,100],anchor=BACK);
}

module slider()
{
    difference()  {
    cuboid([2000,950,100]) {
        position(BACK) sliderhalf();
        position(FRONT) yflip() sliderhalf();
        position(BACK+RIGHT) cuboid([300, 410,100], anchor=RIGHT+FRONT, rounding=100,edges=BACK+RIGHT);
        position(BACK+LEFT) cuboid([300, 410,100], anchor=LEFT+FRONT, rounding=100,edges=BACK+LEFT);
        position(FRONT+LEFT) cuboid([300, 410,100], anchor=LEFT+BACK, rounding=100,edges=FRONT+LEFT);
        position(FRONT+RIGHT) cuboid([300, 410,100], anchor=RIGHT+BACK, rounding=100,edges=FRONT+RIGHT);
    }
    cuboid([1800,750,101], rounding=100,edges="Z");
    }

    //cuboid([2000,2000,100]);
}

module forViewing()
{
    base();
    color("cornflowerblue")
    up(150)
    slider();
}

module forPrinting()
{
    base();
//    right(1500)
//    slider();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
