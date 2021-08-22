module model_Veroboard(holesX, holesY)
{
    color("darkgoldenrod")
    linear_extrude(50)
    difference()
    {
        square([100 * holesX, 100 * holesY]);
        for (xx = [0:1:holesX-1])
        {
            for (yy = [0:1:holesY-1])
            {
                translate([xx * 100+50, yy * 100+50, 0])
                circle(15, $fn=96);
            }
        }
    }
}
