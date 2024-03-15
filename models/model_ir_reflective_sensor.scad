include <../BOSL2-master/std.scad>


module model_ir_reflective_sensor(anchor=CENTER,spin=0,orient=UP,cutoutpad=0)
{
    module model_ir_reflective_sensor_()
    {
        diff()
        cuboid([700+cutoutpad*2,200+cutoutpad*2,150+cutoutpad]) {
            attach(TOP,norot=1) prismoid(size1=[700+cutoutpad*2,200+cutoutpad*2],size2=[380+cutoutpad*2,200+cutoutpad*2],h=450+cutoutpad,anchor=BOT)
            if (cutoutpad==0)
            tag("remove")
            {
                attach(TOP) left(25) cyl(d=50,h=200,anchor=TOP);
                attach(TOP) right(25) cyl(d=50,h=200,anchor=TOP);
            }
            if (cutoutpad==0)
            tag("remove") 
            {
                up(150-100) attach(FRONT) cyl(r=62,h=200,anchor=TOP)
                    attach(BACK) cuboid([124,200,125])
                        attach(BACK) cyl(r=62,h=200,anchor=TOP+FRONT);
            }
        }
    }
    attachable(anchor=anchor,spin=spin,orient=orient,size=[700+cutoutpad*2,200+cutoutpad*2,600+cutoutpad*2])
    {
        down((600-75)/2+10-50)
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
