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
            rotate([0, 0, 18])
            circle(2310/2, $fn=5);
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
        square([3346, 3346], center=true);
       // circle(1660/2, $fn=96);
        circle(1500/2, $fn=96);
    }
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


module cameramount() 
{
    module section(cutout) {
        difference() {
            circle(2168/2, $fn=96);
            intersection() {
                circle(1960/2, $fn=96);
                rotate([0, 0, 18])
                circle(2330/2, $fn=5);
            }
            if (cutout) {
                translate([0, -1000, 0])
                square([800, 1000], center=true);
            }
        }
    }
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
    linear_extrude(231)
    difference()  {
        section(cutout=0);
        translate([0, 600, 0])
        square([2200, 1200], center=true);
    }

    // Top ring
    translate([0, 0, 1190])
    linear_extrude(20)
    difference() {
        circle(2168/2, $fn=96);
        circle(1250/2, $fn=96);
        translate([0, 600, 0])
        square([2200, 1200], center=true);
    }

    // Through support
    translate([0, 0, 1209])
    linear_extrude(500)
    difference() {
        circle(1480/2, $fn=96);
        circle(1270/2, $fn=96);
        translate([0, 600, 0])
        square([2200, 1200], center=true);
    }

    // Interband struts
    linear_extrude(1100)
    intersection() {
        difference() {
            circle(2168/2, $fn=96);
            circle(1588/2, $fn=96);
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
}

module forViewing()
{
    translate([0, 0, 100]) {
        model_svbony205();
        translate([0, 0, 1150])
        if (modelcolor) color("green")
        model_mountto();
    }
    cameramount();
    translate([0, -1700, 490+250/2])
    rotate([-90, 0, 0])
    model_usbplug();

}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
