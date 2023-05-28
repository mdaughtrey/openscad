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

// module onecatch() 
// {
//     cuboid([800,50,50],anchor=LEFT)
//     position(RIGHT+BACK+TOP)
//     yrot(90) wedge([50,250,300], orient=FRONT);
// }

module sliderhalf()
{
    diff("cutout")  
    cuboid([800,390,50], anchor=BACK)
    position(RIGHT+BACK)
    tag("cutout") back(1) right(1)cuboid([600,300,51],anchor=RIGHT+BACK,rounding=40,edges=FRONT+LEFT); 

    position(LEFT)
    cuboid([800,50,50],anchor=LEFT);
//    position(RIGHT+BACK+TOP)
//    yrot(90) wedge([50,250,300], orient=FRONT);
}

module slider()
{
    sliderhalf();
    //diff("cutout")
    //cuboid([800,780,50]);
    //right(1) position(RIGHT) tag("cutout") cuboid([600,600,51],anchor=RIGHT,rounding=40,edges=[FRONT+LEFT,BACK+LEFT]);
    //onecatch();
    //#right(10) fwd(250) onecatch();
    //right(10) back(250) yflip()  onecatch();
}

module forViewing()
{
    base();
    color("cornflowerblue")
    up(60) left(100) slider();
}

module forPrinting()
{
    base();
    right(1500)
    slider();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
