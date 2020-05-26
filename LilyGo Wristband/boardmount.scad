ViewScale = [0.0254, 0.0254, 0.0254];

// Programming Board 803x 1340
// Watch Board 1520 526

progboardW = 1340;
progboardH = 803;
watchboardW = 526;
watchboardH = 1520;

module model_progboard()
{
    // Main board
    color("cyan")
    linear_extrude(50)
    square([progboardW, progboardH], center=true);

    // Buttons and ribbon connector
    color("cornflowerblue")
    translate([progboardW/2-158/2-40, 0, 49])
    linear_extrude(80)
    square([158, 500], center=true);

    // USB-C connector
    color("cornflowerblue")
    translate([-progboardW/2+354/2-50, -progboardH/2+300/2+40, 49])
    linear_extrude(125)
    square([354, 300], center=true);

    // Mini-USB connector
    color("cornflowerblue")
    translate([-progboardW/2+220/2-50, progboardH/2-320/2-50, 49])
    linear_extrude(94)
    square([220, 320], center=true);
}

module model_watchboard()
{
    color("cyan")
    linear_extrude(230)
    square([watchboardW, watchboardH], center=true);
}

module watchboard()
{
    //rotate([0, -45, 0])
    //translate([500, 0, 0]) {
        *translate([0, 0, 50])
        model_watchboard();

        // base
        linear_extrude(50)
        difference() {
            square([watchboardW+100, watchboardH+100], center=true);
            square([watchboardW-200, watchboardH-400], center=true);
        }

        // walls
        translate([0, 0, 49])
        linear_extrude(300)
        difference() {
            square([watchboardW+100, watchboardH+100], center=true);
            square([watchboardW+20, watchboardH+20], center=true);
            translate([300, 0, 0])
            square([100, 200], center=true);
        }
   // }
}

module progboard()
{
    translate([-1000, 0, 0])
    {
        *translate([0, 0, 50])
        model_progboard();
        // Bottom
        linear_extrude(50)
        difference() {
            square([progboardW + 100, progboardH + 100], center=true);
            square([progboardW - 50, progboardH - 50], center=true);
        }
        // Sides
        translate([0, 0, 49])
        linear_extrude(71)
        difference() {
            square([progboardW + 100, progboardH + 100], center=true);
            translate([-50, 0, 0])
            square([progboardW + 120, progboardH + 20], center=true);
        }

        // Slot top
        translate([300, 0, 119])
        linear_extrude(40)
        difference() {
            square([progboardW - 500, progboardH + 100], center=true);
            translate([-25, 0, 0])
            square([progboardW - 450, progboardH - 100], center=true);
        }
    }
}

module support()
{
    linear_extrude(50)
    difference() {
        square([300, 1000], center=true);
        translate([-150, 300, 0])
        rotate([0, 0, 45])
        square([200, 200], center=true);
    }

}

module supports()
{
    translate([200, progboardH/2+50, 150])
    rotate([90, 0, 0])
    rotate([0, 0, -90])
    support();

    translate([200, -progboardH/2, 150])
    rotate([90, 0, 0])
    rotate([0, 0, -90])
    support();
}

module forDesign()
{
    progboard();
    translate([0, 0, 0])
    watchboard();
    supports();
}

module forPrinting()
{
//    progboard();
//    translate([0, 0, 0])
    watchboard();
//    supports();
}

scale(ViewScale)
{
    //forDesign();
    forPrinting();
}

