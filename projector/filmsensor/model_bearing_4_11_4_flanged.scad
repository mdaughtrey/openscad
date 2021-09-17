include <../../libraries/myutils.scad>

ViewScale = [0.0254, 0.0254, 0.0254];


module model_bearing_4_11_4_flanged()
{
    // Flange
    zerh(0, 37, 492/2, 157/2);
    zerh(36, 121, 433/2, 157/2);
}

//module forViewing()
//{
//    model_bearing_4_11_4_flanged();
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
