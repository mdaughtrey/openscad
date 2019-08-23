ViewScale = [0.0254, 0.0254, 0.0254];

module barrel()
{
    difference() {
        circle(1330/2, $fn=96);
        circle(1230/2, $fn=96);
    }
}

module mask()
{
    difference() {
        circle(1330/2, $fn=96);
        square(300, center=true);
    }
}

module maskmount()
{
    difference() {
        square(700, center=true);
        square(650, center=true);
    }
}

scale(ViewScale)
{
    linear_extrude(30)
    mask();
    translate([0, 0, 29])
    linear_extrude(100)
    barrel();
    translate([0, 0, 29])
    linear_extrude(100)
    maskmount();
}
