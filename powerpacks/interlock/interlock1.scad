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
//    intersect()  
//    cyl(r=1000,h=100)
//    tag("intersect") position(BACK) cuboid([1000,300,100],anchor=BACK)
//    tag("keep") position(FRONT) cuboid([1200,100,100], anchor=BACK);
    intersect()
    shell2d(thickness=5) circle(100)
    #tag("intersect") square([200,200],anchor=LEFT);
    
//    ycopies(n=3,200)
//    cuboid([1000,100,100], anchor=FRONT);
//    position(RIGHT)
//    right_half() circle(r=300);
//    left_half() cyl(r=300,h=100);
//    cuboid([1000,500,100], anchor=FRONT);

}

module slider()
{
    sliderhalf();
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
