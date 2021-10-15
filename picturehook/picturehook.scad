ViewScale = [0.0254, 0.0254, 0.0254];

module case()
{
}

module forViewing()
{
    w = 500;
    h = 2000;

    linear_extrude(100)
    hull()
    {
        translate([-w/2, h/2, 0])
        circle(100, $fn=96);
        translate([w/2, h/2, 0])
        circle(100, $fn=96);
        translate([-w/2, -h/2, 0])
        circle(100, $fn=96);
        translate([w/2, -h/2, 0])
        circle(100, $fn=96);
    }

    translate([0, 0, 99])
    linear_extrude(101)
    hull()
    {
        translate([-w/2, h/2-200, 0])
        circle(50, $fn=96);
        translate([w/2, h/2-200, 0])
        circle(50, $fn=96);

        translate([-w/2, h/2-100, 0])
        circle(50, $fn=96);
        translate([w/2, h/2-100, 0])
        circle(50, $fn=96);
    }

    translate([0, 0, 199])
    linear_extrude(101)
    hull()
    {
        translate([-w/2, h/2-200, 0])
        circle(50, $fn=96);
        translate([w/2, h/2-200, 0])
        circle(50, $fn=96);

        translate([-w/2, h/2, 0])
        circle(50, $fn=96);
        translate([w/2, h/2, 0])
        circle(50, $fn=96);
    }


    translate([100, 500, 99])
    rotate([0, -90, 0])
    linear_extrude(200)
    polygon([[0, -250], [0, 250], [200, 250]]);



}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
