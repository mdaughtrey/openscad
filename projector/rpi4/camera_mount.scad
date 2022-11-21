ViewScale = [0.0254, 0.0254, 0.0254];

module model_hqcam()
{
    difference() {
        circle(1210/2, $fn=96);
        circle(1060/2, $fn=96);
        //circle(1160/2, $fn=96);
        for (ii=[0:12.8:340]) {
            rotate([0, 0, ii])
            translate([1280/2, 0, 0])
            circle(60, $fn=96);
        }
    }
}

module mount0()
{
    linear_extrude(200) {
        difference() {
          circle(1490/2, $fn=96);
          circle(1230/2, $fn=96);
        }
        for (ii=[0:12.86:360]) {
            rotate([0, 0, ii])
            translate([1260/2, 0, 0])
            circle(40, $fn=96);
        }
    }
    translate([0, 0, 199])
    linear_extrude(400)
    difference() {
        circle(1625/2, $fn=96);
        circle(1425/2, $fn=96);
        translate([0, 450, 0])
        square([1700, 900], center=true);
    }

    translate([0, 0, 350])
    rotate([90, 0, 0])
    linear_extrude(200)
    for( ii = [-180,0]) {
        rotate([0, ii, 0])
        translate([950, 0, 0]) 
        difference() {
            square([400, 300], center=true);
            circle(130/2, $fn=96);
        }
    }
}

module mount1()
{
    *linear_extrude(200) {
        difference() {
          circle(1500/2, $fn=96);
          circle(1230/2, $fn=96);
        }
        for (ii=[0:12.86:360]) {
            rotate([0, 0, ii])
            translate([1260/2, 0, 0])
            circle(40, $fn=96);
        }
    }
    translate([0, 0, 199])
    linear_extrude(400)
    difference() {
        union() {
            circle(1625/2, $fn=96);
            translate([0, 750, 0])
            square([700, 500], center=true);
        }
        circle(1425/2, $fn=96);
        translate([0, -380, 0])
        square([1700, 900], center=true);

        translate([0, 1425/2-250+200, 0])
        square([450, 500], center=true);

    }

    *translate([0, -90, 200])
    square([3390, 280], center=true);

    translate([0, 270, 350])
    rotate([90, 0, 0])
    linear_extrude(200)
    for(ii = [0, 180]) {
        rotate([0, 0, ii])
        translate([950+510/2, 0, 0])
        difference() {
            square([990, 300], center=true);
            translate([-255, 0, 0])
            circle(170/2, $fn=96);
        }
    }
    *translate([-3390/2-100, -20, 200])
    linear_extrude(300)
    square([200, 540], center=true);

    // side bits
    translate([3390/2+100, -50+200, -270])
    linear_extrude(770)
    square([200, 200], center=true);

    // long side bit
    translate([3390/2+35, -50+200, 0])
    linear_extrude(200)
    square([100, 800], center=true);

    // 240 + 40 + 200 
    translate([-3390/2-90, -50+200, -270])
    linear_extrude(770)
    square([200, 200], center=true);

    // long side bit
    translate([-3390/2-35, -50+200, 0])
    linear_extrude(200)
    square([100, 800], center=true);

    //translate([-3390/2-100, -50+200, 200])
    //linear_extrude(300+240+40+200)
    //square([200, 200], center=true);

    // wraparound bits
    translate([3390/2, 240-100+10, -270])
    linear_extrude(200)
    square([400, 200], center=true);

    translate([-3390/2+200, 240-100+10, -270])
    linear_extrude(200)
    square([400, 200], center=true);
}


module model_mountto()
{
    linear_extrude(240)
    difference() {
        square([3350, 3350], center=true);
       // circle(1660/2, $fn=96);
        circle(1500/2, $fn=96);
    }
}

module forViewing()
{
 //   model_hqcam();
 color("green")
 translate([0, 0, -50])
 model_mountto();
    color("cyan")
    mount0();
    mount1();
}

module forPrinting()
{
    mount1();
}

scale(ViewScale)
{
    forViewing();
   // forPrinting();
}
