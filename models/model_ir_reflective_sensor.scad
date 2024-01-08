ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>


module model_ir_reflective_sensor(anchor=CENTER,spin=0,orient=UP)
{
    module model_ir_reflective_sensor_()
    {
        diff()
        cuboid([700,200,150]) {
            attach(TOP,norot=1) prismoid(size1=[700,200],size2=[380,200],h=450,anchor=BOT)
            tag("remove")
            {
                attach(TOP) left(25) cyl(d=50,h=200,anchor=TOP);
                attach(TOP) right(25) cyl(d=50,h=200,anchor=TOP);
            }
            tag("remove") 
            {
                up(150-100) attach(FRONT) cyl(r=62,h=200,anchor=TOP)
                    attach(BACK) cuboid([124,200,125])
                        attach(BACK) cyl(r=62,h=200,anchor=TOP+FRONT);
            }
        }
    }
    attachable(anchor=anchor,spin=spin,orient=orient,size=[700,200,590])
    {
        down((600-75)/2)
        model_ir_reflective_sensor_();
        children();
    }
}

//module forViewing()
//{
//    model_ir_reflective_sensor();
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
