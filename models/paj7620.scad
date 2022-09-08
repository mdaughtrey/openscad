
module model_PAJ7620()
{
    scWidth = 562;
    scHeight = 552;
    //D122
    color("CornflowerBlue")
    {
    // APDS9660 carrier
//    translate([0, 0, 100])
    linear_extrude(58)
    difference() {
        square([scWidth, scHeight], center=true);
        translate([(scWidth/2) - (133/2)-33, (scHeight/2)-(133/2)-40, 0])
        circle(133/2, $fn=96);
        translate([(-scWidth/2) + (133/2)+33, (scHeight/2)-(133/2)-40, 0])
        circle(133/2, $fn=96);
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
    translate([0, scHeight/2-203/2-70, 58])
    linear_extrude(60)
    square([118, 203], center=true);
}
