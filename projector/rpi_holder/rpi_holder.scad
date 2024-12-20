ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

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

module case()
{
    mX=3860; // modelX
    mY=1270; // modelY
    mZ=2760; // modelZ

    wall=200;
    clearance=50;
    bottomX = mX+clearance*2+wall*2;
    bottomY = mY+clearance*2+wall*2;
    // Case model
    *up(mZ/2)
    recolor("cornflowerblue") 
    cuboid([mX,mY,mZ],rounding=100)
    {
        attach(RIGHT+BOT+BACK, norot=1) recolor("cyan")  fwd(300) up(310)
        cuboid([100, 660, 2120], anchor=LEFT+BOT+BACK);
        attach(TOP+LEFT+FRONT, norot=1) recolor("cyan") back(190) right(330)
        cuboid([1860, 510, 100], anchor=LEFT+BOT+FRONT);
    }

    diff("case_remove")
    cuboid([bottomX, bottomY, 100], rounding=100, edges="Z")
    {
        // Left back
        attach(LEFT+BACK+TOP, norot=1)
        {
            cuboid([500, 200, mZ-1000], rounding=100, edges=LEFT+BACK, anchor=LEFT+BACK+BOT);
            cuboid([200, 500, mZ-1000], rounding=100, edges=LEFT+BACK, anchor=LEFT+BACK+BOT);
        }
        // Left front
        attach(LEFT+FRONT+TOP, norot=1)
        {
            cuboid([700, 200, mZ+300], rounding=100, edges=LEFT+FRONT, anchor=LEFT+FRONT+BOT);
            cuboid([200, 500, mZ+300], rounding=100, edges=LEFT+FRONT, anchor=LEFT+FRONT+BOT);
        }
        // Right back
        attach(RIGHT+BACK+TOP, norot=1)
        {
            cuboid([500, 200, mZ-1000], rounding=100, edges=RIGHT+BACK, anchor=RIGHT+BACK+BOT);
//            cuboid([200, 500, mZ], rounding=100, edges=RIGHT+BACK, anchor=RIGHT+BACK+BOT);
        }
        attach(RIGHT+FRONT+TOP, norot=1)
        {
            cuboid([700, 200, mZ+300], rounding=100, edges=RIGHT+FRONT, anchor=RIGHT+FRONT+BOT);
//            cuboid([200, 500, mZ], rounding=100, edges=RIGHT+FRONT, anchor=RIGHT+FRONT+BOT);
        }
        
        attach(RIGHT+TOP, norot=1)
        cuboid([200,bottomY, 200], anchor=BOT+RIGHT, rounding=100, edges="Z");
        tag("case_remove")
        up(mZ+200) fwd(mY/2+100)
        xcopies(3500,n=2) cyl(d=180,h=350, orient=BACK);
    }
    *up(mZ) fwd(mY/2)
    xcopies(3500,n=2) cyl(d=180,h=100, orient=BACK);
}

module case0()
{
    wall=200;
    clearance=50;
    mX=3860; // modelX
    mY=1270; // modelY
    mZ=2760; // modelZ

    bottomX = mX+clearance*2+wall*2;
    bottomY = mY+clearance*2+wall*2;
    diff()
    // Bottom

    cuboid([bottomX,bottomY,wall],rounding=wall,edges="Z") {
        // Case model
        *recolor("cornflowerblue") attach(TOP)
        cuboid([mX,mY,mZ],rounding=100,anchor=BOT);

        tag("remove") attach(LEFT+BACK,norot=1) right(wall+clearance+380) fwd(wall+clearance+200) cuboid([1900,530,wall+1],rounding=200,edges="Z",anchor=LEFT+BACK);
        // Back Wall
        attach(BACK+BOT,norot=1) cuboid([bottomX,wall,wall*2 + clearance + mZ],anchor=BACK+BOT,rounding=wall,edges=[BACK+LEFT,BACK+RIGHT])
        tag("remove") cuboid([bottomX-wall*4,wall+1,clearance+mZ-wall*2],rounding=wall,edges="Y");
        // Front Wall
        attach(FRONT+BOT,norot=1) cuboid([bottomX,wall,wall*2+clearance+mZ],anchor=FRONT+BOT,rounding=wall,edges=[FRONT+LEFT,FRONT+RIGHT]) {
            tag("remove") cuboid([bottomX-wall*4,wall+1,clearance+mZ-wall*2],rounding=wall,edges="Y");
             // Vex Mount
            attach(TOP,norot=1) cuboid([bottomX+200,wall,300],rounding=50,edges="Z",anchor=BOT) {
                tag("remove") left(2000) cyl(d=180,h=wall+2,orient=FRONT);
                tag("remove") right(2000) cyl(d=180,h=wall+2,orient=FRONT);
            }
        }

        // Left Wall
        attach(LEFT+BOT,norot=1) cuboid([wall,bottomY,wall*2+clearance+mZ],anchor=LEFT+BOT,rounding=wall,edges=[FRONT+LEFT,BACK+LEFT])
        tag("remove") cuboid([wall+1,bottomY-wall*4,clearance+mZ-wall*2],rounding=wall,edges="X");
        // Right Wall
        attach(RIGHT+BOT,norot=1) cuboid([wall,bottomY,wall*2+clearance+mZ],anchor=RIGHT+BOT,rounding=wall,edges=[FRONT+RIGHT,BACK+RIGHT])
        tag("remove") cuboid([wall+1,bottomY-wall*4,clearance+mZ-wall*2],rounding=wall,edges="X");
        



    }
    
}

module forViewing()
{
    case();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
