ViewScale = [0.0254, 0.0254, 0.0254];

module model_tube()
{
    linear_extrude(1000)
    difference()
    {
        circle(313/2, $fn=96);
        circle(212/2, $fn=96);
    }
}

module case()
{
    linear_extrude(100)
    difference()
    {
        circle(465/2, $fn=96);
        circle(175/2, $fn=96);
    }

    translate([0, 0, 99])
    linear_extrude(100)
    difference()
    {
        circle(465/2, $fn=96);
        circle(313/2+10, $fn=96);
    }

    *translate([0, 0, 99])
    linear_extrude(200)
    difference()
    {
        circle(212/2-10, $fn=96);
        circle(175/2, $fn=96);
    }
}

module forViewing()
{
//    color("cornflowerblue")
//    model_tube();
    case();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
