ViewScale = [0.0254, 0.0254, 0.0254];

//module cutouts()
//{
//    difference() {
//        circle(1460/2, $fn=96);
//        circle(1360/2, $fn=96);
//        // tab
//        translate([0, 700, 0])
//        square([400, 200], center=true);
//        // tab
//        rotate([0, 0, 120]) 
//        translate([0, 700, 0])
//        square([400, 200], center=true);
//        // tab
//        rotate([0, 0, 240]) 
//        translate([0, 700, 0])
//        square([400, 200], center=true);
//    }
//}

module rotcutouts() {
    for(ii=[0:90:360]) {
        rotate([0, 0, ii])
        translate([0, 500, 0])
        square([400, 200], center=true);
    }
}

//module bodymain()
//{
//    difference() {
//        circle(1460/2, $fn=96);
//        circle(1360/2, $fn=96);
//    }
//}

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
        circle(1110/2, $fn=96);
        circle(1010/2, $fn=96);
        scale([1.3,1.3,1.3])
        translate([0, 500, 0])
        square([400, 200], center=true);
        //rotcutouts();
    }
}

module bodycutout3()
{
    difference() {
        circle(1110/2, $fn=96);
        circle(1010/2, $fn=96);
        *scale([1.3,1.3,1.3])
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

module ledmount()
{
    linear_extrude(200){
        ledframe1();
    }

    translate([0, 0, 200])
    linear_extrude(200)
    ledframe2();

    translate([0, 0, 200])
    linear_extrude(400)
    bodycutout2();

    translate([0, 0, 400])
    linear_extrude(1000)
    bodycutout3();

}

module lensmount() 
{
    // base
    #linear_extrude(300)
    difference() {
    circle(1460/2, $fn=96);
    circle(1360/2, $fn=96);
    }

    // support1
    linear_extrude(270)
    difference() {
    circle(1330/2, $fn=96);
    circle(1180/2, $fn=96);
    }

    // support2
    linear_extrude(270)
    difference() {
    circle(1150/2, $fn=96);
    circle(1000/2, $fn=96);
    }

    translate([0, 0, 300])
    linear_extrude(50)
    difference() {
    circle(1460/2, $fn=96);
    circle(1010/2, $fn=96);
    }

    translate([0, 0, 350])
    linear_extrude(500)
    bodycutout3();
}

scale(ViewScale)
{
//    ledmount();
    //linear_extrude(170)
    //support();
 //   translate([0, 1300, 0])
    lensmount();
}
