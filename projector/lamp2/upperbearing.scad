ViewScale = [0.0254, 0.0254, 0.0254];

armlength=1200;
legwidth=600;

module leg(tx)
{
    // big circle short leg
    translate([tx, 0, 0])
    difference() {
        circle(500, $fn=96);
        circle(175/2, $fn=96);
    }

    // short leg
    difference() {
        hull() {
            circle(legwidth/2, $fn=96);
            translate([tx, 0, 0])
            circle(legwidth/2, $fn=96);
        }
        translate([tx, 0, 0])
        circle(175/2, $fn=96);
    }
}

module main()
{
    leg(550);
    rotate([0, 0, 135])
    leg(armlength);
    //leg(armlength-550);
}

module bush()
{
    linear_extrude(50)
    difference() {
        circle(450/2, $fn=96);
        circle(190/2, $fn=96);
    }
    translate([0, 0, 50])
    linear_extrude(285)
    difference() {
        circle(300/2, $fn=96);
        circle(190/2, $fn=96);
    }
}

scale(ViewScale)
{
    linear_extrude(100)
    main();
    translate([550, 0, 100])
    bush();
    rotate([0, 0,135])
    //translate([armlength-550, 0, 100])
    translate([armlength, 0, 100])
    bush();
}
