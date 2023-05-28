ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

// Circle translate, extrude, diameter, fh
module cted(t,e,d,f=96) { translate(t) linear_extrude(e) circle(d/2, $fn=f); }
// Square translate, extrude, x, y
module stexy(t,e,xy) { translate(t) linear_extrude(e) square(xy, center=true); }


module base()
{
    clearance=15;
    cuboid([1000,1000,50],rounding=40,edges="Z") {
        position(TOP+FRONT+LEFT)
        //cuboid([800,100,50+clearance],rounding=40,edges=[FRONT+LEFT,FRONT+RIGHT,BACK+LEFT],anchor=FRONT+BOTTOM+LEFT)
        cuboid([800,50,50+clearance],rounding=40,edges=FRONT+LEFT,anchor=FRONT+BOTTOM+LEFT)
        {
            position(BACK+LEFT+BOTTOM)
            cuboid([800,50,50+clearance],chamfer=40,edges=BACK+LEFT,anchor=FRONT+BOTTOM+LEFT);
            position(TOP+FRONT+LEFT)
            cuboid([1000,150,50],rounding=40,edges="Z",anchor=FRONT+BOTTOM+LEFT);
        }
        position(TOP+BACK+LEFT)
        cuboid([800,50,50+clearance],rounding=40,edges=BACK+LEFT,anchor=BACK+BOTTOM+LEFT)
        {
            position(FRONT+LEFT+BOTTOM)
            cuboid([800,50,50+clearance],chamfer=40,edges=FRONT+LEFT,anchor=BACK+BOTTOM+LEFT);
            position(TOP+BACK+LEFT)
            cuboid([1000,150,50],rounding=40,edges="Z",anchor=BACK+BOTTOM+LEFT);
        }

//        cuboid([800,100,50+clearance],rounding=40,edges=[FRONT+LEFT,BACK+LEFT,BACK+RIGHT],anchor=BACK+BOTTOM+LEFT)
//        position(TOP+BACK+LEFT)
//        cuboid([1000,150,50],rounding=40,edges="Z",anchor=BACK+BOTTOM+LEFT);
    }
}

module onecatch() 
{
    cuboid([800,50,50])
    position(RIGHT+BACK+TOP)
    yrot(90) wedge([50,150,150], orient=FRONT);
}

module slider()
{
    //cuboid([800,780,50]);
    onecatch();
}

module forViewing()
{
    base();
    color("cornflowerblue")
    up(60) left(100) slider();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
//    forViewing();
//    square([1000, 1000], anchor=BACK,spin=30)
//    position(FRONT+RIGHT)
//    circle(d=200, $fn=96, spin=0,anchor=FRONT)
//    show_anchors();
//    rect([1000,4000], chamfer=100);
//    hexagon(id=500, realign=true, rounding=80);
//    teardrop2d(r=200);
//xcopies(10*sqrt(2),n=3)
//    glued_circles(d=10,spread=10*sqrt(2),tangent=40);
//    cuboid([100,80,60],rounding=20,edges=TOP);
//    grid_copies(100,n=6) circle(20);

}
