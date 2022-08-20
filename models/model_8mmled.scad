module model_8mmled()
{
    // Legs
    linear_extrude(651)
    translate([50/2, 0, 0])
    square([20, 20], center=true);

    for (ii=[50*1.5, -50/2]) {
        translate([ii, 0, 75])
        linear_extrude(576)
        square([20, 20], center=true);
    }
    translate([-50*1.5, 0, 80])
    linear_extrude(576)
    square([20, 20], center=true);

    // Lip
    translate([0, 0, 650])
    linear_extrude(75)
    difference() {
        circle(362/2, $fn=48);
        translate([362/2-20, -262/2, 0])
        square([40, 262]);
    }
    // Body
    translate([0, 0, 724])
    linear_extrude(251)
    circle(310/2, $fn=48);
    // Lens
    translate([0, 0, 974])
    sphere(d = 310, $fn=48);


}

