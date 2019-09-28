ViewScale = [0.0254, 0.0254, 0.0254];

module hbridge()
{
    linear_extrude(63)
    difference()
    {
        square([1167,918], center=true);
        translate([-1167/2+320+330, 0, 0])
        {
            translate([-260, 350, 0])
            circle(60, $fn=96);
            translate([-260, -350, 0])
            circle(60, $fn=96);
            translate([260, 350, 0])
            circle(60, $fn=96);
            translate([260, -350, 0])
            circle(60, $fn=96);
        }
    }
    // Terminal
    color("Cyan")
    translate([-1167/2+150, 0, 62])
    linear_extrude(410)
    square([300,840], center=true);

    // I/O
    color("Cyan")
    translate([1167/2-90, 0, 62])
    linear_extrude(410)
    square([100,605], center=true);

    // Chip
    color("Cyan")
    translate([1167/2-510, 918/2-198/2-22, 62])
    linear_extrude(60)
    square([275,198], center=true);

    // Chip
    color("Cyan")
    translate([1167/2-510, -(918/2-198/2-22), 62])
    linear_extrude(60)
    square([275,198], center=true);
}

scale(ViewScale)
{
    hbridge();
}
