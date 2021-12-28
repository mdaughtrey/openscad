include <model_boostbuck.scad>
include <model_fan.scad>
ViewScale = [0.0254, 0.0254, 0.0254];

module case()
{
    // PCB standoffs
    translate([-940, -480, 0])
    linear_extrude(400)
    {
        translate([1624, 133, 0])
        difference()
        {
            circle(250/2, $fn=96);
            circle(70/2, $fn=96);
        }

        translate([256, 855, 0])
        difference()
        {
            circle(250/2, $fn=96);
            circle(70/2, $fn=96);
        }
    }

    // Vex mounts
    linear_extrude(200)
    difference()
    {
        union()
        {
//            *translate([200, 955/2-750, 0])
            square([1500, 1500], center=true);
            for (ii=[-750,750])
            {
                for (jj=[-750,750])
                {
                    //translate([ii+200, 955/2+jj, 0])
                    translate([ii, jj, 0])
                    circle(380/2, $fn=96);
                }
            }
        }

        //*translate([0, 955/2-500, 0])
        {
            //translate([400, -50, 0])
            square([1100, 1100], center=true);
            for (ii=[-750,750])
            {
                for (jj=[-750,750])
                {
                    //translate([ii+200, 955/2+jj, 0])
                    translate([ii, jj, 0])
                    circle(180/2, $fn=96);
                }
            }
        }
    }

    translate([0, -900, 1010])
    color("cyan")
    //rotate([90, 0, 0])
    fanmount();
}

module fanmount0(ofs)
{
    for (ii = [-(1400-140)/2, (1400-140)/2])
    {
        translate([ii, -(1400-140)/2, ofs])
        linear_extrude(100)
        difference()
        {
            hull()
            {
                circle(350/2, $fn=96);
                translate([0, -200, 0])
                square([350, 350], center=true);
            }

            circle(140/2, $fn=96);
        }
    }
}

module fanmount()
{
    fanmount0(0);
    fanmount0(540);
    translate([0, -1570/2-200+25, 0])
    linear_extrude(640)
    square([1620, 100], center=true);
}


module forViewing()
{
    color("lightblue")
    translate([-1875/2, -955/2, 410])
    model_boostbuck();
    case();

    //*translate([1570/2+250/2, 1570/2-250-250/2, 850])
    translate([0, 0, 1000])
    model_fan();
}

module forPrinting()
{
    case();
}

scale(ViewScale)
{
    forViewing();
//    forPrinting();
}
