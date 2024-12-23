ViewScale = [0.0254, 0.0254, 0.0254];

//2730
//4480
//
//
//420x953
//
//
//2520
//2200


module cover()
{
    coverx=2730; // Original cover width
    // Side is 1100 from the right of the switch cutout
    cutin=(coverx/2)-420/2-1100;
    echo("cutin is ",cutin);
    linear_extrude(50)
    difference() {
        translate([-cutin/2, 0, 0])
        square([coverx-cutin, 4480], center=true);
        //translate([-2730/2+cutin/2, 0, 0])
        //square([cutin, 4480], center=true);
        // Switch cutout
        square([420, 953], center=true);
        // Hole
        translate([0, 1260, 0])
        circle(160/2, $fn=96);
        // Hole
        translate([0, -1260, 0])
        circle(160/2, $fn=96);
    }
    translate([0, 0, 49]) {
        linear_extrude(131)
        difference() {
            translate([-cutin/2, 0, 0])
            square([2730-cutin, 4480], center=true);
            square([2530-cutin, 4280], center=true);
            *translate([2730/2+300-((2730/2)-1100), 0, 0])
            square([600, 4490], center=true);
        }
        linear_extrude(50) {
            for (ii=[1260,-1260]) {
                translate([0, ii, 0])
                difference() {
                    circle(360/2, $fn=96);
                    circle(160/2, $fn=96);
                }
            }
            difference() {
                square([620, 1153], center=true);
                square([420, 953], center=true);
            }
        }
    }
}

module forViewing()
{
    cover();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
