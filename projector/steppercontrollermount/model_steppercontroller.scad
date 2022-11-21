ViewScale = [0.0254, 0.0254, 0.0254];

pcbw = 1700;
pcbh = 1700;

module model_steppercontroller()
{

    linear_extrude(65)
    difference() 
    {
        square([pcbw, pcbh]);
        // mounting holes
        translate([66+75, pcbh-66-75, 0])
        circle(150/2, $fn=96);
        translate([pcbw-66-75, pcbh-66-75, 0])
        circle(150/2, $fn=96);
    }

    // heatsink
    hsw = 927;
    hsh = 627;
    translate([pcbw/2-hsw/2, pcbh-hsh, 65])
    linear_extrude(1000)
    square([hsw, hsh]);

    // left terminal block
    tb0w = 300;
    tb0h = 410;
    translate([0, 438, 65])
    linear_extrude(390)
    square([tb0w, tb0h]);

    // right terminal block
    translate([pcbw-tb0w, 438, 65])
    linear_extrude(390)
    square([tb0w, tb0h]);

    // bottom terminal block
    tb1w = 1000;
    tb1h = 300;
    translate([pcbw/2-tb1w/2, 0, 65])
    linear_extrude(390)
    square([tb1w, tb1h]);

}


//scale(ViewScale)
//{
//    color("lightblue")
//    model_steppercontroller();
//}
