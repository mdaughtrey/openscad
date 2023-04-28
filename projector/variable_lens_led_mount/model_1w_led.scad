module model_1w_led()
{
    // Base
    linear_extrude(50)
    difference() {
        circle(820/2, $fn=6);
        for (ii=[0:60:360])
        {
            rotate([0, 0, ii])
            translate([760/2, 0, 0])
            circle(160/2, $fn=8);
        }
    }

    // LED Body
    translate([0, 0, 49])
    linear_extrude(101)
    circle(310/2, $fn=96);

    // Lens
    translate([0, 0, 149])
    linear_extrude(60)
    circle(160/2, $fn=96);
}

