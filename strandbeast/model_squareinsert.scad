include <defs.scad>

InsertX = 320;
InsertE = 140;
InsertY = 580;
InsertCapX = InsertX+20;
InsertCapY = InsertY/8;

module insert()
{
    rotate([90, 0, 0])
    linear_extrude(InsertE)
    {
    // end 
    translate([0, -InsertY/2+(InsertCapY/2), 0])
    square([InsertCapX, InsertCapY], center=true);
    // end
    translate([0, InsertY/2-(InsertCapY/2), 0])
    square([InsertCapX, InsertCapY], center=true);
    square([InsertX, InsertY-(InsertCapY*2)], center=true);
    }
}

//scale(ViewScale)
//{
//    insert();
//}

