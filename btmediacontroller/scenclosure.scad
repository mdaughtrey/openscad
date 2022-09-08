
module scEnclosure()
{  
    if(models)
    {
        translate([0, 0, 570])
        rotate([180, 0, 0])
        model_pushbutton_flat();
    }
    insideW = scWidth + 120;
    insideH = scHeight + 120;
    echo("scEnclosure insideW ", insideW, " insideH ", insideH);
//    translate([0, 0, 100])

    linear_extrude(679)
    translate([0, -20, 0])
    difference()
    {
        square([insideW + 120, insideH+80], center=true);
        translate([0, 30, 0])
        square([insideW, insideH+20], center=true);
    }

    // Sensor Carrier capture tabs
    translate([-(insideW + 70)/2+50+34, 0, 330])
    linear_extrude(100)
    square([100, insideH], center=true);

    translate([(insideW + 70)/2-50-34, 0, 330])
    linear_extrude(100)
    square([100, insideH], center=true);

    // Sensor Carrier capture tabs
    *translate([-(insideW + 70)/2+50+34, 0, 730])
    linear_extrude(100)
    square([100, insideH], center=true);

    *translate([(insideW + 70)/2-50-34, 0, 730])
    linear_extrude(100)
    square([100, insideH], center=true);

    // Button backstop
    *translate([0, 0, 730])
    linear_extrude(100)
    square([insideW, insideH/3], center=true);

    // Button side guides
//    translate([scWidth/2+15, -scHeight/2+29, 535])
//    linear_extrude(100)
//    square([80, 50], center=true);
//
//    translate([scWidth/2+15, scHeight/2-29, 535])
//    linear_extrude(100)
//    square([80, 50], center=true);
//
//    translate([-scWidth/2-15, -scHeight/2+29, 535])
//    linear_extrude(100)
//    square([80, 50], center=true);
//
//    translate([-scWidth/2-25, scHeight/2-29, 635])
//    linear_extrude(100)
//    square([80, 50], center=true);
}
