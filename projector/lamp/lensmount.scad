ViewScale = [0.0254, 0.0254, 0.0254];

module cutouts()
{
    difference() {
        circle(1460/2, $fn=96);
        circle(1360/2, $fn=96);
        // tab
        translate([0, 700, 0])
        square([400, 200], center=true);
        // tab
        rotate([0, 0, 120]) 
        translate([0, 700, 0])
        square([400, 200], center=true);
        // tab
        rotate([0, 0, 240]) 
        translate([0, 700, 0])
        square([400, 200], center=true);
    }
}

module rotcutouts() {
    for(ii=[0:90:360]) {
        rotate([0, 0, ii])
        translate([0, 500, 0])
        square([400, 200], center=true);
    }
}

module bodymain()
{
    difference() {
        circle(1460/2, $fn=96);
        circle(1360/2, $fn=96);
    }
}

module bodycutout()
{
    difference() {
        circle(1460/2, $fn=96);
        circle(1360/2, $fn=96);
        *square([1020, 1020], center=true);
        translate([0, 700, 0])
        square([400, 200], center=true);
        scale([1.3,1.3,1.3])
        translate([0, 500, 0])
        square([400, 200], center=true);
        //rotcutouts();
    }
}

module bodycutout2()
{
    difference() {
        circle(1460/2, $fn=96);
        circle(1360/2, $fn=96);
        scale([1.3,1.3,1.3])
        translate([0, 500, 0])
        square([400, 200], center=true);
        //rotcutouts();
    }
}

module ledframe2()
{
    difference() {
    square([1030, 1030], center=true);
    square([800, 800], center=true);
    rotcutouts();
//    translate([0, 500, 0])
//    square([400, 200], center=true);
    }
}

module ledframe1()
{
    difference() {
        square([1030, 1030], center=true);
        square([900, 900], center=true);
        rotcutouts();
    }
}

module support()
{
    difference() {
    square([860, 860], center=true);
    square([760, 760], center=true);
    }
}

scale(ViewScale)
{
    linear_extrude(200){
        ledframe1();
        bodycutout();
    }
    linear_extrude(170)
    support();

    translate([0, 0, 200])
    linear_extrude(200)
    bodycutout2();

    translate([0, 0, 200])
    linear_extrude(200)
    ledframe2();

    translate([0, 0, 400])
    linear_extrude(500)
    bodymain();
    translate([0, 0, 900])
    linear_extrude(600)
    cutouts();
}
