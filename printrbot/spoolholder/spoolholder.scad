ViewScale = [0.0254, 0.0254, 0.0254];

models=1;
handleRadius = 22040;

module template(outerR=handleRadius)
{
    innerR = 21566;
//    thickness=474;
    intersection() {
    translate([-3500, -1000, 0])
    square([3800, 2000]);
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
        translate([-3500, -1000, 0])
        square([3800, 2000]);
        //circle(3500, $fn=96);
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
    module layer(d)
    {
        difference() {
            circle(d/2, $fn=96);
            circle(330/2, $fn=96);
            difference() {
//                translate([-1000, -1300, 0])
//                square([2000, 1000]);
                circle(330/2, $fn=96);
            }
        }
    }

    linear_extrude(200)
    layer(1500);
    *difference() {
        circle(1500/2, $fn=96);
        translate([-1000, -1000, 0])
        square([2000, 1000]);
    }
    *translate([0, 0, 199])
    linear_extrude(3001)
    layer(1000);
    *difference() {
        circle(1000/2, $fn=96);
        translate([-1000, -1000, 0])
        square([2000, 1000]);
    }
    *translate([0, 0, 3199])
    linear_extrude(101)
    layer(1500);
    *difference() {
        circle(1500/2, $fn=96);
        translate([-1000, -1000, 0])
        square([2000, 1000]);
    }
}

module brace()
{
//    linear_extrude(1500, scale=1.0)
//    square([1500, 530]);
    difference() {
        union() {
            translate([0, 100, 0])
            rotate([90, 0, 0])
            linear_extrude(200)
            polygon(points=[[0,0],[1500,0],[0,1500]]);
            linear_extrude(1500)
            circle(530/2, $fn=96);
        }
        translate([0, 0, -1])
        linear_extrude(1510)
        circle(330/2, $fn=96);
    }
}

module forViewing()
{
    //if (models) color("cornflowerblue") translate([0, 0, 115]) model_handle();
    //color("red")
    handleMount();
    translate([-3199/2, 1100, 859])
    spoolMount();

    linear_extrude(860)
    translate([0, 200, 0])
    difference() {
        translate([-3199/2, 900, 0])
        circle(1500/2, $fn=96);
        difference() {
            translate([0, -21270, 0])
            circle(handleRadius+0, $fn=96);
            translate([-3199/2, 900, 0])
            circle(530/2, $fn=96);
        }
        translate([-3199/2, 900, 0])
        circle(330/2, $fn=96);
    }
}

module forPrinting()
{
}

scale(ViewScale)
{
    brace();
//    spoolMount();
//    forViewing();
}
