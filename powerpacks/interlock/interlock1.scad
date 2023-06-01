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

module sliderhalf0()
{
    cuboid([1200,100,100], anchor=FRONT) {
        back(300)
        intersect()  
        cyl(r=2000,h=100,$fn=96,anchor=BACK, rounding=20)
        tag("intersect") position(BACK) cuboid([1000,200,100],anchor=BACK);
        left(400) back(5)
        intersect()  {
            tube(ir=50,or=150,h=100, anchor=RIGHT+BACK)
            tag("intersect") cuboid([200, 400,100], anchor=RIGHT);
        }
        fwd(200) left(10)
        cuboid([1000,100,100]) {
            position(RIGHT)
            left(150) fwd(100)
            intersect()  {
                tube(ir=50,or=150,h=100, anchor=LEFT)
                tag("intersect") cuboid([201, 401,100], anchor=LEFT);
                tag("keep") left(450) fwd(100) cuboid([1200,100,100]); 
            }
        }
    }
}

module sliderhalf()
{
    module hook()
    {
    cuboid([1000,50,100])
    position(RIGHT+FRONT)
    intersect()   
    tube(ir=100,or=150,h=100, anchor=FRONT)
    tag("intersect") cuboid([200, 400,100], anchor=LEFT);
    }
    hook();
    back(250) xflip() hook();
    back(500) right(50) cuboid([1100,50,100]);
    back(550) cuboid([1000,50,100]);
    back(625) intersect()
    cyl(r=2000,h=100,$fn=96,anchor=BACK, rounding=20)
    tag("intersect") position(BACK) cuboid([1000,100,100],anchor=BACK);


//    ycopies(200,n=3) cuboid([1000,100,100]);
//    position(RIGHT) hook();
//    intersect()  {
//    tube(ir=50,or=150,h=100, anchor=FRONT)
//    tag("intersect") cuboid([200, 400,100], anchor=LEFT);
//    }

//    attachable(BACK+RIGHT) { hook(); children();}
//    #hook();
//    back(200) xflip()
//    attachable(LEFT) { hook(); children(); }
//    position(BACK) hook();


//    tag("keep") cuboid([1000,100,100], anchor=RIGHT);

//    cuboid([1200,100,100], anchor=FRONT) {
//        back(300)
//        intersect()  
//        cyl(r=2000,h=100,$fn=96,anchor=BACK, rounding=20)
//        tag("intersect") position(BACK) cuboid([1000,200,100],anchor=BACK);
//        left(400) back(5)
//        intersect()  {
//            tube(ir=50,or=150,h=100, anchor=RIGHT+BACK)
//            tag("intersect") cuboid([200, 400,100], anchor=RIGHT);
//        }
//        fwd(200) left(10)
//        cuboid([1000,100,100]) {
//            position(RIGHT)
//            left(150) fwd(100)
//            intersect()  {
//                tube(ir=50,or=150,h=100, anchor=LEFT)
//                tag("intersect") cuboid([201, 401,100], anchor=LEFT);
//                tag("keep") left(450) fwd(100) cuboid([1200,100,100]); 
//            }
//        }
//    }
}

module slider()
{
//    cuboid([200,1000,100], anchor=RIGHT) {
//    position(RIGHT) back(400) sliderhalf();
//    position(RIGHT) fwd(400) yflip() sliderhalf();
//    }
    sliderhalf();
//    fwd(700)
//    yflip() sliderhalf();
}

module forViewing()
{
//    base();
//    color("cornflowerblue")
    slider();
}

module forPrinting()
{
//    base();
//    right(1500)
    slider();
}

scale(ViewScale)
{
    forViewing();
//    forPrinting();
}
