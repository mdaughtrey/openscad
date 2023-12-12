module model_slideswitch0()
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

module model_slideswitch(anchor=CENTER,spin=0,orient=UP)
{
    module model_slideswitch_() {
        color("darkslategray")
        linear_extrude(123)
        square([355, 137], center = true);

        color("dimgray")
        translate([0, 0, 122])
        linear_extrude(11)
        difference()
        {
            square([355, 137], center = true);
            square([150, 65], center = true);
        }

        // switch
        color("black")
        translate([0, 0, 122])
        linear_extrude(100)
        square([58, 58], center = true);

        // Pins
        color("silver")
        for (ii = [-100, 0, 100])
        {
            for (jj = [-137/2, 137/2])
            {
                translate([ii, jj, -80])
                linear_extrude(100)
                square([25, 25], center = true);
            }
        }
    }
    attachable(anchor,spin,orient,size=[355,137,223])
    {
        model_slideswitch_();
        children();
    }

}

