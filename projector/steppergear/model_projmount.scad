module model_projmount()
{
    for (ii=[0,1575])
    {
        translate([0, 0, ii])
        linear_extrude(210)
        difference()
        {
            circle(810/2, $fn=96);
            circle(150/2, $fn=96);
        }
    }
}

