ViewScale = [0.0254, 0.0254, 0.0254];

fabricThickness=20;
grommetHeight=100;      // protrusion through the fabric
grommetOR=550;
grommetIR=490;
grommetFlangeOR=650;
grommetRingOR=grommetFlangeOR;
grommetRingIR=grommetOR + fabricThickness;
grommetWing=50;
grommetWingW=100;
flapperShaftR=50;
circleR=grommetIR+((grommetOR-grommetIR)/2);
echo("Vinyl Circle Radius ", circleR);

module outer()
{
    // base
    linear_extrude(30)
    circle(500, $fn=96);

    // supports
    translate([0, 0, 30])
    linear_extrude(100)
    intersection()
    {
        difference() {
            circle(500, $fn=96);
            circle(450, $fn=96);
        }
        union() {
            square([1000, 100], center=true);
            square([100, 1000], center=true);
        }
    }
    // top
    translate([0, 0, 130])
    linear_extrude(50)
    difference() {
        circle(500, $fn=96);
        circle(400, $fn=96);
    }
    // shaft
    translate([0, 0, 30])
    linear_extrude(100)
    circle(50, $fn=96);

}

module flapper()
{
    linear_extrude(50)
    difference() {
        circle(500, $fn=96);
        circle(450, $fn=96);
    }
    linear_extrude(50)
    for(ii=[0:45:360]) {
        rotate([0, 0, ii])
        square([50, 1000], center=true);
    }

    // shaft
    translate([0, 0, 30])
    linear_extrude(100)
    circle(flapperShaftR, $fn=96);
}

module testjig()
{
    linear_extrude(1500)
    difference() {
        circle(550, $fn=96);
        circle(490, $fn=96);
    }

    translate([0, 0, 1500])
    linear_extrude(50)
    difference() {
        circle(550, $fn=96);
        circle(510, $fn=96);
    }
}

module grommet()
{
    linear_extrude(30)
    difference() {
        circle(grommetFlangeOR, $fn=96); // 650
        circle(grommetIR, $fn=96);  // 490
    }

    translate([0, 0, 30])
    linear_extrude(grommetHeight)
    difference() {
        circle(grommetOR, $fn=96); // grommetOR 550
        circle(grommetIR, $fn=96); // grommetIR 490
    }

    translate([0, 0, 130])
    linear_extrude(50)
    difference() {
        circle(grommetOR, $fn=96);
        circle(510, $fn=96);
    }
}

module grommetring()
{
    linear_extrude(grommetHeight-fabricThickness)
    difference() {
        circle(grommetRingOR, $fn=96);
        circle(grommetRingIR, $fn=96);
    }

    
    translate([0, 0, ((grommetHeight-fabricThickness)/2)])
    linear_extrude((grommetHeight-fabricThickness)/2)
    intersection() {
        difference() {
            circle(grommetRingOR+grommetWing, $fn=96);
            circle(grommetRingOR-20, $fn=96);
        }
        square([grommetWingW, 2000], center=true);
    }
}

module cap()
{
    // layer 1 cutout
    layer1H=(grommetHeight-fabricThickness)/2+20;
    linear_extrude(layer1H)
    difference() {
        circle(grommetRingOR + grommetWing, $fn=96);
        circle(grommetRingOR + 20, $fn=96);
        square([2000, grommetWingW+20],center=true);
    }
    // layer 2 cutout
    translate([0, 0, layer1H-1])
    linear_extrude(layer1H)
    difference() {
        circle(grommetRingOR + grommetWing, $fn=96);
        circle(grommetRingOR + 20, $fn=96);
        for(ii=[-90:180:90]) {
            rotate([0, 0, ii])
            translate([grommetWingW/2, 500, 0])
            square([grommetWingW*2+20, 500],center=true);
        }
    }

    // layer 3 no cutout
    translate([0, 0, layer1H*2-1])
    linear_extrude(layer1H+30)
    difference() {
        circle(grommetRingOR + grommetWing, $fn=96);
        circle(grommetRingOR + 20, $fn=96);
    }

    echo("translate is ",layer1H*3-1+30+50);
    translate([0, 0, layer1H*3-1+30])
    linear_extrude(50)
    difference() {
        circle(grommetRingOR + grommetWing, $fn=96);
        for(ii=[-700:200:700]) {
            translate([ii, 500, 0])
            square([100, 1500], center=true);
        }
    }
}

module forprinting()
{
    *grommet();

//    translate([0, 1200, ])
    color("PaleGreen")
    flapper();

    *translate([1400, 0, grommetHeight-fabricThickness])
    color("SkyBlue")
    rotate([180, 0, 0])
    grommetring();
    *translate([1400, 1600, 259])
    rotate([180, 0, ])
    color("cornflowerblue")
    cap();
}

module maskvalve()
{
    translate([0, 0, 130])
    color("PaleGreen")
    flapper();
    grommet();

    translate([0, 0, 80])
    color("SkyBlue")
    grommetring();
    *translate([0, 0, 50])
    rotate([0, 0, 90])
    color("cornflowerblue")
    cap();
}

scale(ViewScale)
{
    //maskvalve();
    forprinting();
}
