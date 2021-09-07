module model_slideswitch()
{
    color("darkslategray")
    linear_extrude(145)
    square([505, 139], center = true);

    // Pins
    color("silver")
    for (ii = [-155, -80,80, 155])
    {
        for (jj = [0, 120])
        {
            translate([ii, -130, jj])
            linear_extrude(12)
            square([25, 130], center = true);
        }
    }

    color("dimgray")
    translate([0, 139/2-40, 144])
    linear_extrude(80)
    square([225, 60], center = true);
}

