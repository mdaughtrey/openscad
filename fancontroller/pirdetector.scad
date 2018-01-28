use <model_pirdetector.scad>

ViewScale = [0.0254, 0.0254, 0.0254];

module rectHull(r, x, y)
{
    hull()
    {
        translate([(-x/2)+r, (-y/2)+r, 0]) circle(r=r);
        translate([(x/2)-r, (-y/2)+r, 0]) circle(r=r);
        translate([(-x/2)+r, (y/2)-r, 0]) circle(r=r);
        translate([(x/2)-r, (y/2)-r, 0]) circle(r=r);
    }
}

module enclosure_pirDetector()
{
    // outside cover
    linear_extrude(872) 
    difference() {
        rectHull(100, 1183, 1510);
        square([983, 1310], center=true);
    }

    // Right support
    translate([0, (1280-140)/2, 350+65+227])
    linear_extrude(120)
    square([1000, 170], center=true);

    // Left support
    translate([0, -(1280-140)/2, 350+65+227])
    linear_extrude(120)
    square([1000, 170], center=true);

    // Dome base
    translate([0, 0, 762])
    linear_extrude(50)
    difference() {
        rectHull(100, 1183, 1510);
        circle(460, $fn=96);
    }
}

scale(ViewScale)
{
    enclosure_pirDetector();
}
