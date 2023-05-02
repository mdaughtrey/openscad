module model_small_heatsink()
{
    linear_extrude(75)
    square([570, 570], center=true);
    translate([0, 0, 74])
    linear_extrude(151) {
        for (ii=[0:90:540]) {
            translate([ii-570/2+15, 0, 0])
            square([30, 570], center=true);
        }
    }

}
    
