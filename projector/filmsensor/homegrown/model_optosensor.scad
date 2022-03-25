//ViewScale = [0.0254, 0.0254, 0.0254];

module model_optosensor()
{
    // body
    linear_extrude(235)
    difference(){
        square([552,391], center=true);
        translate([0, 46, 0])
        square([200,300], center=true);
    }
    // legs
    translate([0, -200-391/2, 0])
    for(ii = [-310/2+15/2,310/2-15/2])
    {
        for(jj = [135/2+20/2, 135/2+100-20])
        {
            translate([ii, 0, jj])
            linear_extrude(20)
            square([15, 400], center=true);
        }
    }
}

//module forViewing()
//{
//    model_optosensor();
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
