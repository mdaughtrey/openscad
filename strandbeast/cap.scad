include <defs.scad>

//module rrect(x, y)
//{
//    corner = 100;
//    hull()
//    {
//        translate([(-x/2)+(corner/2), (-y/2)+(corner/2), 0])
//            square(corner);
//
//        translate([(x/2)-(corner/2), (-y/2)+(corner/2), 0])
//            square(corner);
//
//        translate([(-x/2)+(corner/2), (y/2)-(corner/2), 0])
//            square(corner);
//
//        translate([(x/2)-(corner/2), (y/2)-(corner/2), 0])
//            circle(r=corner);
//    }
//}
module cap(height, radius, corner)
{
//    echo("height ",height," radius ",radius," corner ",corner);
//    height = height - (height/6);
//    radius = radius - (radius/6); 
    rotate_extrude($fn=96) 
    {
////        corner = height/4;
        hull()
        {
            translate([0, 0, 0]) square(corner, 0);
            translate([radius, 0, 0]) square(corner, 0);
            translate([0, height, 0]) square(corner);
            union() {
            translate([radius, height, 0]) {
                intersection() {
                circle(r=corner);
                square(corner);
            }}}
        }
    }
}

module cap2(height, radius)
{
    rotate_extrude($fn=96) 
    {
        corner = height/4;
        hull()
        {
            translate([0, 0, 0]) square(corner, 0);
            translate([radius, 0, 0]) square(corner, 0);
            translate([0, height, 0]) square(corner);
            translate([radius, height, 0]) circle(r=corner);
        }
    }
}

scale(ViewScale) {
    cap(960, 200, 100);
}
