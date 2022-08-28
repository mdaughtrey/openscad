
module model_APDS9960()
{
    scWidth = 532;
    scHeight = 521;
    //D122
    color("CornflowerBlue")
    {
    // APDS9660 carrier
//    translate([0, 0, 100])
    linear_extrude(63)
    difference() {
        square([scWidth, scHeight], center=true);
        translate([(scWidth/2) - (122/2)-3, (scHeight/2)-(122/2)-4, 0])
        circle(122/2, $fn=96);
        translate([(-scWidth/2) + (122/2)+3, (scHeight/2)-(122/2)-4, 0])
        circle(122/2, $fn=96);
        // Holes
        for(ii=[-200:100:200]){
            translate([ii, (-scHeight/2)+50, 0])
            circle(50/2);
        }
    }

    // solder joints under carrier 
    *translate([0, -(scHeight/2)+60, 0])
    linear_extrude(100)
    square([scWidth, 120], center=true);

    // solder joints on carrier 
    *translate([0, -(scHeight/2)+60, 162])
    linear_extrude(100)
    square([scWidth, 120], center=true);
    }

    if (modelcolor) color("OrangeRed")
    // APDS9660 sensor
    translate([0, scHeight/2-161, 63])
    linear_extrude(56)
    square([95, 161], center=true);
}
