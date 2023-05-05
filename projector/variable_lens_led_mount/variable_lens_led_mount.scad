ViewScale = [0.0254, 0.0254, 0.0254];

include <model_1w_led.scad>
include <model_variable_lens.scad>
include <model_small_heatsink.scad>

model=1;

module ledpcb()
{
    linear_extrude(70)
    difference() {
        square([880, 880], center=true);
        square([580, 580], center=true);
    }

}

module tabbed()
{
    module tab()
    {
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

        linear_extrude(200)
        difference() {
            circle(1461/2, $fn=96);
            circle(1355/2, $fn=96);
        }

    }
    // front
    linear_extrude(20)
    difference() {
        circle(1420/2, $fn=96);
        circle(1220/2, $fn=96);
    }

    // Inner ring
    *translate([0, 0, 19])
    linear_extrude(100)
    difference() {
        circle(880/2, $fn=96);
        circle(780/2, $fn=96);
        translate([400, 0, 0])
        square(150, center=true);
    }
    // Outer
    *translate([0, 0, 19])
    linear_extrude(392-20+70+20)
    difference() {
        circle(1420/2, $fn=96);
        circle(1350/2, $fn=96);
    }
    // Inner ribs
    *translate([0, 0, 19])
    linear_extrude(392-20+20)
    for(ii = [0:120:360]) {
        rotate([0, 0, ii])
        translate([600, 0, 0])
        square(180, center=true);
    }
    // Inserts
    *translate([0, 0, 19+392-19+20])
    linear_extrude(70)
    for(ii = [0:120:360]) {
        rotate([0, 0, ii])
        translate([620, 0, 0])
        square([120, 100], center=true);
    }
    tabs();
}

module fanmount()
{
    module rotcutouts() {
        for(ii=[0:90:360]) {
            rotate([0, 0, ii])
            translate([0, 500, 0])
            square([400, 200], center=true);
        }
    }
    module ledframe1()
    {
        difference() {
            square([1140, 1140], center=true);
            square([900, 900], center=true);
            rotcutouts();
        }
    }
    module ledframe2()
    {
        difference() {
        square([1140, 1140], center=true);
        square([800, 800], center=true);
        rotcutouts();
        }
    }
    module bodycutout2()
    {
        difference() {
            circle(1110/2, $fn=96);
            circle(1010/2, $fn=96);
            scale([1.3,1.3,1.3])
            translate([0, 450, 0])
            square([300, 200], center=true);
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

    linear_extrude(200)
    difference() {
        square([1140, 1140], center=true);
        square([1030, 1040], center=true);
        translate([-300, 550, 0])
        square([200, 100], center=true);
    }
    translate([0, 0, 200])
    linear_extrude(200)
    difference() {
        square([1140, 1140], center=true);
        square([1030, 1040], center=true);
    }
    translate([0, 0, 400])
    linear_extrude(300){
        ledframe1();
    }

    *translate([0, 0, 800])
    linear_extrude(200)
    ledframe2();

    *translate([0, 0, 800])
    linear_extrude(200)
    bodycutout2();

    *translate([0, 0, 1000])
    linear_extrude(1000)
    bodycutout3();

}

module mount()
{
    module cutouts()
    {
        for (ii=[0:60:360])
        {
            rotate([0, 0, ii])
            translate([760/2, 0, 0])
            circle(160/2, $fn=96);
        }
    }
    module surround() {
        difference() {
            circle(1461/2, $fn=96);
            difference() {
                circle(1350/2, $fn=96);
                circle(760/2, $fn=96);
                square([2000, 100], center=true);
                square([100, 2000], center=true);
           }
           circle(560/2, $fn=96);
           rotate([0, 0, 45])
           translate([260, 0, 0])
           square([100, 50], center=true);
        }
    }

    // LED surround
    linear_extrude(120)
    difference() {
        circle(1461/2, $fn=96);
        square([850, 850], center=true);
    }


    *linear_extrude(60)
    difference() {
        circle(1461/2, $fn=96);
        circle(930/2, $fn=6);
        cutouts();
    }


    // LED Capture
    *translate([0, 0, 59])
    linear_extrude(61)
    difference() {
        circle(1461/2, $fn=96);
        circle(730/2, $fn=6);
        cutouts();
    }

    translate([0, 0, 119])
    linear_extrude(181)
    difference() {
        circle(1461/2, $fn=96);
        circle(1350/2, $fn=96);
        rotate([0, 0, 45]) {
            square([2000, 400], center=true);
            square([400, 2000], center=true);
        }
    }

    // Body
    translate([0, 0, 299])
    linear_extrude(1200)
    difference() {
        circle(1461/2, $fn=96);
        circle(1350/2, $fn=96);
        square([1200, 4000], center=true);
    }

    // Lens base surround
    translate([0, 0, 299])
    linear_extrude(261)
    surround();

    translate([0, 0, 1700])
    rotate([180, 0, 0])
    tabbed();

    translate([0, 0, -700])
    fanmount();
}


module forViewing()
{
    if (model) {
    color("gray") {
        model_1w_led();
        translate([0, 0, 300])
        model_variable_lens();
    }
    }
    mount();
    color("cornflowerblue")
    translate([0, 0, 0])
    rotate([180, 0, 0])
    model_small_heatsink();
    translate([0, 0, -80])
    color("sienna")
    ledpcb();
}

module forPrinting()
{
    mount();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
