module model_steppergear()
{
    // Lower body
    template0 = [[200, 0], [1450, 0], [1650, 200],       // bottom
        [1650, 1450], [1450, 1650],                     // right
        [200, 1650], [0, 1450],                         // top
        [0, 200], [200, 0]];                             // bottom
        linear_extrude(1850)
    polygon(points=template0);

    // Gearbox mount
    template1 = [[140, 0], [1435, 0], [1575, 140],       // bottom
        [1575, 1435], [1435, 1575],                     // right
        [140, 1575], [0, 1435],                         // top
        [0, 140], [140, 0]];                             // bottom
    translate([75/2, 75/2, 1840])
    linear_extrude(210)
    polygon(points=template1);

    // Gearbox
    translate([1650/2, 1650/2, 2040])
    linear_extrude(1240)
    circle(1410/2, $fn=96);

    // Unit mount
    translate([1650/2, 1650/2, 3270])
    linear_extrude(290)
    difference()
    {
        circle(1410/2, $fn=96);
        for(ii=[0:90:360])
        {
            rotate([0, 0, ii])
            translate([1114/2, 0, 0])
             circle(120/2, $fn=96);
        }
    }

    // Shaft collar
    translate([1650/2, 1650/2, 3560])
    linear_extrude(85)
    circle(865/2, $fn=96);

    // Shaft
    translate([1650/2, 1650/2, 3635])
    linear_extrude(690)
    circle(310/2, $fn=96);
}
