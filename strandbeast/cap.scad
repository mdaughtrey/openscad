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

module cap(height, radius)
{
    translate([0, 0, height/2])
    rotate_extrude($fn=96) 
    {
        corner = 100;
        translate([height/2, 0, 0]) //rrect(radius, height);
        hull()
        {
            translate([(-radius/2)+(corner/2), (-height/2)+(corner/2), 0])
                square(corner);

            translate([(radius/2)-(corner/2), (-height/2)+(corner/2), 0])
                square(corner);

            translate([(-radius/2)+(corner/2), (height/2)-(corner/2), 0])
                square(corner);

            translate([(radius/2)-(corner/2), (height/2)-(corner/2), 0])
                circle(r=corner);
        }
    }
}

scale(ViewScale) {
    cap(300, 400);
}
