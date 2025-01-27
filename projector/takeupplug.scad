ViewScale = [0.0254, 0.0254, 0.0254];

module plug()
{
    linear_extrude(400)
    circle(580/2, $fn=96);
    translate([0, 0, 398])
    linear_extrude(600)
    difference() {
        circle(380/2, $fn=96);
        circle(280/2, $fn=96);
        translate([150, 0, 0])
        square([100, 20], center=true);
    }
}

module forViewing()
{
}

module forPrinting()
{
    plug();
}

scale(ViewScale)
{
    forPrinting();
}
