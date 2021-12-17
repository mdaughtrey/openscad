ViewScale = [0.0254, 0.0254, 0.0254];

module case()
{
    linear_extrude(100)
    difference()
    {
        circle(465/2, $fn=96);
        circle(175/2, $fn=96);
    }

    translate([0, 0, 99])
    linear_extrude(200)
    difference()
    {
        circle(465/2, $fn=96);
        circle(365/2, $fn=96);
    }
}

module forViewing()
{
    case();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
