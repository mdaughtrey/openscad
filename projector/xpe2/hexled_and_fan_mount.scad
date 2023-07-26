ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>
include <../../models/model_fan_caizhu_1inch.scad>
include <collars.scad>

module model_hexled_and_heatsink()
{
    recolor("tan")
    cube([880,890,30],anchor=CENTER) {
        position(BOT) recolor("silver") cube([568,568,200],anchor=TOP);
        position(TOP) recolor("grey") cyl(d=783,h=45,$fn=6,anchor=BOT)
        position(TOP) recolor("white") cyl(d=314,h=100,$fn=96)
        position(TOP) recolor("yellow") cyl(d=250,h=100,$fn=96);
//        attach(from=BOT, to=TOP) recolor("darkgrey") model_fan_caizhu_1inch();
    }
}


module mount()
{
    tabbed_collar(anchor=TOP) 
    attach(TOP,BOT) diff()   {
        tube(h=100,od=1460,id=1360,$fn=96)  {
            attach(CENTER,CENTER) tag("remove") cube([1500,200,100]);
            attach(TOP,BOT) tube(od=1460,id=850,h=50,$fn=96)
            attach(TOP,BOT) 
            intersect("mask") { 
                cube([1130,1130,350]) {
                    {
                        tag("remove") cube([900,900,351],anchor=CENTER);
                        tag("remove") cube([1300,500,351],anchor=CENTER);
                        tag("remove") cube([500,1300,351],anchor=CENTER);
                    } 
                    attach(TOP,BOT) rect_tube(500,isize=1020,size=1130,anchor=BOT,irounding=100)
                    tag("remove") up(1) back(200) left(100) position(RIGHT+TOP+FRONT) cube([200,200,201],anchor=LEFT+TOP+FRONT);
                }
                tag("mask") cyl(d=1460,h=751,$fn=96);
            }
        }
    }
}

module test() 
{
    intersection("mask") {
    diff()  
    cube([1130,1130,350],anchor=BOT) 
    {
        tag("remove") cube([900,900,351],anchor=CENTER);
        tag("remove") cube([1300,500,351],anchor=CENTER);
        tag("remove") cube([500,1300,351],anchor=CENTER);
    } 
    tag("mask") cyl(d=1460,h=751,$fn=96);
    }
}


module forViewing()
{
    up(170)
    xrot(180) {
    model_hexled_and_heatsink();
        zmove(-750) color("cyan") model_fan_caizhu_1inch();
    }
    mount();
//test();
}

module forPrinting()
{
    mount();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
