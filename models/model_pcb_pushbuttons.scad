include <../BOSL2-master/std.scad>
module model_pushbutton_6_6(anchor=CENTER, spin=0, orient=UP, modelcolor=false, height_mm=6.5)
{
    module model_pushbutton_6_6_()
    {
        // Legs
        if (modelcolor) color("silver")
        linear_extrude(175)
        for(ii=[0,300]) {
            for(jj=[10,199]) {
                translate([jj, ii, 0])
                square([26,10]);
            }
        }

        // Body main
        if (modelcolor) color("black")
        translate([0, (300-235)/2, 120])
        linear_extrude(120)
        square([235, 235]);

        // Body top
        if (modelcolor) color("silver")
        translate([0, (300-235)/2, 239])
        linear_extrude(11)
        square([235, 235]);

        // Shaft
        if (modelcolor) color("black")
        translate([235/2, 235/2+(300-235)/2, 249])
        linear_extrude((1/25.4*height_mm*1000)-131)
        circle(135/2);
    }
    attachable(anchor,spin,orient,size=[235,235,131+(1/25.4*height_mm*1000)])
    {
        translate([-235/2,-150,-300+235/2+60])
        model_pushbutton_6_6_();
        children();
    }
}

module model_pushbutton_top(anchor=CENTER,spin=0,orient=UP, modelcolor=false)
{
    module model_pushbutton_top_()
    {
        if (modelcolor) color("red")
        cyl(h=255, r=228/2);
    }
    attachable(anchor,spin,orient,r=228/2,h=255)
    {
        model_pushbutton_top_();
        children();
    }
}
