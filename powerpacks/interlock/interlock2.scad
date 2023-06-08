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

module cutout(a=LEFT,d=0)
{
    conv_hull() 
        cuboid([1000+d,200+d,101],anchor=a)
        position(RIGHT) fwd(50+d/2)
        cyl(r=50+d/2,100,$fn=96,anchor=LEFT);
}

module base()
{
//    difference() {
        cuboid([2000,1800,100], rounding=100, edges="Z",anchor=BOT) {
            attach(TOP+LEFT+BACK,norot=1) right(200) cutout(a=BOT+LEFT+BACK,d=-20); 
            attach(TOP+LEFT+BACK,norot=1) up(20) right(200) cutout(a=BOT+LEFT+BACK,d=-20); 
            attach(TOP+LEFT+FRONT,norot=1) right(200) yflip() cutout(a=BACK+LEFT+BOT,d=-20);
            attach(TOP+LEFT+FRONT,norot=1) up(20) right(200) yflip() cutout(a=BACK+LEFT+BOT,d=-20);
            *position(TOP) up(100)
            difference() {
                cuboid([2000,1800,100], rounding=100, edges="Z",anchor=BOT); 
                tag("remove") cuboid([2100,1480,100],anchor=BOT);
            }
        }
//        cuboid([1600,1500,101], rounding=100, edges="Z",anchor=BOT);
//        tag("remove") up(100) cuboid([2100,1820,120],anchor=BOT);
//        tag("remove") up(220) cuboid([2100,1480,100],anchor=BOT);
//        tag("remove") up(100) cuboid([1040,2100,120],anchor=BOT);
//    }
}

module slider()
{
    diff()  {
        cuboid([1800,1780,100],rounding=100,edges="Z") {
            tag("remove") right(300) position(LEFT) cuboid([2000,1280,101],rounding=100,edges="Z",anchor=LEFT);
            tag("remove") position(BACK+LEFT) right(200) cutout();
            tag("remove") position(FRONT+LEFT) right(200) yflip() cutout();
        }
    }
}

module forViewing()
{
    base();
    color("cornflowerblue")
    up(150)
    left(100)
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
    forViewing();
//    forPrinting();
}
