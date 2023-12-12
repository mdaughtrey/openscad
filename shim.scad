ViewScale = [0.0254, 0.0254, 0.0254];

module case()
{
    linear_extrude(200)
    difference() {
        square([350, 350], center=true);
        square([180, 180], center=true);
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
