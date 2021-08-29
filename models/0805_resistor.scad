module model_0805_resistor()
{
    // End caps
    color("lightgray")
    {
        linear_extrude(20)
        {
            translate([40+21/2, 0, 0])
            square([21, 60], center=true);
            translate([-40-21/2, 0, 0])
            square([21, 60], center=true);
        }
    }
    // Body
    color("black")
    linear_extrude(20)
    square([80, 60], center=true);
}

