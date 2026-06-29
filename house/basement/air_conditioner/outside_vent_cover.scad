ViewScale = [0.0254, 0.0254, 0.0254];
include <../../../BOSL2-master/std.scad>
//$fn=96;

module model(anchor=CENTER,spin=0,orient=UP)
{
    module model_()
    {
        rmtag="rf513v";
        diff(rmtag)
        {
            cuboid([12000, 7000, 110], edges="Z", rounding=1120)
            tag(rmtag) position(TOP) up(1)
            {
                cuboid([7500, 3950, 112], edges="Z", rounding=1120,anchor=TOP)
                {
                    position(TOP+LEFT) right(1) cuboid([395, 870, 112], anchor=RIGHT+TOP, edges=[LEFT+BACK,LEFT+FRONT], rounding=100);
                    position(TOP+RIGHT) left(1) cuboid([395, 870, 112], anchor=LEFT+TOP, edges=[RIGHT+BACK,RIGHT+FRONT], rounding=100);
                }
            }
        }
        
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        model_();
        children();
    }
}


module cover(anchor=CENTER,spin=0,orient=UP)
{
    module cover_()
    {
        // s_r=1120;
        s_r=2000;
        cover_wall=200;
        rmtag="r09vrtq1";
        diff(rmtag)
        {
//            top_half(s=15000)
//            {
//                up(1000)
                rect_tube(size=[7500, 3950], wall=200, h=2000, rounding=300)
                {
                    position(TOP) down(1) cuboid([7500, 3950, 200], edges="Z", rounding=300,anchor=BOT);
                    // Mounting Tabs
                    position(BOT)
                    {
                        position(LEFT) cuboid([800,1000,300], edges=[LEFT+BACK,LEFT+FRONT], rounding=400, anchor=RIGHT+BOT)
                        tag(rmtag) position(TOP) up(1) cyl(d=300,h=150,anchor=TOP)
                        position(BOT) up(1) cyl(d=200,h=152,anchor=TOP);

                        position(RIGHT) cuboid([800,1000,300], edges=[RIGHT+BACK,RIGHT+FRONT], rounding=400, anchor=LEFT+BOT)
                        tag(rmtag) position(TOP) up(1) cyl(d=300,h=150,anchor=TOP)
                        position(BOT) up(1) cyl(d=200,h=152,anchor=TOP);

                        position(FRONT) cuboid([1000,800,300], edges=[RIGHT+FRONT,LEFT+FRONT], rounding=400, anchor=BACK+BOT)
                        tag(rmtag) position(TOP) up(1) cyl(d=300,h=150,anchor=TOP)
                        position(BOT) up(1) cyl(d=200,h=152,anchor=TOP);

                        position(BACK) cuboid([1000,800,300], edges=[RIGHT+BACK,LEFT+BACK], rounding=400, anchor=FRONT+BOT)
                        tag(rmtag) position(TOP) up(1) cyl(d=300,h=150,anchor=TOP)
                        position(BOT) up(1) cyl(d=200,h=152,anchor=TOP);
                    }
                }
            
                *conv_hull()
                {
                    translate([(7500/2)-1120, (3950/2)-1120,0]) // sphere(r=s_r)
                    cyl(r=s_r,h=2000);
                    translate([(7500/2)-1120, -(3950/2)+1120,0]) // sphere(r=s_r)
                    cyl(r=s_r,h=2000);
                    translate([-(7500/2)+1120, (3950/2)-1120,0]) // sphere(r=s_r)
                    cyl(r=s_r,h=2000);
                    translate([-(7500/2)+1120, -(3950/2)+1120,0]) // sphere(r=s_r)
                    cyl(r=s_r,h=2000);
                }



                *tag(rmtag) down(cover_wall) conv_hull()
                {
                    s_r2=s_r-cover_wall;
                    translate([(7500/2)-1120, (3950/2)-1120,0]) // sphere(r=s_r2)
                    cyl(r=s_r2,h=2000-cover_wall);
                    translate([(7500/2)-1120, -(3950/2)+1120,0]) // sphere(r=s_r2)
                    cyl(r=s_r2,h=2000-cover_wall);
                    translate([-(7500/2)+1120, (3950/2)-1120,0]) // sphere(r=s_r2)
                    cyl(r=s_r2,h=2000-cover_wall);
                    translate([-(7500/2)+1120, -(3950/2)+1120,0]) // sphere(r=s_r2)
                    cyl(r=s_r2,h=2000-cover_wall);
                }
                tag(rmtag) grid_copies(spacing=300,size=[7000,3500]) up(1950)
                    cuboid([200, 200, 300],anchor=BOT);
                tag(rmtag) translate([0, -4050/2, 1500]) xrot(-90) grid_copies(spacing=300,size=[6500,800]) 
                    cyl(d=200,h=300,anchor=BOT);
                    //cuboid([200, 200, 300],anchor=BOT);
                tag(rmtag) translate([0, 4050/2, 1500]) xrot(-90) grid_copies(spacing=300,size=[6500,800]) 
                    cyl(d=200,h=300,anchor=BOT);
//                    cuboid([200, 200, 300],anchor=TOP);
//            }
        }
    }
        
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        cover_();
        children();
    }
}


module forViewing()
{
//    model();
    recolor("cornflowerblue")
    cover();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
