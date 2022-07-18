ViewScale = [0.0254, 0.0254, 0.0254];

// #The whole length is 14 in
// #The width of the hole is 9 and 1/2 in
// #The grill is 240 mm square
// #The spring clips are 1 in in from the outside

holeL=14000;
holeW=9500;
oldgrilldim=9450;

module rectHull(r, x, y)
{
    hull()
    {
        // place 4 circles in the corners, with the given r
        translate([(-x/2)+(r/2), (-y/2)+(r/2), 0])
            circle(r=r);

        translate([(x/2)-(r/2), (-y/2)+(r/2), 0])
            circle(r=r);

        translate([(-x/2)+(r/2), (y/2)-(r/2), 0])
            circle(r=r);

        translate([(x/2)-(r/2), (y/2)-(r/2), 0])
            circle(r=r);
    }
}

module model_hole()
{
    linear_extrude(625)
    difference() {
        square([holeL+2000, holeW+2000], center=true);
        square([holeL, holeW], center=true);
    }
}

module model_oldgrill()
{
    linear_extrude(200)
    difference() {
        square([oldgrilldim, oldgrilldim], center=true);
        square([oldgrilldim-3000, oldgrilldim-3000], center=true);
    }

    translate([oldgrilldim/2-1000, 0, 199])
    linear_extrude(500)
    square([500, 200], center=true);

    translate([-oldgrilldim/2+1000, 0, 199])
    linear_extrude(500)
    square([500, 200], center=true);

}

module newgrill()
{
    linear_extrude(100)
    difference() {
        rectHull(500, holeL+2000, holeW+2000);
        *translate([0, 0, 0])
        square([holeL, holeW], center=true);
        for(ii=[0:300:holeL-2700]) {
            translate([-9500/2-800+ii, 2400, 0])
            square([200, 4400], center=true);
        }

        for(ii=[0:300:holeL-2700]) {
            translate([-9500/2-800+ii, -2400, 0])
            square([200, 4400], center=true);
        }
    }

    *translate([0, 0, 99])
    linear_extrude(101)
    difference() {
        rectHull(500, holeL+2000, holeW+2000);
        translate([0, 0, 0])
        square([holeL+400, holeW+400], center=true);
    }

    translate([0, 0, 99])
    linear_extrude(201)
    difference() {
        rectHull(500, holeL+2000, holeW+2000);
        translate([0, 0, 0])
        rectHull(400, holeL+1800, holeW+1800);
    }




}

module forViewing()
{
    translate([0, 0, 400]) {
        color("lightgray")
        model_hole();
        translate([-7500/2+1500, 0, 0])
        color("lightgray")
        model_oldgrill();
    }
    color("cyan")
    newgrill();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
