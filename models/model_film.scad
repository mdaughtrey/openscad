ViewScale = [0.0254, 0.0254, 0.0254];
include </../BOSL2-master/std.scad>


module model_film_super8(anchor=CENTER,spin=0,orient=UP,frames=1)
{
    m2m = function(mm) mm/25.4*1000.0;
    module model_film_super8_()
    {
        diff()
        cuboid([m2m(7.9),m2m(4.23),10])
        tag("remove")
        {
            right(m2m(7.9-7.21)) attach(LEFT,norot=1)
                cuboid([m2m(5.46),m2m(4.01),11],edges="Z",rounding=m2m(0.5),anchor=LEFT);
            left(m2m(0.5)) attach(RIGHT,norot=1)
                cuboid([m2m(0.91),m2m(0.91),11],anchor=RIGHT);
            }
    }
    attachable(anchor,spin,orient,size=[m2m(7.9),m2m(4.23)*frames,10])
    {
        ycopies(spacing=m2m(4.23),n=frames)
        model_film_super8_();
        children();
    }
}

module model_film_8mm(anchor=CENTER,spin=0,orient=UP,frames=1)
{
    m2m = function(mm) mm/25.4*1000.0;
    module model_film_8mm_()
    {
        diff()
        cuboid([m2m(7.9),m2m(3.81),10])
        tag("remove")
        {
            right(m2m(0.45)) attach(LEFT,norot=1)
                cuboid([m2m(4.5),m2m(3.3),11],edges="Z",rounding=m2m(0.5),anchor=LEFT);

            left(m2m(0.91)) attach(RIGHT+BACK,norot=1)
                cuboid([m2m(1.8),m2m(1.23),11],anchor=RIGHT);
            left(m2m(0.91)) attach(RIGHT+FRONT,norot=1)
                cuboid([m2m(1.8),m2m(1.23),11],anchor=RIGHT);

            }
    }
    attachable(anchor,spin,orient,size=[m2m(7.9),m2m(3.81)*frames,10])
    {
        ycopies(spacing=m2m(3.81),n=frames)
        model_film_8mm_();
        children();
    }
}

//module forViewing()
//{
//    //model_film_super8(frames=5);
//    model_film_8mm(frames=5);
//}
//
//module forPrinting()
//{
//}
//
//scale(ViewScale)
//{
//    forViewing();
//}
