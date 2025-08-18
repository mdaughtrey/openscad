ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>
include <../../models/model_5v_3v3_buck.scad>

$fn=96;
screwhole = 80;

module buck_retainer(anchor=CENTER,spin=0,orient=UP)
{
    l = model_5v_3v3_buck_length;
    w = model_5v_3v3_buck_width;
    h = model_5v_3v3_buck_height;
    rmtag = "av4341_remove";

    module buck_retainer_()
    {

        diff(rmtag)
        conv_hull(rmtag)
        cyl(h=90, d=200)
        {
            tag(rmtag)
            position(BOT) cyl(h=50, d=screwhole,anchor=BOT)
            position(TOP) cyl(h=40, d=150,anchor=BOT);
            back(w+240)
            cyl(h=90, d=200)
            tag(rmtag)
            position(BOT) cyl(h=50, d=screwhole,anchor=BOT)
            position(TOP) cyl(h=40, d=150,anchor=BOT);
        }
    }
    attachable(anchor,spin,orient,size=[w+600, 200, 90])
    {
        buck_retainer_(); children();
    }
}

module buck_mount(anchor=CENTER,spin=0,orient=UP,rmtag="bm_remove")
{
    l = model_5v_3v3_buck_length;
    w = model_5v_3v3_buck_width;
    h = model_5v_3v3_buck_height;
    module buck_mount_()
    {
        diff(rmtag)
        rect_tube(isize=[l-20,w-20],size=[l+90,w+90],h=100)
        {
            position(TOP)
            rect_tube(isize=[l+20,w+20],size=[l+90,w+90],h=40,anchor=BOT);
            position(BOT+FRONT) back(15) right(200) tube(h=230, id=screwhole, od=200, anchor=BOT+BACK);
            position(BOT+BACK) fwd(15) right(200) tube(h=230, id=screwhole, od=200, anchor=BOT+FRONT);
            position(BOT+FRONT) back(20) left(200) tube(id=100,od=200,h=200,anchor=BOT+BACK);
            position(BOT+BACK) fwd(20) left(200) tube(id=100,od=200,h=200,anchor=BOT+FRONT);
//            position(BOT)
//            {
//                fwd(w/2) cuboid([600, 100, 100], anchor=BOT)
//                position(BOT+FRONT+RIGHT) tube(h=230, id=screwhole, od=200, anchor=BOT+BACK+RIGHT);
//                back(w/2) cuboid([600, 100, 100], anchor=BOT)
//                position(BOT+BACK+RIGHT) tube(h=230, id=screwhole, od=200, anchor=BOT+FRONT+RIGHT);
//
//                left(l/2) cuboid([100, 200, 100], anchor=BOT);
//                right(l/2) cuboid([100, 200, 100], anchor=BOT);
//            }
//
//            tag(rmtag)
//            position(TOP) cuboid([l+20, w+20, 70], anchor=BOT);
//            *if (model)
//            {
//                tag("keep")
//                position(TOP)
//                model_5v_3v3_buck(anchor=BOT);
//            }
        }
    }
    attachable(anchor,spin,orient,size=[l+100, w+100+460, 230])
    {
        up(25) down(115)
        buck_mount_();
        children();
    }
}

// module modname(anchor=CENTER,spin=0,orient=UP)
// {
//     module modname_()
//     {
//     }
//     attachable(anchor,spin,orient,size=)
//     {
//         modname_();
//         children();
//     }
// }

module model_board(anchor=CENTER,spin=0,orient=UP)
{
    module model_board_()
    {
        rmtag = "avqw4c5";
        recolor("goldenrod")
        diff(rmtag)
        cuboid([3690,3960,50])
        {
            // Relay boards
            position(TOP+LEFT+BACK) recolor("cornflowerblue") right(600) fwd(310) cuboid([2000,1000,850], anchor=LEFT+BACK+BOT);
            position(TOP+LEFT+FRONT) recolor("cornflowerblue") right(600) back(350) cuboid([2000,1000,850], anchor=LEFT+FRONT+BOT);
            // Terminals
            position(TOP+LEFT+BACK) recolor("green") right(585) fwd(1460) cuboid([510,1000,510],anchor=BOT+LEFT+BACK);
            position(TOP+RIGHT+BACK) recolor("green") left(470) fwd(220) cuboid([313,400,600], anchor=RIGHT+BACK+BOT);
            // Buck Converter
            position(TOP+LEFT+BACK) recolor("green") right(1410) fwd(1460) cuboid([1000,1010,338],anchor=BOT+LEFT+BACK);
            // CPU
            position(TOP+RIGHT+BACK) recolor("cornflowerblue") right(130) fwd(1460) cuboid([1320,1130,570],anchor=BOT+RIGHT+BACK);
            // Buttons
            position(TOP+RIGHT+FRONT) recolor("darkgrey") left(340) back(700) cuboid([240,240,450], anchor=RIGHT+FRONT+BOT);
            position(TOP+RIGHT+BACK) recolor("darkgrey") left(340) fwd(700) cuboid([240,240,450], anchor=RIGHT+BACK+BOT);
            // Mounting Holes
            tag(rmtag)
            {
                position(TOP+LEFT+FRONT) right(130) back(180) up(1) cyl(d=110,h=52,anchor=TOP+LEFT+FRONT);
                position(TOP+LEFT+BACK) right(130) fwd(180) up(1) cyl(d=110,h=52,anchor=TOP+LEFT+BACK);
                position(TOP+RIGHT+BACK) left(140) fwd(310) up(1) cyl(d=110,h=52,anchor=TOP+RIGHT+BACK);
                position(TOP+RIGHT+FRONT) left(140) back(270) up(1) cyl(d=110,h=52,anchor=TOP+RIGHT+FRONT);
            }
        }
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        model_board_();
        children();
    }
}


module case(anchor=CENTER,spin=0,orient=UP)
{
    module case_()
    {
        offset=75;
        rmtag="v154r3asd";
        diff(rmtag)
        cuboid([3690+220,3960+220,50],rounding=100,edges="Z")
        {
            // Screw Mounts
            position(TOP+LEFT+FRONT) right(130+offset) back(180+offset) up(1) tube(id=80,wall=70,h=250,anchor=BOT+LEFT+FRONT);
            position(TOP+LEFT+BACK) right(130+offset) fwd(180+offset) up(1) tube(id=80,wall=70,h=250,anchor=BOT+LEFT+BACK);
            position(TOP+RIGHT+BACK) left(140+offset) fwd(310+offset) up(1) tube(id=80,wall=70,h=250,anchor=BOT+RIGHT+BACK);
            position(TOP+RIGHT+FRONT) left(140+offset) back(270+offset) up(1) tube(id=80,wall=70,h=250,anchor=BOT+RIGHT+FRONT);
            // Walls
            position(TOP+BACK) cuboid([3690+220,100,1300],anchor=BOT+BACK,rounding=100,edges=[BACK+LEFT,BACK+RIGHT]);
            position(TOP+FRONT) cuboid([3690+220,100,1300],anchor=BOT+FRONT,rounding=100,edges=[FRONT+LEFT,FRONT+RIGHT])
            {
                // Top
                position(TOP+FRONT) cuboid([3690+220,3960+220,100],rounding=100,edges="Z",anchor=BOT+FRONT)
                tag(rmtag)
                {
                    // Screw holes
                    position(TOP+LEFT+FRONT) right(130+offset) back(180+offset) up(1) cyl(d=150,h=102,anchor=TOP+LEFT+FRONT);
                    position(TOP+LEFT+BACK) right(130+offset) fwd(180+offset) up(1) cyl(d=150,h=102,anchor=TOP+LEFT+BACK);
                    position(TOP+RIGHT+BACK) left(140+offset) fwd(310+offset) up(1) cyl(d=150,,h=102,anchor=TOP+RIGHT+BACK);
                    position(TOP+RIGHT+FRONT) left(140+offset) back(270+offset) up(1) cyl(d=150,h=102,anchor=TOP+RIGHT+FRONT);
                    // Terminal cutouts
                    position(LEFT+TOP+BACK) right(900) fwd(400) up(1) cuboid([300,1050,102],rounding=100,edges="Z",anchor=TOP+BACK);
                    position(LEFT+TOP+FRONT) right(900) back(400) up(1) cuboid([300,1050,102],rounding=100,edges="Z",anchor=TOP+FRONT);
                    position(LEFT+TOP) right(800) up(1) cuboid([400,950,102],rounding=100,edges="Z",anchor=TOP);
                    position(RIGHT+TOP+BACK) left(700) fwd(350) up(1) cuboid([400,400,102],rounding=100,edges="Z",anchor=TOP+RIGHT+BACK);
                }
                // Shelf Mounts
                position(FRONT) back(1) up(250) cuboid([3690,800,400],anchor=BACK+BOT,rounding=100,edges=[FRONT]);
                position(FRONT) back(1) down(250) cuboid([3690,800,400],anchor=BACK+TOP,rounding=100,edges=[FRONT]);
                
            }
            position(TOP+LEFT) cuboid([100,3960+220,300],anchor=BOT+LEFT,rounding=100,edges=[FRONT+LEFT,BACK+LEFT]);
            position(TOP+RIGHT) cuboid([100,3960+220,300],anchor=BOT+RIGHT,rounding=100,edges=[FRONT+RIGHT,BACK+RIGHT]);
        }
    
    }
    attachable(anchor,spin,orient,size=[3690+220,3960+220,100])
    {
        case_();
        children();
    }
}

module forViewing()
{
//    buck_mount();
//    buck_retainer();
    case();
    up(300)
    model_board();
}

module forPrinting()
{
    case();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
