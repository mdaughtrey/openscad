ViewScale = [0.0254, 0.0254, 0.0254];

module tool()
{
    // linext 120
    // hole 200

    linear_extrude(50)
    difference() {
        union() {
            circle(600/2, $fn=6);
            translate([0, 1200, 0])
            square([300, 2000], center=true);
        }
        circle(410/2, $fn=6);
    }

    translate([0, 0, 49])
    linear_extrude(30)
    difference() {
        circle(600/2, $fn=6);
        circle(200/2, $fn=96);
    }

}

module forViewing()
{
    tool();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
