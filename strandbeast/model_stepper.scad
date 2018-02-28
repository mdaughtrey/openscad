ViewScale = [0.0254, 0.0254, 0.0254];

module motorTab() {
        difference()
        {
            union() {
                circle(277/2, $fn=96);
                translate([-250, 0, 0])
                square([500, 277], center=true);
            }
            circle(166/2, $fn=96);
        }
}

module shaft() {
    linear_extrude(83)
    circle(363/2, center=true);

    translate([0, 0, 83])
    linear_extrude(300)
    circle(194/2, center=true);
}

module body()
{
    linear_extrude(710)
    {
        circle(1100/2, $fn=96);
        translate([0, -500, 0])
        square([680, 400], center=true);
    }

    translate([1100/2+277/2, 0, 710-32])
    linear_extrude(32)
    motorTab();

    translate([-(1100+277)/2, 0, 710-32])
    linear_extrude(32)
    rotate([0, 0, 180])
    motorTab();
}

scale(ViewScale)
{
    body();
    translate([0, (1100-363-63)/2, 710])
    shaft();
}

