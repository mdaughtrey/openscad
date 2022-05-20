ViewScale = [0.0254, 0.0254, 0.0254];

//function bodyRH() = [1520, 1340];

module model_encoder()
{
    // body
    color("black")
    linear_extrude(1250)
    circle(1520/2, $fn=96);

    color("gray")
    translate([0, 0, 1249])
    linear_extrude(91)
    difference()
    {
        circle(1520/2, $fn=96);
        for (ii = [0:120:360])
        {
            rotate([0, 0, ii])
            translate([546, 0, 0])
            circle(120/2, $fn=96);
        }
    }

    color("gray")
    translate([0, 0, 1339])
    linear_extrude(201)
    circle(785/2, $fn=96);

    // Shaft 
    color("lightgray")
    translate([0, 0, 1539])
    linear_extrude(71)
    circle(235/2, $fn=96);

    // Shaft keyed
    color("lightgray")
    translate([0, 0, 1609])
    linear_extrude(400)
    difference() {
        circle(235/2, $fn=96);
        translate([0, -50-235/2+(235-212), 0])
        square([400, 100], center=true);
    }

    // Wire 
    
}

// module forViewing()
// {
//     model_encoder();
// }
// 
// module forPrinting()
// {
// }
// 
// scale(ViewScale)
// {
//     forViewing();
// }
