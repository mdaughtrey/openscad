ViewScale = [0.0254, 0.0254, 0.0254];
include </../BOSL2-master/std.scad>
include <../models/model_ssd1306.scad>
include <../models/pushbutton.scad>

//module modname(anchor=CENTER,spin=0,orient=UP)
//{
//    module modname_()
//    {
//    }
//    attachable(anchor,spin,orient,size=)
//    {
//        modname_();
//        children();
//    }
//}


module case()
{
}

module forViewing()
{
    *yrot(180)
    model_pushbutton_flat();
    //up(100)
    model_ssd1306_128_32();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
