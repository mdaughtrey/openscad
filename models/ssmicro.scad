ViewScale = [0.0254, 0.0254, 0.0254];

module ssmicro()
{
    color("Cyan")
    linear_extrude(35)
    square([300, 300], center=true);

    translate([0, 0, 35])
    {
        linear_extrude(81)
        {
            square([802,770], center=true);
            translate([0, -(770/2)-(435/2)+1, 0])
            square([480,435], center=true);
        }
    }

    color("Cyan")
    translate([0, 0, 35+81])
    linear_extrude(62)
    square([600, 600], center=true);
}

scale(ViewScale)
{
    ssmicro();
}
