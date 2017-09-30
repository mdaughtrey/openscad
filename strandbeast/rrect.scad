include <defs.scad>

module rrect(x, y, z)
{
    radius = 250;
//    linear_extrude(200)
    hull()
    {
        // place 4 circles in the corners, with the given radius
        translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
            circle(r=radius);

        translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
            circle(r=radius);

        translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
            circle(r=radius);

        translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
            circle(r=radius);
    }
}

module arcStrut(sweep, radius)
{
    intersection() {
        linear_extrude(1000)
        hull(){
            polygon([[0, 0], [0, radius*2], [radius*2*sin(sweep), radius*2*cos(sweep)]]);
        }
        rotate_extrude($fn=96) 
        {
            translate([radius, 0, 0])
            rrect(500, 500);
        }
    }
}

scale(ViewScale) {
    arcStrut(60, 3000);
}
