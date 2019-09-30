ViewScale = [0.0254, 0.0254, 0.0254];

shaftR=500;

module mountring(space)
{
    linear_extrude(500)
    {
        difference()
        {
            circle(shaftR+70, $fn=96);
            circle(shaftR+20, $fn=96);
        }
        difference() 
        {
            translate([500, 0, 0])
            square([700, space+100], center=true);
            circle(shaftR+20, $fn=96);

            translate([720, 0, 0])
            square([270, space+20], center=true);
        }
    }
}

scale(ViewScale)
{
    mountring(270);
}
