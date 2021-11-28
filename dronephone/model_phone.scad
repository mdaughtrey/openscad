ViewScale = [0.0254, 0.0254, 0.0254];

//module case()
//{
//}
//
module model_phone()
{
    linear_extrude(290)
    square([5450, 2650], center=true);
    translate([0, 0, 289])
    linear_extrude(250)
    circle(1500/2, $fn=96);
}

//module forPrinting()
//{
//}
//
//scale(ViewScale)
//{
//    forViewing();
//}
