ViewScale = [0.0254, 0.0254, 0.0254];

module ring0()
{
    difference() {
        circle(1390/2, $fn=96);
        circle(1290/2, $fn=96);
    }
}

module ring()
{
    rotate_extrude(angle=360, $fn=96)
    translate([1190/2, 0, 0])
    polygon([[0,0], [0,100], [100,150], [100,0]]);
}

module forViewing()
{
//    translate([0, 0, -50])
 //   ring0();
    color("green")
    ring();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}