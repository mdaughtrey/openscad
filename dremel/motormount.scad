ViewScale = [0.0254, 0.0254, 0.0254];


module tab()
{
    linear_extrude(1200)
    rotate([0, 0, 90])
    intersection()
    {
        translate([550, -200, 0]) square([300, 400], 1);
        difference()
        {
            circle(800, $fn=96);
            union() 
            {
                circle(610, $fn=96);
//                translate([710, -400, 0]) square([500, 800], 1);
            }
        }
    }

}

module rib()
{
    linear_extrude(50)
    difference()
    {
        circle(800, $fn=96);
        union()
        {
            circle(660, $fn=96);
//            translate([-800, 710, 0]) square([1800, 500], 1);
//            translate([-800, -1210, 0]) square([1800, 500], 1);
        }
    }
}

module sleeve()
{
    linear_extrude(1490)
    difference()
    {
        circle(660, $fn=96);
        circle(610, $fn=96);
    }
}

module face()
{
    linear_extrude(50)
    difference()
    {
    circle(800, $fn=96);
    union() 
    {
        translate([315, 0, 0]) circle(60, $fn=96);
        translate([-315, 0, 0]) circle(60, $fn=96);
        circle(200);
 //       translate([-800, 710, 0]) square([1800, 500], 1);
 //       translate([-800, -1210, 0]) square([1800, 500], 1);
    }
    }
}


scale(ViewScale)
{
    face();
    sleeve();
    translate([0, 0,  500]) rib();
    translate([0, 0, 1000]) rib();
    translate([0, 0, 1050]) {tab(); rotate([0, 0, 180]) tab();}
}


