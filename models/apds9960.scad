module model_APDS9960()
{
    //D122
    color("CornflowerBlue")
    {
    // APDS9660 carrier
    translate([0, 0, 100])
    linear_extrude(63)
    difference() {
        square([532, 521], center=true);
        translate([(532/2) - (122/2)-3, (521/2)-(122/2)-4, 0])
        circle(122/2, $fn=96);
        translate([(-532/2) + (122/2)+3, (521/2)-(122/2)-4, 0])
        circle(122/2, $fn=96);
    }

    // solder joints under carrier 
    translate([0, -(521/2)+60, 0])
    linear_extrude(100)
    square([532, 120], center=true);

    // solder joints on carrier 
    translate([0, -(521/2)+60, 162])
    linear_extrude(100)
    square([532, 120], center=true);
    }

    color("OrangeRed")
    {
        // APDS9660 sensor
        translate([0, 521/2-161, 162])
        linear_extrude(56)
        square([95, 161], center=true);
    }
}
