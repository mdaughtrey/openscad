module scFrontFace(insideW, insideH)
{
    // Front Face
    linear_extrude(20)
    difference() 
    {
        square([insideW+100, insideH+100], center = true);
        translate([0, insideH/2-163, 0])
        square([95+20, 161+20], center=true);
    }

    if(false == noModels)
    {
        // Sensor Model
        translate([0, 0, 85])
        rotate([180, 0, 180])
        model_APDS9960();
    }
}

// module scButtonCarrier(insideW, insideH)
// {
//     square([insideW + 100, 50], center=true);
// 
// }

module scOneStrut()
{
    linear_extrude(240)
    square([scWidth-110, 60], center=true);
    translate([0, 0, 236])
    linear_extrude(264)
    square([scWidth+110, 60], center=true);
}

module sensorCarrier()
{
    scInsideW = scWidth + 10;
    scInsideH = scHeight + 10;
    scFrontFace(scInsideW, scInsideH);

    translate([0, 0, 19])
    linear_extrude(200)
    difference()
    {
        square([scInsideW + 100, scInsideH + 100], center = true);
        square([scInsideW, scInsideH], center = true);
    }
    // struts
    translate([0, -scHeight/2-25, 199])
    scOneStrut();

    translate([0, +scHeight/2+25, 199])
    scOneStrut();

    if(false == noModels)
    {
        translate([0, 0, 535])
        rotate([0, 0, 0])
        model_pushbutton_flat();
    }

    // Button supports underneath
    translate([0, -scHeight/2+29, 435])
    linear_extrude(100)
    square([scWidth+110, 50], center=true);

    translate([0, scHeight/2-29, 435])
    linear_extrude(100)
    square([scWidth+110, 50], center=true);

    // Button side guides
    translate([scWidth/2+15, -scHeight/2+29, 535])
    linear_extrude(100)
    square([80, 50], center=true);

    translate([scWidth/2+15, scHeight/2-29, 535])
    linear_extrude(100)
    square([80, 50], center=true);

    translate([-scWidth/2-15, -scHeight/2+29, 535])
    linear_extrude(100)
    square([80, 50], center=true);

    translate([-scWidth/2-15, scHeight/2-29, 535])
    linear_extrude(100)
    square([80, 50], center=true);


}
