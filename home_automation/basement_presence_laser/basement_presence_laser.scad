ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

$fn=96;
model=0;

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

module base_back(anchor=CENTER,spin=0,orient=UP)
{
    height = 1000;
    module base_back_()
    {
        cuboid([1240,300,height],rounding=100,edges=[BACK+LEFT,BACK+RIGHT])
        {
            position(LEFT+FRONT) cuboid([300,1830,height],anchor=BACK+LEFT)
            {
                position(LEFT+FRONT) cuboid([100,400,height],anchor=RIGHT+FRONT);
                position(RIGHT+TOP+FRONT) cuboid([400,400,1000],anchor=RIGHT+BOT+FRONT);
            }
            position(RIGHT+FRONT) cuboid([300,1830,height],anchor=BACK+RIGHT)
            {
                position(RIGHT+FRONT) cuboid([100,400,height],anchor=LEFT+FRONT);
                position(LEFT+TOP+FRONT) cuboid([400,400,1000],anchor=LEFT+BOT+FRONT);
            }
        }
    }
    attachable(anchor,spin,orient,size=[1440,1300,height])
    {
        fwd(150)
        back(1300/2)
        base_back_();
        children();
    }
}

module base_socket(anchor=CENTER,spin=0,orient=UP)
{
    height = 1000;
    module base_socket_()
    {
        rmtag="vr2qrde";
        diff(rmtag)
        cuboid([1800,800,height])
        {
            tag(rmtag)
            {
                position(BACK) left(470) up(1) cuboid([330,620,height+2],anchor=BACK)
                position(FRONT+LEFT) cuboid([100,420,height+2], anchor=FRONT+RIGHT);
                position(BACK) right(470) up(1) cuboid([330,620,height+2],anchor=BACK)
                position(FRONT+RIGHT) cuboid([100,420,height+2], anchor=FRONT+LEFT);
            }
            position(TOP) cuboid([1800,800,100],anchor=BOT);
//            position(LEFT+FRONT) cuboid([100,400,height],anchor=RIGHT+FRONT);
//            position(RIGHT+FRONT) cuboid([300,1000,height],anchor=BACK+RIGHT)
//            position(RIGHT+FRONT) cuboid([100,400,height],anchor=LEFT+FRONT);
        }
    }
    attachable(anchor,spin,orient,size=[1800,800,height])
    {
        base_socket_();
        children();
    }
}



// module case(anchor=CENTER,spin=0,orient=UP)
// {
//     module case_()
//     {
//         offset=75;
//         rmtag="v154r3asd";
//         diff(rmtag)
//         cuboid([3690+220,3960+220,50],rounding=100,edges="Z")
//         {
//             // Screw Mounts
//             position(TOP+LEFT+FRONT) right(130+offset) back(180+offset) up(1) tube(id=80,wall=70,h=250,anchor=BOT+LEFT+FRONT);
//             position(TOP+LEFT+BACK) right(130+offset) fwd(180+offset) up(1) tube(id=80,wall=70,h=250,anchor=BOT+LEFT+BACK);
//             position(TOP+RIGHT+BACK) left(140+offset) fwd(310+offset) up(1) tube(id=80,wall=70,h=250,anchor=BOT+RIGHT+BACK);
//             position(TOP+RIGHT+FRONT) left(140+offset) back(270+offset) up(1) tube(id=80,wall=70,h=250,anchor=BOT+RIGHT+FRONT);
//             // Walls
//             position(TOP+BACK) cuboid([3690+220,100,1300],anchor=BOT+BACK,rounding=100,edges=[BACK+LEFT,BACK+RIGHT]);
//             position(TOP+FRONT) cuboid([3690+220,100,1300],anchor=BOT+FRONT,rounding=100,edges=[FRONT+LEFT,FRONT+RIGHT])
//             {
//                 // Top
//                 position(TOP+FRONT) cuboid([3690+220,3960+220,100],rounding=100,edges="Z",anchor=BOT+FRONT)
//                 tag(rmtag)
//                 {
//                     // Screw holes
//                     position(TOP+LEFT+FRONT) right(130+offset) back(180+offset) up(1) cyl(d=150,h=102,anchor=TOP+LEFT+FRONT);
//                     position(TOP+LEFT+BACK) right(130+offset) fwd(180+offset) up(1) cyl(d=150,h=102,anchor=TOP+LEFT+BACK);
//                     position(TOP+RIGHT+BACK) left(140+offset) fwd(310+offset) up(1) cyl(d=150,,h=102,anchor=TOP+RIGHT+BACK);
//                     position(TOP+RIGHT+FRONT) left(140+offset) back(270+offset) up(1) cyl(d=150,h=102,anchor=TOP+RIGHT+FRONT);
//                     // Terminal cutouts
//                     position(LEFT+TOP+BACK) right(900) fwd(400) up(1) cuboid([300,1050,102],rounding=100,edges="Z",anchor=TOP+BACK);
//                     position(LEFT+TOP+FRONT) right(900) back(400) up(1) cuboid([300,1050,102],rounding=100,edges="Z",anchor=TOP+FRONT);
//                     position(LEFT+TOP) right(800) up(1) cuboid([400,950,102],rounding=100,edges="Z",anchor=TOP);
//                     position(RIGHT+TOP+BACK) left(700) fwd(350) up(1) cuboid([400,400,102],rounding=100,edges="Z",anchor=TOP+RIGHT+BACK);
//                 }
//                 // Shelf Mounts
//                 position(FRONT) back(1) up(250) cuboid([3690,800,400],anchor=BACK+BOT,rounding=100,edges=[FRONT]);
//                 position(FRONT) back(1) down(250) cuboid([3690,800,400],anchor=BACK+TOP,rounding=100,edges=[FRONT]);
//                 
//             }
//             position(TOP+LEFT) cuboid([100,3960+220,300],anchor=BOT+LEFT,rounding=100,edges=[FRONT+LEFT,BACK+LEFT]);
//             position(TOP+RIGHT) cuboid([100,3960+220,300],anchor=BOT+RIGHT,rounding=100,edges=[FRONT+RIGHT,BACK+RIGHT]);
//         }
//     
//     }
//     attachable(anchor,spin,orient,size=[3690+220,3960+220,100])
//     {
//         case_();
//         children();
//     }
// }

boardX = 2738;
boardY = 2350;
module model_board(anchor=CENTER,spin=0,orient=UP)
{
    module model_board_()
    {
        rmtag = "avqw4c5";
        recolor("goldenrod")
        diff(rmtag)
        cuboid([boardX,boardY,50])
        {
            // Terminals
            position(TOP+LEFT+BACK) recolor("green") fwd(815) cuboid([510,500,510],anchor=BOT+LEFT+BACK);
            // CPU
            position(TOP+LEFT+BACK) recolor("purple") right(630) fwd(320) cuboid([1150,1770,330],anchor=BOT+LEFT+BACK);
            // Radar Sensor
            position(TOP+RIGHT+BACK) recolor("blue") left(60) fwd(778) cuboid([630,870,170],anchor=BOT+RIGHT+BACK);
            // Mounting Holes
            tag(rmtag)
            {
                position(TOP+LEFT+FRONT) right(200) back(300) up(1) cyl(d=110,h=52,anchor=TOP);
                position(TOP+LEFT+BACK) right(200) fwd(200) up(1) cyl(d=110,h=52,anchor=TOP);
                position(TOP+RIGHT+BACK) left(400) fwd(400) up(1) cyl(d=110,h=52,anchor=TOP);
                position(TOP+RIGHT+FRONT) left(400) back(400) up(1) cyl(d=110,h=52,anchor=TOP);
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
        wallheight = 800;
        offset=110;
        rmtag="v154rasd";
        diff(rmtag)
        cuboid([boardX+220,boardY+220,50],rounding=100,edges="Z")
        {
            // Base Socket
            position(LEFT+BOT) right(100) base_socket(anchor=FRONT+TOP,orient=LEFT,spin=90);
            // Screw Mounts
            position(TOP+LEFT+FRONT) right(200+offset) back(300+offset) up(1) tube(id=80,wall=70,h=250,anchor=BOT);
            position(TOP+LEFT+BACK) right(200+offset) fwd(200+offset) up(1) tube(id=80,wall=70,h=250,anchor=BOT);
            position(TOP+RIGHT+BACK) left(400+offset) fwd(400+offset) up(1) tube(id=80,wall=70,h=250,anchor=BOT);
            position(TOP+RIGHT+FRONT) left(400+offset) back(400+offset) up(1) tube(id=80,wall=70,h=250,anchor=BOT);
            // Walls
            position(TOP+BACK+LEFT) cuboid([boardX+220-1000,100,wallheight],anchor=BOT+BACK+LEFT,rounding=100,edges=[BACK+LEFT,BACK+RIGHT]);
            position(TOP+FRONT+LEFT) cuboid([boardX+220-1000,100,wallheight],anchor=BOT+FRONT+LEFT,rounding=100,edges=[FRONT+LEFT,FRONT+RIGHT])
            {
                // Top
                position(TOP+FRONT+LEFT) cuboid([boardX+220-1000,boardY+220,100],rounding=100,edges="Z",anchor=BOT+FRONT+LEFT)
                tag(rmtag)
                {
                    // Screw holes
                    position(TOP+LEFT+FRONT) right(200+offset) back(300+offset) up(1) cyl(d=180,h=102,anchor=TOP);
                    position(TOP+LEFT+BACK) right(200+offset) fwd(200+offset) up(1) cyl(d=180,h=102,anchor=TOP);
                    *position(TOP+RIGHT+BACK) left(400+offset) fwd(400+offset) up(1) cyl(d=180,,h=102,anchor=TOP+RIGHT+BACK);
                    *position(TOP+RIGHT+FRONT) left(400+offset) back(400+offset) up(1) cyl(d=180,h=102,anchor=TOP+RIGHT+FRONT);
                    // Terminal cutouts
                    position(TOP+LEFT+BACK) left(1) fwd(880) up(1) cuboid([700,600,102],anchor=TOP+LEFT+BACK,
                        rounding=100,edges=[BACK+RIGHT,FRONT+RIGHT]);
                    // Rounding corners
                    position(TOP) back(1690) up(1) edge_mask([LEFT+FRONT]) rounding_edge_mask(l=102,r=100,anchor=TOP);
                    position(TOP) fwd(1480) down(100) down(1) edge_mask([LEFT+BACK]) rounding_edge_mask(l=102,r=100,anchor=TOP);

/// cuboid([700,600,102],anchor=TOP+LEFT+BACK,
////                        rounding=100,edges=[BACK+RIGHT,FRONT+RIGHT]);
                    
                    *position(LEFT+TOP+BACK) right(900) fwd(400) up(1) cuboid([300,1050,102],rounding=100,edges="Z",anchor=TOP+BACK);
                    *position(LEFT+TOP+FRONT) right(900) back(400) up(1) cuboid([300,1050,102],rounding=100,edges="Z",anchor=TOP+FRONT);
                    *position(LEFT+TOP) right(800) up(1) cuboid([400,950,102],rounding=100,edges="Z",anchor=TOP);
                    *position(RIGHT+TOP+BACK) left(700) fwd(350) up(1) cuboid([400,400,102],rounding=100,edges="Z",anchor=TOP+RIGHT+BACK);
                }
                // Shelf Mounts
                *position(FRONT) back(1) up(250) cuboid([3690,800,400],anchor=BACK+BOT,rounding=100,edges=[FRONT]);
                *position(FRONT) back(1) down(250) cuboid([3690,800,400],anchor=BACK+TOP,rounding=100,edges=[FRONT]);
                
            }
            position(TOP+LEFT) cuboid([100,boardY+220,300],anchor=BOT+LEFT,rounding=100,edges=[FRONT+LEFT,BACK+LEFT]);
            position(TOP+RIGHT) cuboid([100,boardY+220,300],anchor=BOT+RIGHT,rounding=100,edges=[FRONT+RIGHT,BACK+RIGHT]);
        }
    
    }
    attachable(anchor,spin,orient,size=[3690+220,3960+220,100])
    {
        case_();
        children();
    }
}

module corners()
{
    rmtag="qre3";
    diff(rmtag)
   cuboid([1000,1000,1000])
//    {
        tag(rmtag) corner_mask([BACK+LEFT])
        move([100,100,100])
        difference()
        {
            cuboid([200,200,200]);
            move([100,100,100]) sphere(r=200);
        }
//    }
}

module forViewing()
{
//    corners();
    up(300)
    model_board();
    case();
}
    

module forPrinting()
{
    case();
}
    

scale(ViewScale)
{
///    forViewing();
    forPrinting();
}
