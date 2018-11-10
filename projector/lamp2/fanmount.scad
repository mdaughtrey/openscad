ViewScale = [0.0254, 0.0254, 0.0254];

module rotcutouts() {
    for(ii=[0:90:360]) {
        rotate([0, 0, ii])
        translate([0, 500, 0])
        square([400, 200], center=true);
    }
}

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

module ledshroud()
{
    // slips over led mount
    linear_extrude(800)
    difference() {
        square([1160, 1160], center=true);
        square([1060, 1060], center=true);
        translate([0, 500, 0])
        square([400, 200], center=true);
        rotcutouts();
    }

    // slips over heatsink
    linear_extrude(250)
    difference() {
        square([1060, 1060], center=true);
        square([960, 960], center=true);
        translate([0, 500, 0])
        square([400, 200], center=true);
        rotcutouts();
    }
}

module fanshroudside() 
{
    linear_extrude(340)
    difference() {
        union() {
            circle(1980/2, $fn=96);
            translate([450, 0, 0])
            square([900, 1980], center=true);
        }
        union() {
            circle(1800/2, $fn=96);
            translate([550, 0, 0])
            square([1100, 1800], center=true);
        }
        rotate([0, 0, 125])
        translate([0, 850, 0])
        square([750, 450], center=true);
    }
}

module fanshroudupper() 
{
    linear_extrude(50)
    difference() {
        union() {
            circle(1980/2, $fn=96);
            translate([450, 0, 0])
            square([900, 1980], center=true);
        }
        union() {
            circle(1680/2, $fn=96);
            translate([550, 0, 0])
            square([1100, 1680], center=true);
        }
        rotate([0, 0, 125])
        translate([0, 850, 0])
        square([750, 450], center=true);
//        rotate([0, 0, 60])
//        translate([0, 850, 0])
//        square([650, 450], center=true);
    }
}

module fanshroudlower() 
{
    linear_extrude(50)
    difference() {
        union() {
            circle(1980/2, $fn=96);
            translate([450, 0, 0])
            square([900, 1980], center=true);
        }
        square([960, 960], center=true);
//        union() {
//            circle(1680/2, $fn=96);
//            translate([550, 0, 0])
//            square([1100, 1680], center=true);
//        }
    }
}

module strainrelief()
{
    linear_extrude(100)
    difference() {
        circle(300, $fn=96);
        circle(200, $fn=96);
    }
}

scale(ViewScale)
{
//    translate([0, 0, 1400])
//    ledmount();

    translate([0, 0, 410])
    ledshroud();

    fanshroudupper();
    translate([0, 0, 50])
    fanshroudside();
    translate([0, 0, 390])
    fanshroudlower();

    translate([-900, 0, 700])
    rotate([0, 90, 0])
    strainrelief();
}
