ViewScale = [0.0254, 0.0254, 0.0254];

module washer()
{
    linear_extrude(100)
    difference() {
        circle(890/2);
        circle(560/2);
    }
}

module forViewing()
{
    case();
}

module forPrinting()
{
    washer();
}

scale(ViewScale)
{
    //forViewing();
    forPrinting();
}
