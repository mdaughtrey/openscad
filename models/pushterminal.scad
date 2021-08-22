module model_PushTerminal(layouts)
{
    for (layout = layouts) // layout = [from, to, usepush]
    {
        for(ii = [layout[0]:1:layout[1]])
        {
            translate([0, 0, ii * 100])
            {
                if(layout[2])
                {
                    // Push things
                    color("orange")
                    translate([0, 200, 20])
                    linear_extrude(70)
                    polygon(points=[[0, 0], [270, 0], [270, 110], [170, 110]]);

                    // Pins
                    color("Silver")
                    for(jj = [-100, 100])
                    {
                        translate([-550/2-140/2, jj, 50])
                        linear_extrude(20)
                        square([140, 20], center=true);
                    }

                }

                // Body
                color("olivedrab")
//                difference() 
//                {
                    linear_extrude(100)
                    difference() 
                    {
                        square([550, 440], center=true);
                        translate([550/2-315/2, 440/2-10, 0])
                        square([315, 20], center=true);
                    }

                    if(layout[2])
                    {
                        color("darkgray")
                        translate([550/2-20, 440/2-140, 50])
                        rotate([0, 90, 0])
                        linear_extrude(30)
                        circle(80/2, $fn=96);
                    }
//                }
            }
        }
    }
}
