ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

$fn=96;

/// module modname(anchor=CENTER,spin=0,orient=UP)
/// {
///     module modname_()
///     {
///     }
///     attachable(anchor,spin,orient,size=)
///     {
///         modname_();
///         children();
///     }
/// }

// 7 3/8 = 7375
// 9/16 = 560

module model_vent(anchor=CENTER,spin=0,orient=UP)
{
    module model_vent_()
    { 
        rmtag="cqavqv45r";
        recolor("black")
        diff(rmtag)
        ////cuboid([6000,7000,63],rounding=340,edges="Z",anchor=BOT)
        cuboid([6000,7000,63],anchor=BOT)
        {
            // Screw Holes
            tag(rmtag)
            {
                position(RIGHT+TOP+BACK) left(225) up(1)
                fwd(1100) cyl(d=190,h=65,anchor=TOP);
                position(RIGHT+TOP+FRONT) left(225) up(1)
                back(800) cyl(d=190,h=65,anchor=TOP);

                position(LEFT+TOP+BACK) right(225) up(1)
                fwd(1100) cyl(d=190,h=65,anchor=TOP);
                position(LEFT+TOP+FRONT) right(225) up(1)
                back(800) cyl(d=190,h=65,anchor=TOP);
            }
            // Bottom silver rivets
            recolor("silver")
            position(BACK+TOP)
            {
                fwd(220)
                {
                    left(2160/2) cyl(d=156,h=120,anchor=BOT)
                    position(BOT) left(620) cyl(d=156,h=120,anchor=BOT);
                    right(2160/2) cyl(d=156,h=120,anchor=BOT)
                    position(BOT) right(620) cyl(d=156,h=120,anchor=BOT);
                }
            }
            // Side Rivets
            recolor("gray")
            position(TOP+RIGHT+BACK) left(225)
            fwd(783) cyl(d=253,h=55,anchor=BOT)
            fwd(1366) cyl(d=253,h=55) fwd(1584) cyl(d=253,h=55) fwd(1584) cyl(d=253,h=55);

            recolor("gray")
            position(TOP+LEFT+BACK) right(225)
            fwd(783) cyl(d=253,h=55,anchor=BOT)
            fwd(1366) cyl(d=253,h=55) fwd(1584) cyl(d=253,h=55) fwd(1584) cyl(d=253,h=55);

            // Top Black Rivets
            recolor("gray")
            position(FRONT+TOP)
            back(250)
            {
                left(1960/2) cyl(d=156,h=120,anchor=BOT)
                position(BOT) left(1800) cyl(d=156,h=120,anchor=BOT);
                right(1960/2) cyl(d=156,h=120,anchor=BOT)
                position(BOT) right(1800) cyl(d=156,h=120,anchor=BOT);
            }

            // Top Silver Rivets
            recolor("silver")
            position(FRONT+TOP)
            back(1160)
            {
                left(2160/2) cyl(d=156,h=60,anchor=BOT)
                position(BOT) left(630) cyl(d=156,h=60,anchor=BOT);
                right(2160/2) cyl(d=156,h=60,anchor=BOT)
                position(BOT) right(630) cyl(d=156,h=60,anchor=BOT);
            }

            // Pipe
            recolor("silver")
            position(BACK+TOP)
            fwd(1560) down(1)
            tube(od=3050,wall=35,h=2000,anchor=BACK+BOT);
        }
    
    }
    attachable(anchor,spin,orient,size=[6000,7000,2063])
    {
        down(2063/2)
        model_vent_();
        children();
    }
}

module vent_cutout(anchor=CENTER,spin=0,orient=UP)
{
    thickness=100;
    module vent_cutout_()
    { 
        rmtag="cvqv45r";
        diff(rmtag)
        ////cuboid([6000,7000,thickness],rounding=340,edges="Z",anchor=BOT)
        cuboid([6000,7000,thickness],anchor=BOT)
        {
            // Screw Holes
            tag(rmtag)
            {
                position(RIGHT+TOP+BACK) left(225) up(1)
                fwd(1100) cyl(d=190,h=thickness+2,anchor=TOP);
                position(RIGHT+TOP+FRONT) left(225) up(1)
                back(800) cyl(d=190,h=thickness+2,anchor=TOP);

                position(LEFT+TOP+BACK) right(225) up(1)
                fwd(1100) cyl(d=190,h=thickness+2,anchor=TOP);
                position(LEFT+TOP+FRONT) right(225) up(1)
                back(800) cyl(d=190,h=thickness+2,anchor=TOP);
            }
            // Bottom silver rivets
            tag(rmtag)
            position(BACK+TOP)
            {
                fwd(220)
                {
                    left(2190/2) up(1) cyl(d=250,h=122,anchor=TOP)
                    position(TOP) left(635) cyl(d=250,h=122,anchor=TOP);
                    right(2190/2) up(1) cyl(d=250,h=122,anchor=TOP)
                    position(TOP) right(635) cyl(d=250,h=120,anchor=TOP);
                }
            }
            // Side Rivets
            tag(rmtag)
            position(TOP+RIGHT+BACK) left(200)
            fwd(783) up(1) cyl(d=300,h=thickness+2,anchor=TOP)
            fwd(1366) cyl(d=300,h=thickness+2) fwd(1584) cyl(d=300,h=thickness+2) fwd(1584) cyl(d=300,h=thickness+2);

            tag(rmtag)
            position(TOP+LEFT+BACK) right(200)
            fwd(783) up(1) cyl(d=300,h=thickness+2,anchor=TOP)
            fwd(1366) cyl(d=300,h=thickness+2) fwd(1584) cyl(d=300,h=thickness+2) fwd(1584) cyl(d=300,h=thickness+2);

            // Top Black Rivets
            tag(rmtag)
            position(FRONT+TOP)
            back(250)
            {
                left(1960/2) up(1) cyl(d=300,h=thickness+2,anchor=TOP)
                position(TOP) left(1800) cyl(d=300,h=thickness+2,anchor=TOP);
                right(1960/2) up(1) cyl(d=300,h=thickness+2,anchor=TOP)
                position(TOP) right(1800) cyl(d=300,h=thickness+2,anchor=TOP);
            }

            // Top Silver Rivets
            tag(rmtag)
            position(FRONT+TOP)
            back(1160)
            {
                left(2160/2) up(1) cyl(d=250,h=thickness+2,anchor=TOP)
                position(TOP) left(630) cyl(d=250,h=thickness+2,anchor=TOP);
                right(2160/2) up(1) cyl(d=250,h=thickness+2,anchor=TOP)
                position(TOP) right(630) cyl(d=250,h=thickness+2,anchor=TOP);
            }

            // Pipe
            tag(rmtag)
            position(BACK+TOP)
            fwd(1560+3050/2) up(1)
            cyl(d=3300,h=thickness+2,anchor=TOP);
        }
    
    }
    attachable(anchor,spin,orient,size=[6000,7000,thickness])
    {
        down(thickness/2)
        vent_cutout_();
        children();
    }
}

module siding_shim(anchor=CENTER,spin=0,orient=UP)
{
    module siding_shim_()
    {
        rmtag="cqr43"; 
        itag="avc4qr";
        intersect(itag)
        {
            diff(rmtag)
            wedge([6000, 7500*0.82, 560*0.82])
            {
                position(TOP+FRONT) down(1) xrot(-4.2) wedge([6000,3300,150],anchor=BOT+FRONT);
//                tag(rmtag) position(BOT) cuboid([6000,7000,100],anchor=BOT);
                *position(FRONT+BOT) cuboid([6000,6000,200],anchor=TOP+FRONT)
                {
                    tag(rmtag) position(BOT+FRONT) back(625)  down(1) cyl(d=3000,h=1000,anchor=BOT+FRONT)
                    *tag("keep") position(BOT) up(200) tube(od=4730,wall=450,h=300,anchor=TOP)
                    {
                        tag(rmtag)
                        {
                            position(BOT+RIGHT) left(170) down(2)  cyl(d=150,h=804,anchor=BOT+RIGHT);
                            position(BOT+LEFT) right(170) down(2) cyl(d=150,h=804,anchor=BOT+LEFT);
                        }
                    }
                }
                *tag(rmtag) position(BOT+BACK) down(1) cuboid([6000,1500,402], anchor=BOT+BACK);
                
                recolor("cyan")
                position(BOT+FRONT) up(1) fwd(1400) vent_cutout(anchor=TOP+FRONT)
                position(BACK) cuboid([6000,600,100],anchor=FRONT);
                // Pipe
                tag(rmtag)
                position(FRONT+BOT)
                back(865+3300/2) down(1)
                cyl(d=3300,h=600,anchor=BOT);

                // Screw Holes
                tag(rmtag) fwd(550)
                {
                    position(RIGHT+BOT+BACK) left(225) down(1)
                    fwd(1100) cyl(d=190,h=360,anchor=BOT);
                    position(LEFT+BOT+BACK) right(225) down(1)
                    fwd(1100) cyl(d=190,h=360,anchor=BOT);
                }
            }
            tag(itag) cuboid([6000,6000,1500],anchor=LEFT+FRONT);
        }
    }
    attachable(anchor,spin,orient,size=[6000,7500,560])
    {
        fwd(3000) left(7500/2) down(280)
        siding_shim_();
        children();
    }
}

module case()
{
}

module forViewing()
{
///    model_vent()
 //   recolor("yellow") 
///    position(BOT) vent_cutout(anchor=BOT);
//    vent_cutout();
    siding_shim();
}

module forPrinting()
{
    flap_assembly();
}

scale(ViewScale)
{
    forViewing();
//    forPrinting();
}

