include <model_indexwheels.scad>
include <model_bolt_832_1in.scad>

module iwholder()
{
//    linear_extrude(350)
//    circle(727/2, $fn=96);
    outerd = 862;

    translate([0, 0, -1000])
    linear_extrude(1010)
    difference()
    {
        circle(400/2, $fn=6);
        circle(170/2, $fn=96);
    }

    linear_extrude(101)
    difference()
    {
        circle(outerd/2, $fn=96);
        circle(170/2, $fn=96);
    }

    translate([0, 0, 100])
    linear_extrude(181)
    difference()
    {
        circle(outerd/2, $fn=96);
        circle(577/2, $fn=96);
    }
    

    *translate([0, 0, 280])
    linear_extrude(51)
    difference()
    {
        circle(outerd/2, $fn=96);
        circle(727/2, $fn=96);
    }
    translate([0, 0, 280])
    linear_extrude(280+51)
    difference()
    {
        difference()
        {
            circle(outerd/2, $fn=96);
            circle(727/2, $fn=96);
        }
        for (ii = [0:51.4:360])
        {
            rotate([0, 0, ii])
            square([800, 55], center = true);
        }
    }
// --
//    translate([0, 0, 349])
//    linear_extrude(21)
//    circle(750/2, $fn=96);
}

module forViewing()
{
//    translate([0, 0, 5])
//    model_indexwheels();
//    translate([0, 0, 50])
    color("dimgray")
    translate([0, 0, 261])
    rotate([180, 0, 0])
    model_bolt_832_1in();
    iwholder();

}

module forPrinting()
{
    iwholder();
}

scale(ViewScale)
{
    //forViewing();
    forPrinting();
}
