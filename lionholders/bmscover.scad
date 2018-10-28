ViewScale = [0.0254, 0.0254, 0.0254];

module cutouts()
{
    // top cutouts
    translate([50+300, 2890-100, 0])
    square([150, 100]);

    translate([50+840, 2890-100, 0])
    square([280, 100]);

    translate([50+1700, 2890-100, 0])
    square([280, 100]);

    // bottom cutouts
    translate([50+320, 0, 0])
    square([230, 100]);

    translate([50+870, 0, 0])
    square([230, 100]);

    translate([50+1750, 0, 0])
    square([150, 100]);

    // left cutout
    translate([0, 2890-180-240, 0])
    square([100, 240]);
}

module bmsCover()
{
//    linear_extrude(100)
    difference() {
    square([2230, 2890]);
    translate([50, 50, 0])
    square([2130, 2790]);
    }
}

module vents()
{
    for (jj = [250:400:3000]) {
    for (ii = [320:400:2000]) {
        translate([ii, jj, 0])
        circle(100, $fn=96);
    }}
}

scale(ViewScale)
{
    linear_extrude(200)
    difference() {
    bmsCover();
    cutouts(); }

    translate([0, 0, 100])
    linear_extrude(100)
    difference() {
    difference() {
        translate([50, 50, 0])
        square([2130, 2790]);
        translate([100, 100, 0])
        square([2030, 2690]);
        cutouts(); }
    }
    translate([0, 0, 200])
    linear_extrude(50)
    difference() {
    square([2230, 2890]);
    vents();
//    translate([150, 150, 0])
//    square([1930, 2590]);
    }

    
}
