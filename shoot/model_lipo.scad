module model_lipo(objcolor)
{
    *linear_extrude(20)
    square([750, 750], center=true);

    //translate([0, 0, 19])
    color(objcolor)
    linear_extrude(168)
    square([750, 500], center=true);
}

