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

module cutout(a=LEFT,d=0,l=0)
{
    conv_hull() 
        cuboid([1000+l+d,100+d,101],anchor=a)
        position(RIGHT) fwd(50+d/2)
        cyl(r=25+d/2,100,$fn=96,anchor=LEFT);
}

module base()
{
    difference() {
        cuboid([2600,1800,100], rounding=100, edges="Z") {
            attach(TOP+LEFT+BACK,norot=1) right(140) cutout(a=BOT+LEFT+BACK,d=-20,l=-40); 
            attach(TOP+LEFT+BACK,norot=1) up(20) right(140) cutout(a=BOT+LEFT+BACK,d=-20,l=-40); 
            attach(TOP+LEFT+FRONT,norot=1) right(140) yflip() cutout(a=BACK+LEFT+BOT,d=-20,l=-40);
            attach(TOP+LEFT+FRONT,norot=1) up(20) right(140) yflip() cutout(a=BACK+LEFT+BOT,d=-20,l=-40);
            attach(TOP+RIGHT,norot=1)
            diff() {
                cuboid([1000,1800,120], rounding=100, edges="Z",anchor=RIGHT+BOT)
                tag("remove") attach(RIGHT+BOT,norot=1) left(180) cuboid([1000,1620,121],rounding=100,edges="Z",anchor=RIGHT+BOT);
                tag("keep") attach(CENTER) left(120) zrot(90) pie_slice(r=200,l=120,ang=180,$fn=96,anchor=BOT);
            }
            *position(TOP) up(100)
            difference() {
                cuboid([2000,1800,101], rounding=100, edges="Z",anchor=BOT); 
                tag("remove") cuboid([2100,1480,101],anchor=BOT);
            }
        }
        tag("remove") cuboid([1600,1100,101], rounding=100, edges="Z");
        tag("remove") back(1000) right(70) cyl(r=300,h=221,$fn=96);
        tag("remove") fwd(1000) right(70) cyl(r=300,h=221,$fn=96);
    }
//        tag("remove") up(100) cuboid([2100,1820,120],anchor=BOT);
//        tag("remove") up(220) cuboid([2100,1480,100],anchor=BOT);
//        tag("remove") up(100) cuboid([1040,2100,120],anchor=BOT);
//    }
}

module slider()
{
    intersection() {
    diff()  {
        cuboid([1800,1780,100],rounding=100,edges="Z") {
            tag("remove") right(200) position(LEFT) cuboid([2000,400,101],rounding=100,edges="Z",anchor=LEFT);
            tag("remove") right(200) back(550) position(LEFT) cuboid([2200,300,101],rounding=100,edges="Z",anchor=LEFT);
            tag("remove") right(200) fwd(550) position(LEFT) cuboid([2200,300,101],rounding=100,edges="Z",anchor=LEFT);
            tag("remove") position(BACK+LEFT) right(200) cutout(d=-20,a=BACK+LEFT);
            tag("remove") position(FRONT+LEFT) right(200) yflip() cutout(d=-20,a=BACK+LEFT);
        }
    }
    cyl(r=1000,h=100,$fn=96) cuboid([1100,2000,100], anchor=RIGHT);
    }
    diff() {
        right(300) cuboid([2400,1580,100],rounding=100,edges="Z")
        tag("remove") left(50) position(RIGHT) cuboid([400,800,101],rounding=100,edges="Z");
        tag("remove") cyl(r=1050,h=100,$fn=96) cuboid([1100,2000,100], anchor=RIGHT);
        tag("keep") right(1350) fwd(170) cuboid([100,600,101]);
    }
    right(900) cuboid([200, 1100,100],anchor=LEFT);

}

module forViewing()
{
    base();
    color("cornflowerblue")
    up(150)
    left(400)
    slider();
}

module forPrinting()
{
    base();
    right(2500)
    slider();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
