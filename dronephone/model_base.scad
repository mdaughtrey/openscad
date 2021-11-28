ViewScale = [0.0254, 0.0254, 0.0254];

//module case()
//{
//}
//
module model_base()
{
    linear_extrude(60)
    difference()
    {
        square([1155, 433], center=true);
        translate([753/2, 0, 0])
        circle(130/2, $fn=96);
        translate([-753/2, 0, 0])
        circle(130/2, $fn=96);
    }
}

//module forPrinting()
//{
//}
//
//scale(ViewScale)
//{
//    forViewing();
//}
