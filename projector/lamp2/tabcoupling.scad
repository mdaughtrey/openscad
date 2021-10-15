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

module body1()
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

//module bodycutout2()
//{
//    difference() {
//        circle(1460/2, $fn=96);
//        circle(1360/2, $fn=96);
//        scale([1.3,1.3,1.3])
//        translate([0, 500, 0])
//        square([400, 200], center=true);
//        //rotcutouts();
//    }
//}

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

//module mirror()
//{
//    translate([-525/2, 0, 500])
//    rotate([135, 0, 0]) {
//        translate([-10, 0, -500]) {
//        linear_extrude(1000)
//        difference() {
//            square([545, 164]);
//            translate([94/2, 0, 0])
//            square([445, 114]);
//        }
//        translate([0, 0, 1000])
//        linear_extrude(50)
//        square([525, 164]);
//    }}
//}
//
//module cap() 
//{
//    difference() {
//        circle(1600/2, $fn=96);
//        square([455, 870], center=true);
//    }
//}

//module vexmount1()
//{
//    difference() {
//        hull() {
//            circle(380/2);
//            translate([820, 0, 0])
//            square([380, 380], center=true);
//        }
//        circle(200/2);
//    }
//}


//module vexmount()
//{
//    linear_extrude(150) {
//        vexmount1();
//        translate([2000, 0, 0])
//        rotate([0, 180, 0])
//        vexmount1();
//    }
//}

//module mountsupport()
//{
//    difference() {
//        translate([0, 650, 0])
//        square([1500, 200], center=true);
//        circle(1600/2, $fn=96);
//    }
//}

module mirrormountgrooves()
{
    difference() {
        difference() {
            circle(1820/2, $fn=96);
            circle(1620/2, $fn=96);
        }
        for(ii=[30:30:360])
        {
            rotate([0, 0, ii])
            translate([850, 0, 0])
            square([200, 300], center=true);
        }
    }
}

module mirrormounttabs()
{
    intersection() {
    difference() {
        circle(1800/2, $fn=96);
        circle(1600/2, $fn=96);
    }
    for(ii=[30:120:270]){
        rotate([0, 0, ii])
        translate([880, 0, 0])
        square([200, 280], center=true);
    }}
}


module tab()
{
    // tab big bit
    *linear_extrude(160)
    intersection() {
        difference() {
            circle(1660/2, $fn=96);
            circle(1460/2, $fn=96);
        }
        rotate([0, 0, 52]) 
        translate([0, 700, 0])
        square([380, 260], center=true);
    }
    //translate([0, 0, 160])
    // tab little bit
    linear_extrude(130)
    intersection() {
        difference() {
            circle(1600/2, $fn=96);
            circle(1460/2, $fn=96);
        }
        rotate([0, 0, 45]) 
        translate([0, 700, 0])
        square([180, 300], center=true);
    }
}

module tabs()
{
    tab();
    rotate([0, 0, 120])
    tab();
    rotate([0, 0, 240])
    tab();
}

module tabcoupling()
{
    translate([0, 0, 0])
    linear_extrude(150)
    cutouts();

    translate([0, 0, 150])
    linear_extrude(150)
    cutouts2();

    translate([0, 0, 300])
    linear_extrude(200)
    body1();

    translate([0, 0, 500])
    linear_extrude(1700)
    difference() {
        circle(1460/2, $fn=96);
        circle(1400/2, $fn=96);
    }

    translate([0, 0, 2070])
    tabs();
}

//module tabbedlensmount() 
//{
//    // base
//    linear_extrude(1000)
//    difference() {
//        circle(1460/2, $fn=96);
//        circle(1360/2, $fn=96);
//    }
//
//    // support1
//    *linear_extrude(970)
//    difference() {
//        circle(1330/2, $fn=96);
//        circle(1180/2, $fn=96);
//    }
//
//    // support2
//    *linear_extrude(970)
//    difference() {
//        circle(1150/2, $fn=96);
//        circle(1000/2, $fn=96);
//    }
//
//    *translate([0, 0, 1000])
//    linear_extrude(50)
//    difference() {
//        circle(1460/2, $fn=96);
//        circle(1010/2, $fn=96);
//    }
//
//    *translate([0, 0, 1050])
//    linear_extrude(300) {
//        difference() {
//            circle(1110/2, $fn=96);
//            circle(1010/2, $fn=96);
//        }
//    }
//    translate([0, 0, 10])
//    tabs();
//}

//module adjvexmount()
//{
//    translate([-1000, 890, 190])
//    rotate([-90, 0, 0])
//    vexmount();
//
//    translate([0, 140, 0])
//    linear_extrude(380)
//    mountsupport();
//
//    linear_extrude(1000)
//    difference() {
//        circle(2050/2, $fn=96);
//        circle(1820/2, $fn=96);
//        mirrormountgrooves();
//    }
//    linear_extrude(1000)
//    mirrormountgrooves();
//}

// scale(ViewScale)
// {
//     tabcoupling();
// }
