module model_VL53L0X_cutout()
{
    square([640, 520], center=true);
    hull() {
        translate([790/2, 0, 0])
        circle(213/2, $fn=96);
        translate([-790/2, 0, 0])
        circle(213/2, $fn=96);
    }
}

module model_VL53L0X()
{
    //D122
    color("CornflowerBlue")
    {
        // PCB
        translate([0, 0, 100])
        {
            linear_extrude(65)
            {
                square([620, 500], center=true);
                difference()
                {
                    hull() {
                        translate([790/2, 0, 0])
                        circle(193/2, $fn=96);
                        translate([-790/2, 0, 0])
                        circle(193/2, $fn=96);
                    }
                    translate([790/2, 0, 0])
                    circle(125/2, $fn=96);
                    translate([-790/2, 0, 0])
                    circle(125/2, $fn=96);
                }
            }
        }
    }

    // clearance area under carrier
    color("Green") 
    {
        linear_extrude(100)
        square([620, 500], center=true);
    }

    // solder joints under carrier 
    *translate([0, -(521/2)+60, 0])
    linear_extrude(100)
    square([532, 120], center=true);

    // solder joints on carrier 
    *translate([0, -(521/2)+60, 170])
    linear_extrude(100)
    square([532, 120], center=true);

    color("OrangeRed")
    {
        translate([0, 500/2-95/2-138, 165])
        linear_extrude(56)
        square([177, 95], center=true);
    }
}
