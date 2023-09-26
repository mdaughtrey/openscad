ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>
include <../../BOSL2-master/walls.scad>
include <collars.scad>
//include <magnetic_collar_lib.scad>
$fn=96;
magnetd = 8/25.4*1000;
magneth = 3/25.4*1000;

//module magnetic_collar(anchor=CENTER,spin=0,orient=UP,thick=200)
//{
//    attachable(anchor,spin,orient,size=[1620,1620,thick])
//    {
//        rect_tube(h=thick,isize=1520,size=1620,irounding=50,rounding=100)
//        {
//            attach(FRONT+BOT,norot=1) magnetholder(anchor=BACK+BOT);
//            attach(BACK+BOT,norot=1) magnetholder(anchor=FRONT+BOT);
//            attach(LEFT+BOT,norot=1) magnetholder(anchor=RIGHT+BOT);
//            attach(RIGHT+BOT,norot=1) magnetholder(anchor=LEFT+BOT);
//        }
//        children();
//    }
//}

module magnetholder(anchor=CENTER,spin=0,orient=UP) 
{
    attachable(anchor,spin,orient,size=[magnetd+100,magnetd+100,magneth/2+30]) {
        diff() {
            cuboid([magnetd+100,magnetd+100,magneth/2+30],rounding=50,edges="Z")
            {
                tag("remove") attach(TOP) cyl(h=magneth/2,d=magnetd+20,anchor=TOP);
            }
        }
        children();
    }
}

module hood(anchor=CENTER,spin=0,orient=UP)
{
    $fn=96;
    diff()
    //cuboid([3900,4400,200],rounding=175,edges="Z") {
    cuboid([3300,4400,200],rounding=175,edges="Z") {
        tag("remove") down(1) attach(BOT,norot=1) {
            back(1990-21.25) left(750) cyl(d=175,h=204,anchor=BOT);
            back(1990-21.25) right(750) cyl(d=175,h=204,anchor=BOT);

            fwd(1990+21.25) left(891) cyl(d=175,h=204,anchor=BOT);
            fwd(1990+21.25) right(891) cyl(d=175,h=204,anchor=BOT);

            *right(3500/2) ycopies(500,8) cyl(d=175,h=204,anchor=BOT);
            *left(3500/2) ycopies(500,8) cyl(d=175,h=204,anchor=BOT);
            cuboid([2400,2400,202],rounding=180,edges="Z",anchor=BOT);
        }
        tag("keep")
        attach(TOP) rect_tube(h=2000,size=[2500,2500],isize=[2400,2400],
            size2=[1500,1500],isize2=[1350,1350],rounding=50)
        attach(TOP) rect_tube(h=500,size=1500,isize=1400,rounding=50,anchor=BOT)
        attach(TOP) down(200) rect_tube(h=200,isize=1420,size=1620,rounding=50,anchor=TOP);
    }
}

module forViewing()
{
    magnetic_collar(anchor=TOP);
}

module forPrinting()
{
    hood();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
