ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>


module model_aviation_connector_3pin()
{
    module base(h=357) {
        intersection() {
            cyl(r=458/2,h,$fn=96);
            cuboid([423,1000,h]);
        }
    }
    union() {
        base(357);
        rot_copies(n=3) down(186) xmove(75) cyl(r=30,h=186,$fn=96,anchor=TOP);
        up(357/2+71/2) cyl(r=583/2,h=71,$fn=96) {
            attach(TOP) base(197);
            position(BOT) cyl(r=663/2,h=137,$fn=6,anchor=TOP);
        }
    }
}

module model_boost_buck_converter()
{
    stexy([0,0,0],731,[2800,1530]);    // Components
    stexy([0,0,730],880,[2800,1530]);        // Body
    stexy([0,0,1609],81,[3100,1660]);         // Lip
    cted([(2800/2)-600,0,1699],535,544);   // Knob
    stexy([(-2800/2)-(65/2),0,1150],443,[65,470]); // Side tab
    stexy([(2800/2),0,1150],443,[65,470]); // Side tab
}

module model_pcbtabs()
{
    linear_extrude(450)
    {
        translate([0, (-1734/2)+230-1, 0])
        square([65, 750], center=true);
        translate([423, (-1734/2)+230-1, 0])
        square([65, 750], center=true);
        translate([-423, (-1734/2)+230-1, 0])
        square([65, 750], center=true);
    }
}

module clip_connector()
{
//    diff() {
    tag("") cuboid([950,2080,569],anchor=BOT+LEFT)
    tag("remove") attach(LEFT+BOT,norot=1) cuboid([950,1880,469],anchor=LEFT+BOT);
//    }
}

module clip()
{
//    color("red")
    up(10) 
    diff() {
        cuboid([1860-90,2080,469],anchor=BOT+LEFT)  {
        tag("remove") position(LEFT+BOT)  cuboid([184-15,1880-140,469],anchor=BOT+LEFT) 
        tag("remove") position(RIGHT+BOT) cuboid([277+30,1880+30,469],anchor=BOT+LEFT)
        tag("remove") position(RIGHT+BOT)  cuboid([1299,1565+30,469],anchor=BOT+LEFT) 
        tag("remove") position(RIGHT+BOT) up(145) cuboid([1300+500,1910,469-145],anchor=BOT+RIGHT);
        tag("keep") position(RIGHT+BOT) #clip_connector();
        }
    }
    // Top and battery charger hole
    up(469) diff()
    cuboid([1860-90,2080,100],anchor=BOT+LEFT)  {
        // PCB tab holder surrounds
        attach(BOT+LEFT,norot=1) ycopies(420,n=3) right(1595+200) {
            cuboid([400,150,430],anchor=TOP+LEFT)
            tag("remove") position(LEFT+TOP) cuboid([300,60,430],anchor=TOP+LEFT);
        }
        tag("remove") position(LEFT) right(540) cyl(r=620/2,h=110,$fn=96);
    }
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
    color("royalblue") 
    model_battery_clip();
    color("royalblue") 
    model_battery_clip0();
    recolor("white")
    clip();

//    color("oldlace")
//    right(3200) up(150) fwd(300) xrot(-90)
//    model_aviation_connector_3pin();
}

module forPrinting()
{
    clip();
}

scale(ViewScale)
{
//    model_boost_buck_converter();
    forViewing();
//    forPrinting();
}
