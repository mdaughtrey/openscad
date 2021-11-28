ViewScale = [0.0254, 0.0254, 0.0254];

//module case()
//{
//}
//
module model_phone()
{
    linear_extrude(430)
    square([5580, 2850], center=true);
    translate([-5580/2+3400, 0, 289])
    linear_extrude(429)
    circle(1600/2, $fn=96);
}

//module forPrinting()
//{
//}
//
//scale(ViewScale)
//{
//    forViewing();
//}
