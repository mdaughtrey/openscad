use <model_adps9660.scad>
use <apds9660Surround.scad>

ViewScale = [0.0254, 0.0254, 0.0254];

module rectHull(r, x, y)
{
    hull()
    {
        // place 4 circles in the corners, with the given r
        //translate([(-x/2)+(r/2), (-y/2)+(r/2), 0])
        translate([(-x/2)+r, (-y/2)+r, 0])
            circle(r=r);

        //translate([(x/2)-(r/2), (-y/2)+(r/2), 0])
        translate([(x/2)-r, (-y/2)+r, 0])
            circle(r=r);

        //translate([(-x/2)+(r/2), (y/2)-(r/2), 0])
        translate([(-x/2)+r, (y/2)-r, 0])
            circle(r=r);

        //translate([(x/2)-(r/2), (y/2)-(r/2), 0])
        translate([(x/2)-r, (y/2)-r, 0])
            circle(r=r);
    }
}

module box()
{
    //ADPS9660Carrier();

    // main pcb surround
    translate([0, 0, 93])
    linear_extrude(469)
    {
    difference() {
    translate([50, 0, 0])
    rectHull(100, 1068, 935);
    square([828, 795], center=true);
    translate([(968+100)/2, 0, 0])
    square([100, 490], center=true);
    }
    // clip rails
    translate([795/2+175-50, 295]) square([100, 100], center=true);
    translate([795/2+175-50, -295]) square([100, 100], center=true);
    }

    // right support
    translate([(788-100)/2+3, -(755-500)/2-15, 200])
    linear_extrude(262)
    square([126, 500], center=true);

    // left support
    translate([-(788-100)/2-3, -(755-500)/2-15, 200])
    linear_extrude(262)
    square([126, 500], center=true);

    // cover
    translate([0, 0, 462])
    linear_extrude(30)
    difference() {
    rectHull(100, 968, 935);
    translate([0, 50, 0])
    square([254, 320], center=true);
    }

    // mounting around sensor
    // w,h,d 
    //translate([0, 50, 392])
    translate([0, 50, 432])
    {
        //sides(381, 315, 100);
        sides(321, 255, 60);
    }

    // mounting support
    translate([0, 50, 383])
    linear_extrude(50)
    difference() {
        square([255, 321], center=true);
        square([135, 201], center=true);
    }

    // surround with cutout for usb
    translate([0, 0, -300])
    linear_extrude(403) {
    difference() {
    translate([50, 0, 0])
    rectHull(100, 1068, 935);
    square([828, 795], center=true);
    translate([0, -(755)/2, 0])
    square([502, 200], center=true);
    translate([(968+100)/2, 0, 0])
    square([100, 490], center=true);
    }
    // clip rails
    translate([795/2+175-50, 295]) square([100, 100], center=true);
    translate([795/2+175-50, -295]) square([100, 100], center=true);
    }

//    // clip base
//    #translate([(935-75+240)/2+20, 0, -714])
//    linear_extrude(100)
//    square([75+240, 502], center=true);
//
//    // clip tongue
//    #translate([(935+240-50+210)/2, 0, -614])
//    linear_extrude(900)
//    square([100, 480], center=true);
//
//    // clip base old
//    *translate([0, -(818-75+230)/2-68, 93])
//    linear_extrude(100)
//    square([502, 75+240], center=true);
//
//    // clip tongue old
//    *#translate([0, -(818-75+210+190)/2-82, 193])
//    linear_extrude(500)
//    square([480, 100], center=true);
}

module clip()
{
    linear_extrude(480)
    {
    // tongue
    square([900, 100], center=true);
    // spine
    translate([-370/2, -230])
    square([1270, 100], center=true);
    //base
    translate([(900-100)/2, -150+50-15])
    square([100, 330], center=true);
    }
}

scale(ViewScale)
{
//    translate([760, 240, -260])
//    rotate([90, 90, 0])
//    color("CornflowerBlue")
//    clip();
    box();
}
