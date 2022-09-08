module model_pushbutton_6_6_6pt5()
{
    // Legs
    if (modelcolor) color("silver")
    linear_extrude(175)
    for(ii=[0,300]) {
        for(jj=[10,199]) {
            translate([jj, ii, 0])
            square([26,10]);
        }
    }

    // Body main
    if (modelcolor) color("black")
    translate([0, (300-235)/2, 120])
    linear_extrude(120)
    square([235, 235]);

    // Body top
    if (modelcolor) color("silver")
    translate([0, (300-235)/2, 239])
    linear_extrude(11)
    square([235, 235]);

    // Shaft
    if (modelcolor) color("black")
    translate([235/2, 235/2+(300-235)/2, 249])
    linear_extrude(120)
    circle(135/2);
}

module model_pushbutton_top()
{
    if (modelcolor) color("red")
    linear_extrude(255)
    circle(228/2);
}
