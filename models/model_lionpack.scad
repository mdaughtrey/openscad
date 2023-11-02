//ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>

lionpack_120mah_width=760;
lionpack_120mah_length=700;

module model_lionpack_120mah()
{
    recolor("silver")
    cuboid([lionpack_120mah_length,lionpack_120mah_width,200]);
}

//module forViewing()
//{
//    model_lionpack_120mah();
//}
//
//scale(ViewScale)
//{
//   forViewing();
//}
