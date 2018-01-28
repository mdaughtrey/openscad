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
module pirLid()
{
    linear_extrude(50) 
    difference() {
    rectHull(100, 1183, 1510);
    translate([(1183-270)/2, 0, 0])
    square([280, 340], center=true);
    }
    translate([0, 0, 50])
    linear_extrude(260) 
    difference() {
    square([963, 1290], center=true);
    translate([(1183-270)/2, 0, 0])
    square([280, 340], center=true);
    square([863, 1190], center=true);

    }
//    difference() {
//       rectHull(100, 1183, 1510);
//       square([983, 1310], center=true);
//    }
}

module apdsLid()
{
    linear_extrude(50)
    difference(){
    rectHull(100, 968, 935);
    translate([-(968-230)/2, 50, 0])
    square([230, 670], center=true);
    translate([(968-230)/2, 50, 0])
    square([230, 670], center=true);
    }
    translate([0, 0, 50])
    linear_extrude(50)
    difference() {
    square([828, 795], center=true);
    translate([-(968-230)/2, 50, 0])
    square([230, 670], center=true);
    translate([(968-230)/2, 50, 0])
    square([230, 670], center=true);
    }
    translate([0, 0, 100])
    linear_extrude(240)
    square(300, center=true);
}


scale(ViewScale)
{
    translate([1200, 0, 0])
    apdsLid();
//    pirLid();
}
