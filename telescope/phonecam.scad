ViewScale = [0.0254, 0.0254, 0.0254];

module model_phone()
{
//    linear_extrude(410)
//    square([2910, 6080], center=true);

    *linear_extrude(6080)
    square([2910, 410], center=true);

    // Long sides
    for (ii=[-1,1]) {
        translate([ii*2470/2, 0, (6080-5250)/2-(450/2)])
        linear_extrude(5250+450)
        circle(450/2, $fn=96);
    }

    // Short sides
    translate([-450/2, 0, 450/2])
    rotate([0, 90, 0])
    translate([0, 0, -2070/2])
    linear_extrude(2070+450)
    circle(450/2, $fn=96);

    translate([-450/2, 0, 6080-450/2])
    rotate([0, 90, 0])
    translate([0, 0, -2070/2])
    linear_extrude(2070+450)
    circle(450/2, $fn=96);

    // Lens
    translate([-2910/2+433+200, -400/2, 6080-450-200])
    rotate([90, 0, 0])
    translate([0, 0, -15])
    linear_extrude(30)
    circle(400/2, $fn=96);

    // Corner spheres
    translate([-2910/2+450/2, 0, 450/2])
    sphere(450/2, $fn=96);

    translate([2910/2-450/2, 0, 450/2])
    sphere(450/2, $fn=96);

    translate([-2910/2+450/2, 0, 6080-450/2])
    sphere(450/2, $fn=96);

    translate([2910/2-450/2, 0, 6080-450/2])
    sphere(450/2, $fn=96);


}

module telescopemount()
{
    linear_extrude(50)
    difference()
    {
        circle(1750/2, $fn=96);
        circle(1265/2, $fn=96);
    }
    translate([0, 0, 49])
    linear_extrude(181)
    difference()
    {
        circle(1750/2, $fn=96);
        circle(1350/2, $fn=96);
    }
    translate([0, 0, 229])
    linear_extrude(281)
    difference()
    {
        circle(1750/2, $fn=96);
        circle(1610/2, $fn=96);
    }

    linear_extrude(550)
    difference() {
        square([1850, 1850], center=true);
        square([1650, 1650], center=true);
    }

}

module shortphoneclip(taillen)
{
    linear_extrude(1000) {
        intersection() {
            translate([0, 175, 0])
            square([701, 351], center=true);
            difference()
            {
                circle(350, $fn=96);
                circle(250, $fn=96);
            }
        }

        translate([250, -taillen, 0])
        square([100, taillen+1]);

        *translate([-400, 200, 0])
        square([400, 100]);
    }

}

module phonemount()
{
    linear_extrude(400)
    difference() {
        square([1970, 1970], center=true);
        square([1770, 1770], center=true);
    }

    //translate([2910/2+(450/2)+433-(250/2), 6080/2-450-200, 750])
    translate([2910/2+(450/2)+433-(250/2), 700, 750])
    rotate([0, 90, -90])
    translate([0, 0, -250])
    shortphoneclip(1000);
}

module forViewing()
{
    *telescopemount();
//    translate([0, 0, 100])
    phonemount();
    color("cyan")
    translate([2910/2-(450/2)-433, 6080/2-450-200, 750])
    rotate([90, 0, 0])
    translate([0, 0, -6080/2])
    model_phone();
    //shortphoneclip();
}

module forPrinting()
{
    telescopemount();
    translate([0, 200, 0])
    shortphoneclip();
}

scale(ViewScale)
{
    forViewing();
    //forPrinting();
}
