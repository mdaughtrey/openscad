module ze(z, e) // z translation, linear_extrude, shape
{
    translate([0, 0, z])
    linear_extrude(e)
    children();
}

module zer(z, e, r) // z translation, linear_extrude, circle
{
    ze(z,e) circle(r, $fn=96);
}

module zerh(z,e,r,h) // z, extrude, radius, hole
{
    ze(z, e)
    difference()
    {
        circle(r, $fn=96);
        circle(h, $fn=96);
    }
}
