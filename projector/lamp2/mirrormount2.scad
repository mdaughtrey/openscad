ViewScale = [0.0254, 0.0254, 0.0254];

module cutouts()
{
   difference() {
        circle(1600/2, $fn=96);
        circle(1490/2, $fn=96);
        // tab
        rotate([0, 0, 45]) 
        translate([0, 700, 0])
        square([200, 200], center=true);
        // tab
        rotate([0, 0, 165]) 
        translate([0, 700, 0])
        square([200, 200], center=true);
        // tab
        rotate([0, 0, 285]) 
        translate([0, 700, 0])
        square([200, 200], center=true);
    }
}

module cutouts2()
{
   difference() {
        circle(1600/2, $fn=96);
        circle(1490/2, $fn=96);
        // tab
        rotate([0, 0, 53]) 
        translate([0, 700, 0])
        square([400, 200], center=true);
        // tab
        rotate([0, 0, 173]) 
        translate([0, 700, 0])
        square([400, 200], center=true);
        // tab
        //#rotate([0, 0, 240]) 
        rotate([0, 0, 293]) 
        translate([0, 700, 0])
        square([400, 200], center=true);
    }
}

//module rotcutouts() {
//    for(ii=[0:90:360]) {
//        rotate([0, 0, ii])
//        translate([0, 500, 0])
//        square([400, 200], center=true);
//    }
//}

module bodymain()
{
    difference() {
        circle(1600/2, $fn=96);
        circle(1400/2, $fn=96);
    }
}

//module bodycutout()
//{
//    difference() {
//        circle(1460/2, $fn=96);
//        circle(1360/2, $fn=96);
//        *square([1020, 1020], center=true);
//        translate([0, 700, 0])
//        square([400, 200], center=true);
//        scale([1.3,1.3,1.3])
//        translate([0, 500, 0])
//        square([400, 200], center=true);
//        //rotcutouts();
//    }
//}

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

//module ledframe2()
//{
//    difference() {
//    square([1030, 1030], center=true);
//    square([800, 800], center=true);
//    rotcutouts();
////    translate([0, 500, 0])
////    square([400, 200], center=true);
//    }
//}
//
//module ledframe1()
//{
//    difference() {
//        square([1030, 1030], center=true);
//        square([900, 900], center=true);
//        rotcutouts();
//    }
//}

//module support()
//{
//    difference() {
//    square([860, 860], center=true);
//    square([760, 760], center=true);
//    }
//}

module mirror()
{
    translate([-525/2, 0, 500])
    rotate([135, 0, 0]) {
        translate([-10, 0, -500]) {
        linear_extrude(1000)
        difference() {
            square([545, 164]);
            translate([94/2, 0, 0])
            square([445, 114]);
        }
        translate([0, 0, 1000])
        linear_extrude(50)
        square([525, 164]);
    }}
}

module cap() 
{
    difference() {
        circle(1600/2, $fn=96);
        square([455, 870], center=true);
    }
}

module vexmount1()
{
    difference() {
        hull() {
            circle(380/2);
            translate([820, 0, 0])
            square([380, 380], center=true);
        }
        circle(200/2);
    }
}


module vexmount()
{
    linear_extrude(150) {
        vexmount1();
        translate([2000, 0, 0])
        rotate([0, 180, 0])
        vexmount1();
    }
}

module mountsupport()
{
    difference() {
        translate([0, 650, 0])
        square([1500, 200], center=true);
        //circle(1490/2, $fn=96);
        circle(1600/2, $fn=96);
    }
}

scale(ViewScale)
{
//    #linear_extrude(200){
//        ledframe1();
//        bodycutout();
//    }
//    #linear_extrude(170)
//    support();
//
//    #translate([0, 0, 200])
//    linear_extrude(200)
//    bodycutout2();
//
//    #translate([0, 0, 200])
//    linear_extrude(200)
//    ledframe2();

    translate([0, 0, 0])
    linear_extrude(150)
    cutouts();

    translate([0, 0, 150])
    linear_extrude(150)
    cutouts2();

    translate([0, 0, 300])
    linear_extrude(200)
    bodymain();

    translate([0, 0, 500])
    linear_extrude(50)
    cap();

    translate([0, 0, 300])
    mirror();

    translate([-1000, 750, 300])
    rotate([-90, 0, 0])
    vexmount();

    translate([0, 0, 110])
    linear_extrude(380)
    mountsupport();

}
