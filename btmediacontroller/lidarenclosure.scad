module lidarEnclosure()
{
    insideW = scWidth + 240;
    insideH = scHeight + 240;
    echo("lidarEnclosure insideW ", insideW, " insideH ", insideH);
    
    if(false == noModels)
    {
        translate([0,0, 215])
        rotate([180, 0, 0])
        model_VL53L0X();
    }

    // Bottom and sensor cutout
    linear_extrude(50)
    difference() 
    {
        square([1000, insideW], center=true);
        translate([0, -500/2+95/2+138, 0])
        square([197, 115], center=true);
    }

    // Sensor surround
    translate([0, 0, 49])
    linear_extrude(51)
    difference()
    {
        square([1000, insideW], center=true);
        model_VL53L0X_cutout();
    }
    // Walls
    translate([0, insideW/2-30, 49])
    linear_extrude(insideH-89)
    square([1000, 60], center=true);

    translate([0, -insideW/2+25, 49])
    linear_extrude(insideH-89)
    square([1000, 50], center=true);
}
