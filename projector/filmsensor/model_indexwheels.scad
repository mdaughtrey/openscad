ViewScale = [0.0254, 0.0254, 0.0254];

module model_indexwheels()
{
    color("silver")
    {
        // super8
        linear_extrude(350)
        circle(717/2, $fn=96);
        translate([0, 0, 70])
        linear_extrude(20)
        for (ii = [0:51.4:360])
        {
            rotate([0, 0, ii])
            square([750, 35], center = true);
        }
        translate([0, 0, 349])
        linear_extrude(21)
        circle(750/2, $fn=96);

        // 8mm
        translate([0, 0, 369])
        linear_extrude(350)
        circle(638/2, $fn=96);
        translate([0, 0, 369+65])
        linear_extrude(20)
        for (ii = [51.4/2:51.4:360])
        {
            rotate([0, 0, ii])
            square([720, 35], center = true);
        }
        // shaft
        linear_extrude(3880-800-300)
        //linear_extrude(2500)
        circle(150/2, $fn=96);
    }

}

//module forViewing()
//{
//    model_indexwheels();
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
