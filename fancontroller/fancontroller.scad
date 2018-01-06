ViewScale = [0.0254, 0.0254, 0.0254];


module rectHull(r, x, y)
{
    hull()
    {
        // place 4 circles in the corners, with the given r
        //translate([(-x/2)+(r/2), (-y/2)+(r/2), 0])
        translate([(-x/2)+r, (-y/2)+r, 0])
            circle(r=r);

        //translate([(x/2)-(r/2), (-y/2)+(r/2), 0])
        translate([(x/2)-r, (-y/2)+r, 0])
            circle(r=r);

        //translate([(-x/2)+(r/2), (y/2)-(r/2), 0])
        translate([(-x/2)+r, (y/2)-r, 0])
            circle(r=r);

        //translate([(x/2)-(r/2), (y/2)-(r/2), 0])
        translate([(x/2)-r, (y/2)-r, 0])
            circle(r=r);
    }
}

scale(ViewScale)
{
    linear_extrude(50)
    difference() {
        rectHull(100, 955, 960);
        translate([0, 72, 0])
        square([200, 226], center=true);
        //square([100, 163], center=true);
    }
    translate([-410, 300, 50])
    linear_extrude(100)
    square([820, 100]);

    translate([310, -410, 50])
    linear_extrude(100)
    square([100, 400]);

    translate([-410, -410, 50])
    linear_extrude(100)
    square([100, 400]);

    translate([0, 0, 50])
    linear_extrude(350)
    difference() {
        rectHull(100, 955, 960);
        square([805, 810], center=true);
    }

    translate([0, 0, 400])
    linear_extrude(350)
    difference() {
        rectHull(100, 955, 960);
        square([805, 810], center=true);
        translate([0, -450])
        square([510, 200], center=true);
    }
}
