ViewScale = [0.0254, 0.0254, 0.0254];

module endcap()
{
    boxW = 1330;
    boxH = 623;
    pad = 15;

    linear_extrude(70)
    square([boxW + 70 + pad, boxH + 70 + pad], center=true);

    translate([0, 0, 69])
    linear_extrude(200)
    difference()
    {
        square([boxW + 70 + pad, boxH + 70 + pad], center=true);
        square([boxW + pad, boxH + pad], center=true);
    }
}

module forViewing()
{
    case();
}

module forPrinting()
{
    endcap();
}

scale(ViewScale)
{
    forPrinting();
}
