ViewScale = [0.0254, 0.0254, 0.0254];

shaftR=500;

module mountring90(space)
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
           translate([shaftR+space/2+100-50, 100, 0])
            square([space+100, 300], center=true);
            circle(shaftR+20, $fn=96);

            #translate([shaftR+space/2+100-25, 200, 0])
//            translate([720, 0, 0])
            square([270, space+20], center=true);
        }
    }
}

scale(ViewScale)
{
    mountring90(270);
}
