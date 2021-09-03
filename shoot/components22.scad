d22 = function(i) [896-1970/2,228-3940/2,1073-1970/2,559-3940/2][i];

module d22()
{
    hull()
    {
    translate([1073-1970/2,228-3940/2,60])
    square([63, 71], center=true);
    translate([1073-1970/2,559-3940/2,60])
    square([63, 71], center=true);
    translate([984-1970/2,559-3940/2,60])
    square([63, 71], center=true);
    translate([896-1970/2,559-3940/2,60])
    square([63, 71], center=true);
    translate([896-1970/2,228-3940/2,60])
    square([63, 71], center=true);
    }
}
