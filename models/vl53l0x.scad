module model_VL53L0X()
{
    //D122
    color("CornflowerBlue")
    {
    // PCB
    translate([0, 0, 100])
//    linear_extrude(58)
    difference() {
        square([620, 500], center=true);
        #translate([790/2, 0, 0])
        difference() {
            circle(193/2, $fn=96);
            circle(125/2, $fn=96);
        }
        #translate([-790/2, 0, 0])
        difference() {
            circle(193/2, $fn=96);
            circle(125/2, $fn=96);
        }
    }

    // solder joints under carrier 
    *translate([0, -(521/2)+60, 0])
    linear_extrude(100)
    square([532, 120], center=true);

    // solder joints on carrier 
    *translate([0, -(521/2)+60, 170])
    linear_extrude(100)
    square([532, 120], center=true);
    }

    *color("OrangeRed")
    {
        // APDS9660 sensor
        translate([0, 521/2-161, 170])
        linear_extrude(56)
        square([95, 161], center=true);
    }
}
