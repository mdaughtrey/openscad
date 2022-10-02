ViewScale = [0.0254, 0.0254, 0.0254];

models=1;
handleRadius = 22040;

module template(outerR=handleRadius)
{
    innerR = 21566;
//    thickness=474;
    intersection() {
    circle(3500, $fn=96);
    difference() {
        union() {
            //translate([0, -outerR+770, 0])
            translate([0, -21270, 0])
            difference() {
                circle(outerR, $fn=96);
                circle(innerR, $fn=96);
            }
            //translate([-3199,-27,0])
            translate([-3199,-77,0])
            hull() {
                circle(500/2, $fn=96);
                translate([0, 250, 0])
                circle(500/2, $fn=96);
            }
            translate([0,-50,0])
            hull() {
                circle(500/2, $fn=96);
                translate([0, 550, 0])
                circle(500/2, $fn=96);
            }
        }
        translate([0,-50,0])
        hull() {
            circle(114/2, $fn=96);
            translate([0, 150, 0])
            circle(114/2, $fn=96);
        }
        translate([-3199,-77,0])
        hull() {
            circle(114/2, $fn=96);
            translate([0, 150, 0])
            circle(114/2, $fn=96);
        }
    }
    }
}

module model_handle()
{
    linear_extrude(630)
    template();
}

module handleMount()
{
    linear_extrude(100)
    template(handleRadius+200);
    translate([0, 0, 99])
    linear_extrude(631+131)
    intersection() {
        circle(3500, $fn=96);
        translate([0, -21270, 0])
        difference() {
            circle(handleRadius+200, $fn=96);
            circle(handleRadius, $fn=96);
        }
    }

    translate([0, 0, 630+130])
    linear_extrude(100)
    template(handleRadius+200);
}

module spoolMount()
{
    linear_extrude(200)
    difference() {
        circle(1500/2, $fn=96);
//        circle(500/2, $fn=96);
        translate([-1000, -1000, 0])
        square([2000, 1000]);
    }
    translate([0, 0, 199])
    linear_extrude(3001)
    difference() {
        circle(1000/2, $fn=96);
//        circle(500/2, $fn=96);
        translate([-1000, -1000, 0])
        square([2000, 1000]);
    }
    translate([0, 0, 3199])
    linear_extrude(101)
    difference() {
        circle(1500/2, $fn=96);
//        circle(500/2, $fn=96);
        translate([-1000, -1000, 0])
        square([2000, 1000]);
    }
}

module forViewing()
{
    //if (models) color("cornflowerblue") translate([0, 0, 115]) model_handle();
    //color("red")
    handleMount();
    translate([-3199/2, 500, 859])
    spoolMount();

    linear_extrude(860)
    difference() {
        translate([-3199/2, 500, 0])
        circle(1500/2, $fn=96);
        translate([0, -21270, 0])
        circle(handleRadius+220, $fn=96);
    }
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
