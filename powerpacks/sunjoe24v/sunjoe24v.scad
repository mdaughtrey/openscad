ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>
include <../../models/model_aviation_connector_3pin.scad>

model=0;

module housing_3pin()
{
    tag("") cuboid([1000,2080,559],anchor=BOT+LEFT,rounding=100,edges=[RIGHT+FRONT,RIGHT+BACK]) {
        tag("remove") down(1) attach(LEFT+BOT,norot=1)
            cuboid([850,1880,459+1],anchor=LEFT+BOT)
        left(1) attach(RIGHT+BOT+FRONT,norot=1) back(200) 
            cuboid([150+2,900,459],anchor=FRONT+BOT+LEFT);
        attach(RIGHT+TOP+FRONT,norot=1) back(200) 
            cuboid([1000,1100,559+300],anchor=LEFT+FRONT+TOP,rounding=100,edges=[RIGHT+FRONT,RIGHT+BACK,TOP+RIGHT,TOP+FRONT,TOP+BACK])
        {
            // Insides
            tag("remove") down(1) attach(LEFT+TOP,norot=1) down(100)
                cuboid([900,900,559+200+1],anchor=LEFT+TOP)
                // 45 deg cut
                attach(BOT+LEFT,norot=1) down(265) yrot(45)
                    cuboid([800,1500,800]);

            // Connector Hole
            tag("remove") attach(BACK,norot=1) down(50) fwd(50) xrot(90) intersection() {
                cyl(r=488/2,200,$fn=96);
                cuboid([453,1000,200]);

            }
            if (model) {
                recolor("oldlace") tag("keep") down(50) attach(BACK,norot=1) fwd(200) xrot(-90)
                    model_aviation_connector_3pin();
            }
        }
    }
}

module cutout(a=LEFT,d=0,l=0)
{
    conv_hull() 
        cuboid([1000+l+d,100+d,101],anchor=a)
        position(RIGHT) fwd(50+d/2)
        cyl(r=25+d/2,100,$fn=96,anchor=LEFT);
}


module clip()
{
    module cutout(a=LEFT,d=0,l=0)
    {
        conv_hull() 
            cuboid([1000+l+d,100+d,101],anchor=a)
            position(RIGHT) fwd(50+d/2)
            cyl(r=25+d/2,100,$fn=96,anchor=LEFT);
    }
    up(10) 
    diff() {
        cuboid([1860-90,2080,469],anchor=BOT+LEFT,rounding=100,edges=[LEFT+FRONT,LEFT+BACK])  {
        tag("remove") down(1) left(1) position(LEFT+BOT)  cuboid([184-13,1880-140,469+2],anchor=BOT+LEFT) 
        tag("remove") left(1) position(RIGHT+BOT) cuboid([277+31,1880+30,469],anchor=BOT+LEFT)
        tag("remove") left(1 )position(RIGHT+BOT)  cuboid([1299+1,1565+30,469],anchor=BOT+LEFT) 
        tag("remove") position(RIGHT+BOT) up(145) cuboid([1300+500,1910,469-143],anchor=BOT+RIGHT);
        tag("keep") position(RIGHT+BOT) housing_3pin();
        }
    }
    // Top and battery charger hole
    up(469) diff()
    cuboid([1860-90,2080,100],anchor=BOT+LEFT,rounding=100,edges=[LEFT+FRONT,LEFT+BACK])  {
        // PCB tab holder surrounds
        right(1595+200) attach(BOT+LEFT,norot=1) ycopies(420,n=3) {
            tag("") cuboid([400,150,430-100],anchor=TOP+LEFT)
            tag("remove") up(10) left(1) position(LEFT+TOP) cuboid([300,62,433],anchor=TOP+LEFT);
        }
        // Upper clips
        attach(TOP+RIGHT+FRONT,norot=1) left(200) zrot(180) cutout(a=BOT+RIGHT+BACK,d=-20,l=-40); 
        attach(TOP+RIGHT+FRONT,norot=1) left(200) up(20) zrot(180) cutout(a=BOT+RIGHT+BACK,d=-20,l=-40); 

        attach(TOP+RIGHT+BACK,norot=1) left(200) zrot(180) yflip() cutout(a=BOT+RIGHT+BACK,d=-20,l=-40); 
        attach(TOP+RIGHT+BACK,norot=1) left(200) up(20) zrot(180) yflip() cutout(a=BOT+RIGHT+BACK,d=-20,l=-40); 

        // Bump at the end
        attach(LEFT+TOP,norot=1) cuboid([1000,2080,120], rounding=100, edges="Z",anchor=LEFT+BOT) {
            tag("remove") down(1) attach(LEFT+BOT,norot=1) right(180) cuboid([1000,1620+280,122],rounding=100,edges="Z",anchor=LEFT+BOT) 
                tag("keep") attach(LEFT+BOT,norot=1) left(1) down(1) zrot(-90) pie_slice(r=180,l=121,ang=180,$fn=96,anchor=BOT);
            attach(LEFT+TOP,norot=1) cuboid([2700,2080,101],rounding=100,edges="Z",anchor=BOT+LEFT)
                tag("remove") down(1) attach(LEFT+BOT,norot=1) right(200) cuboid([2600,1780,104],rounding=100,edges="Z",anchor=BOT+LEFT);
        }
        // Hole for charger
        tag("remove") down(10) position(LEFT) right(540+75) cyl(r=620/2,h=130,$fn=96);

    }

}

module upper_clip()
{
    intersection() {
        diff()  {
            cuboid([1800,2050,100],rounding=100,edges="Z")
            {
                tag("remove") right(200) back(650) position(LEFT) cuboid([1800,250,101],rounding=50,edges="Z",anchor=LEFT);
                tag("remove") right(200) fwd(650) position(LEFT) cuboid([1800,250,101],rounding=50,edges="Z",anchor=LEFT);
                tag("remove") right(200) back(1) position(BACK+LEFT) cutout(d=-20,a=BACK+LEFT);
                tag("remove") right(200) fwd(1) position(FRONT+LEFT) yflip() cutout(d=-20,a=BACK+LEFT);
                tag("remove") left(500) down(1) position(BOT) cyl(r=100,h=102,$fn=96,anchor=BOT);
                tag("remove") right(500) down(1) position(BOT) cyl(r=100,h=102,$fn=96,anchor=BOT);
            }
        }
        cyl(r=1100,h=100,$fn=96) cuboid([1100,2000,100], anchor=RIGHT);
    }
    up(50) left(500) tube(ir=100,or=210,h=100,$fn=96,anchor=BOT);
    up(50) right(500) tube(ir=100,or=200,h=100,$fn=96,anchor=BOT);
    diff() {
        right(300) cuboid([2400,1580+270,100],rounding=100,edges="Z")
        tag("remove") left(50) position(RIGHT) cuboid([400,800,101],rounding=100,edges="Z");
        tag("remove") right(100) cyl(r=1150,h=101,$fn=96) cuboid([1100,2000,101], anchor=RIGHT);
        tag("keep") right(1450) fwd(170) cuboid([75,600,101]); // tab for the bump
    }
    right(800) cuboid([450, 1250,100],anchor=LEFT);

}


module model_battery_clip()
{
    cuboid([3040,2950,600],chamfer=300,edges=TOP,except_edges=LEFT,anchor=TOP+LEFT) {
    position(RIGHT+BACK) up(100) fwd(450) cyl(r=240/2,h=500,$fn=96,anchor=TOP);
    position(RIGHT+FRONT) up(100) back(450) cyl(r=240/2,h=500,$fn=96,anchor=TOP);
    }
}

module model_battery_clip0()
{
    cuboid([184,1880-170,350],anchor=BOT+LEFT) 
    {
        position(RIGHT+BOT) cuboid([277,1880,350],anchor=BOT+LEFT);
        diff() 
        {
            position(BOT+LEFT) cuboid([1760,1565,449],anchor=BOT+LEFT) 
            {
                position(TOP+LEFT) cuboid([1760,1880,85],anchor=TOP+LEFT);
                position(TOP+RIGHT) cuboid([1300,1880,250],anchor=TOP+RIGHT);
                tag("remove") position(RIGHT+BOT) cuboid([460,77,800],anchor=BOT+RIGHT);
                tag("remove") back(420) position(RIGHT+BOT) cuboid([460,77,800],anchor=BOT+RIGHT);
                tag("remove") fwd(420) position(RIGHT+BOT) cuboid([460,77,800],anchor=BOT+RIGHT);
                tag("remove") position(LEFT+TOP) right(560) cyl(r=130,h=100,$fn=96);
            }
        }
    }
}

module forViewing()
{
    *color("royalblue") 
    model_battery_clip();
    *color("royalblue") 
    model_battery_clip0();
    //recolor("white")
    clip();
//    up(630) right(1850) color("green") zrot(180) upper_clip();

//    color("oldlace")
//    right(3200) up(150) fwd(300) xrot(-90)
    //model_aviation_connector_3pin();
}

module forPrinting()
{
   upper_clip();
}

scale(ViewScale)
{
//    model_boost_buck_converter();
//    forViewing();
    forPrinting();
}
