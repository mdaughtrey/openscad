module model_ws2812strip(numleds = 1)
{
    for (ii = [0:1:numleds-1]) {
        echo(ii);
        translate([ii * 400, 0, 0]) {
        // Substrate
        if (modelcolor) color("white")
        linear_extrude(20)
        square([400, 473]);

        // LED
        if (modelcolor) color("beige")
        translate([100, 100, 19])
        linear_extrude(51)
        square([200, 200]);

        // Resistor
        if (modelcolor) color("tan")
        translate([150, 350, 19])
        linear_extrude(50)
        square([100, 30]);
        }

        if (modelcolor) {
            // Contacts
            color("gold")
            translate([0, 0, 20])
            linear_extrude(1) {
                for (ii=[120,240,360]) {
                    translate([360, ii, 0])
                    hull() {
                        circle(80/2);
                        translate([0, -40, 0])
                        square([40, 80]);
                    }
                }
                for (ii=[120,240,360]) {
                    translate([40, ii, 0])
                    rotate([0, 0, 180])
                    hull() {
                        circle(80/2);
                        translate([0, -40, 0])
                        square([40, 80]);
                    }
                }
            }

            // Outline
            color("black")
            translate([0, 0, 20])
            linear_extrude(1) 
            difference() {
                square([400, 473]);
                translate([5, 5, 0])
                square([390, 463]);
            }
        }
    }
}
