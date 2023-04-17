ViewScale = [0.0254, 0.0254, 0.0254];
$fn=96;

module wagoX(n)
{
    w=235;
    module wago1()
    {
        linear_extrude(23)
        square([235, 710]);

        translate([0, 0, 22])
        linear_extrude(184)
        square([47, 710]);

        translate([0, 0, 184])
        linear_extrude(132)
        square([235, 710]);
    }
    n = n -1;
    for (ii=[0:w:w*n]) {
        translate([ii, 0, 0])
        wago1();
    }
    translate([w*(n+1), 0, 0])
    linear_extrude(316)
    square([47,710]);
}

module wagobox()
{
    // Base
    linear_extrude(100)
    difference() {
    hull() {
        square([4278, 910]);
        translate([-500, 910/2, 0])
        circle(910/2);
        translate([4278, 910/2, 0])
        circle(910/2);
    }

    translate([-500, 910/2, 0])
    circle(200/2);
    translate([4278, 910/2, 0])
    circle(200/2);
    }

    translate([0, 0, 99]) {
        // Left
        linear_extrude(436)
        square([100, 910]);
        // Right
        translate([3622, 0, 0])
        linear_extrude(436)
        square([100, 910]);

        // Front rise
        translate([0, 0, 0])
        linear_extrude(30)
        square([3722, 90]);
        // Rear rise
        translate([0, 910-80, 0])
        linear_extrude(336)
        square([3722, 90]);
        // Top
        translate([0, 910-230, 336])
        linear_extrude(100)
        square([3722, 240]);
    }

}
    
module forViewing()
{
    translate([0, 0, 100])
    // Gnd
    color("cornflowerblue") {
    wagoX(5);
    // 12v
    translate([1250, 0, 0])
    wagoX(3);
    // 5v
    translate([2030, 0, 0])
    wagoX(3);
    // WS2812 data
    translate([2820, 0, 0])
    wagoX(3);
    }
    translate([-100, -100, 0])
    wagobox();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
