ViewScale = [0.0254, 0.0254, 0.0254];


module foot()
{
    radius=1000;
    cutoutmult=0.85;
    intersection()
    {
        linear_extrude(1000)
        difference()
        {
            circle(radius, $fn=96);
            for(ii=[1:2:6])
            {
                radius0=radius*pow(cutoutmult,ii);
                radius1=radius0*cutoutmult;
                echo("radius0 ",radius0, " radius1 ",radius1);
                // outer cutout
                difference()
                {
                    circle(radius0, $fn=96);
                    circle(radius1, $fn=96);
                    translate([-490, 0, 0])
                    square([1000, 200], center=true);
                    //square([200, 1000], center=true);
                }
            }
        }
        sphere(r=radius, $fn=96);
    }
}

module strut()
{
    linear_extrude(800)
    {
        difference()
        {
            difference() 
            {
                circle(2000, $fn=96);
                circle(1800, $fn=96);
            }
            translate([-1000, 0, 0])
            square([2000, 4000], center=true);

            translate([0, -1000, 0])
            square([4000, 2000], center=true);
        }
        translate([1900, -490, 0])
        square([200, 1000], center=true);

        translate([-240, 1900, 0])
        square([500, 200], center=true);

        translate([-125-500, 1900, 0])
        rotate([0, 0, 30])
        circle(250, $fn=6);
    }
}

module base()
{
    // rotate

    rotate([0, 0, -90])
    foot();
    translate([-1900, 1000, 200])
    strut();
    // swivelbase

}

scale(ViewScale)
{
    base();
}
