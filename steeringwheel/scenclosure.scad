
module scEnclosure()
{
    insideW = scWidth + 120;
    insideH = scHeight + 120;
    echo("scEnclosure insideW ", insideW, " insideH ", insideH);
//    translate([0, 0, 100])

    linear_extrude(1100)
//    linear_extrude(900)
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
    translate([-(insideW + 70)/2+50+34, 0, 730])
    linear_extrude(100)
    square([100, insideH], center=true);

    translate([(insideW + 70)/2-50-34, 0, 730])
    linear_extrude(100)
    square([100, insideH], center=true);

    // Button backstop
    translate([0, 0, 730])
    linear_extrude(100)
    square([insideW, insideH/3], center=true);

    // Back with wire hole
    translate([0, 0, 1000])
    linear_extrude(100)
    difference() {
        square([insideW, insideH], center=true);
        circle(100/2, $fn=96);
    }

    // Mounting Holes

//    for (ii=[-4500/2, 4500/2]) {
//        for (jj=[-1500/2, 1500/2]) {
//            translate([ii, jj, 0])
//            linear_extrude(200)

        translate([0, 141, 500])
        rotate([-90, 0, 0])
        for (ss = [1, -1])
            translate([ss*750, 0, 0])
            scale([ss, 1, 1])
            linear_extrude(200)
            difference() {
                hull() {
                    circle(400/2, $fn=96);
                    translate([-200, 0, 0])
                    square([400, 400], center=true);
                }
                circle(180/2, $fn=96);
            }


//        }
///    }
//}


}
