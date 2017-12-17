include <defs.scad>

module lower()
{
    linear_extrude(200)
    circle(ShaftR, $fn=96);

    translate([0, 0, 180])
    linear_extrude(200)
    circle(ShaftR*2/3-10, $fn=6);
}

module upper()
{
    linear_extrude(200)
    circle(ShaftR, $fn=96);

    translate([0, 0, 200])
    linear_extrude(200)
    difference() {
        circle(ShaftR, $fn=96);
        circle(ShaftR*2/3+10, $fn=6);
    }
}

scale(ViewScale)
{
    lower();
    translate([500, 0, 0])
    upper();
}

