ViewScale = [0.0254, 0.0254, 0.0254];

module speaker()
{
    linear_extrude(130)
    difference()
    {
        intersection() 
        {
            circle(3340/2, $fn=96);
            square([2650,4000], center=true);
        }
        for(ii = [0:90:360])
        {
            rotate([0, 0, 45+ii])
            translate([2740/2, 0, 0])
            circle(100, $fn=96);
        }
    }
    translate([0, 0, 129])
    linear_extrude(843)
    circle(2070/2, $fn=96);

    translate([3340/2-550-250, 0, 129])
    linear_extrude(400)
    square([500, 1287], center=true);



    translate([0, 0, 129+843])
    linear_extrude(127)
    circle(1620/2, $fn=96);
}

scale(ViewScale)
{
    speaker();
}
