ViewScale = [0.0254, 0.0254, 0.0254];

modelcolor=1;

module model_svbony205()
{
    if (modelcolor) color("grey")
    {
        linear_extrude(100)
        circle(1968/2, $fn=96);
        translate([0, 0, 99])
        linear_extrude(981)
        intersection() {
            circle(1960/2, $fn=96);
            //#rotate([0, 0, 18])
            circle(2168/2, $fn=6);
        }
        translate([0, 0, 1079])
        linear_extrude(601)
        circle(1250/2, $fn=96);
    }

    if (modelcolor) color("cyan")
    translate([0, -1000, 250+240])
    rotate([-90, 0, 0])
    linear_extrude(100)
    square([500, 480], center=true);

}

module model_mountto()
{
    linear_extrude(240)
    difference() {
        union() {
            intersection() {
            translate([0, -205, 0])
            circle(2276, $fn=96);
            translate([0, 1320, 0])
            square([3346, 3346], center=true);
          }
          translate([0, -500, 0])
          square([3346, 3346-1000], center=true);
        }
        circle(1500/2, $fn=96);
    }
//    difference() {
//        translate([0, -205, 0])
//        circle(2276, $fn=96);
//        *#translate([0, 1500/2+1320/2, 0])
//        square([200, 1320], center=true);
//    }
}

module model_usbplug()
{
    if (modelcolor) color("gray")
    linear_extrude(500)
    square([419, 526], center=true);
    if (modelcolor) color("gold") 
    translate([0, 0, 499])
    linear_extrude(471)
    square([316, 412], center=true);
}

module bolttabs(space)
{
    module onetab() {
        difference() {
            hull() {
                circle(330/2, $fn=96);
                translate([330/2, 0, 0])
                square([330, 330], center=true);
            }
            circle(130/2, $fn=96);
        }
    }
    linear_extrude(200) {
        translate([-space/2, 0, 0])
        onetab();
        translate([space/2, 0, 0])
        scale([-1.0, 1.0, 1.0])
        onetab();
    }
}

module section(cutout) {
    difference() {
        circle(2168/2, $fn=96);
        intersection() {
            circle(1988/2, $fn=96);
//                rotate([0, 0, 18])
            circle(2188/2, $fn=6);
        }
        if (cutout) {
            translate([0, -1000, 0])
            square([800, 1000], center=true);
        }
    }
}

module cameramount() 
{
    // Bottom
    linear_extrude(100)
    difference() {
        circle(2168/2, $fn=96);
        circle(1588/2, $fn=96);
    }
    // Band
    translate([0, 0, 99])
    linear_extrude(101)
    difference() {
        circle(2168/2, $fn=96);
        circle(1988/2, $fn=96);
        translate([0, 600, 0])
        square([2200, 1200], center=true);
    }

    // Band
    translate([0, 0, 480])
    linear_extrude(200)
    difference()  {
        section(cutout=1);
        translate([0, 600, 0])
        square([2200, 1200], center=true);
    }

    // Band
    translate([0, 0, 979])
    linear_extrude(271)
    difference()  {
        section(cutout=0);
        translate([0, 590, 0])
        square([2200, 1200], center=true);
    }

    // Top ring
    translate([0, 0, 1200])
    linear_extrude(50)
    difference() {
        circle(2168/2, $fn=96);
        circle(1280/2, $fn=96);
        translate([0, 590, 0])
        square([2200, 1200], center=true);
    }

    // Through support
    translate([0, 0, 1209])
    linear_extrude(500)
    difference() {
        circle(1480/2, $fn=96);
        circle(1280/2, $fn=96);
        translate([0, 590, 0])
        square([2200, 1200], center=true);
    }

    // Interband struts
    linear_extrude(1100)
    intersection() {
        difference() {
            circle(2168/2, $fn=96);
            circle(1988/2, $fn=96);
        }
        union() {
            rotate([0, 0, -36])
            translate([0, -700, 0])
            square([500, 1400], center=true);
            rotate([0, 0, 36])
            translate([0, -700, 0])
            square([500, 1400], center=true);
        }
    }
    translate([0, -10, 980+105])
    rotate([90, 0, 0])
    bolttabs(2650);
}

module cameraclamp()
{
    // Band
    linear_extrude(271)
    difference()  {
        section(cutout=0);
        translate([0, -590, 0])
        square([2200, 1200], center=true);
    }

    // Crossbolt hole
    difference() {
        linear_extrude(270)
        difference() {
            translate([0, 1200, 0])
            square([500, 300], center=true);
            circle(2168/2, $fn=96);
        }
        translate([-300, 1200, 135])
        rotate([0, 90, 0])
        linear_extrude(600)
        circle(130/2, $fn=96);
    }


    // Top ring
    translate([0, 0, 220])
    linear_extrude(50)
    difference() {
        circle(2168/2, $fn=96);
        circle(1280/2, $fn=96);
        translate([0, -590, 0])
        square([2200, 1200], center=true);
    }

    // Through support
    translate([0, 0, 229])
    linear_extrude(500)
    difference() {
        circle(1480/2, $fn=96);
        circle(1280/2, $fn=96);
        translate([0, -590, 0])
        square([2200, 1200], center=true);
    }
    translate([0, 210, 106])
    rotate([90, 0, 0])
    bolttabs(2650);


}

module outerclamp()
{
    module ocsection(inner) {
        intersection() {
            translate([0, -205, 0])
            difference() {
                circle(2396, $fn=96);
                circle(inner, $fn=96);
            }
            *translate([0, 2000, 0])
            square([3776, 2000], center=true);

            union() {
                translate([1400, 2000, 0])
                square([1000, 2000], center=true);
                translate([-1400, 2000, 0])
                square([1000, 2000], center=true);
            }
        }
    }
    translate([0, 0, 165])
    linear_extrude(100)
    ocsection(inner=2096);

    translate([0, 0, 259])
    linear_extrude(261)
    ocsection(inner=2296);

    translate([0, 0, 519])
    linear_extrude(101)
    ocsection(inner=2096);
}


module forViewing()
{
    translate([0, 0, 110]) {
        model_svbony205();
        translate([0, 0, 1140])
        if (modelcolor) color("green")
        model_mountto();
    }
    cameramount();
    translate([0, 0, 979]) {
        cameraclamp();
        outerclamp();
    }
    translate([0, -1700, 490+250/2])
    rotate([-90, 0, 0])
    model_usbplug();

}

module forPrinting()
{
    linear_extrude(200)
    difference() {
    circle(2588/2, $fn=6);
    circle(2188/2, $fn=6);
//    circle(2400/2, $fn=6);
//    circle(2000/2, $fn=6);
    }
}

scale(ViewScale)
{
    forViewing();
//    forPrinting();
}
