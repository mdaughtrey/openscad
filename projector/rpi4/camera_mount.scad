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
        circle(1625/2, $fn=96);
        circle(1425/2, $fn=96);
        translate([0, 450, 0])
        square([1700, 900], center=true);
    }
    translate([0, 0, 350])
    rotate([90, 0, 0])
    linear_extrude(200)
    for(ii = [-950, 950]) {
        translate([ii, 0, 0])
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
        circle(1625/2, $fn=96);
        circle(1425/2, $fn=96);
        translate([0, -400, 0])
        square([1700, 900], center=true);
    }
    translate([0, 250, 350])
    rotate([90, 0, 0])
    linear_extrude(200)
    for(ii = [-950, 950]) {
        translate([ii, 0, 0])
        difference() {
            square([400, 300], center=true);
            circle(150/2, $fn=96);
        }
    }
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
// model_mountto();
//    color("cyan")
//    mount0();
    mount1();
}

scale(ViewScale)
{
    forViewing();
}
