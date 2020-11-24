ViewScale = [0.0254, 0.0254, 0.0254];
include <./assembly_mount_smaller.scad>

module model_pcb()
{
    // 4 x 5 5/8
    pcbw = 4000;
    pcbh = 5360;
    linear_extrude(40)
    difference() {
        square([pcbw, pcbh]);

        for(jj = [400,3600]) {
            for(ii = [520:1000:4800]) {
                translate([jj+170/2, ii+170/2, 0])
                circle(170/2, $fn=96);
            }
        }

        // Big circle
        translate([2000, 2950, 0])
        circle(650, $fn=96);

        // Top two holes
        // x=2000-750;
        // translate([x, pcbh-340, 0])
        // circle(170/2, $fn=96);
        // translate([4000-1150, 5360-370, 0])
        // circle(170/2, $fn=96);

        // Bottom two holes
        // translate([1020, 967, 0])
        // circle(170/2, $fn=96);
        // translate([4000-1020, 967, 0])
        // circle(170/2, $fn=96);
    }
}

module model_bracket()
{
//   900 x 8000
    linear_extrude(50)
    difference() {
        square([900, 8000]);
        for(ii = [0:500:7500]) {
            translate([100, ii+110, 0])
            square([180, 180]);
            translate([600, ii+110, 0])
            square([180, 180]);
        }

        for(ii = [0:500:7000]) {
            translate([350, 250+ii+110, 0])
            square([180, 180]);
        }
    }
}

module bracket()
{
    linear_extrude(100)
    difference() {
        hull() {
            translate([-500, 0, 0])
            circle(370/2, $fn=96);
            translate([500, 0, 0])
            circle(370/2, $fn=96);
        }

        translate([-500, 0, 0])
        circle(170/2, $fn=96);
        circle(170/2, $fn=96);
        translate([500, 0, 0])
        circle(170/2, $fn=96);
    }

    translate([310, -250, 0]) 
    linear_extrude(100)
    square([300, 200], center=true);

    translate([310, 0, 335/2]) {
        translate([0, 0, 0])
        rotate([90, 0, 0])
        translate([0, 0, 330])
        linear_extrude(200)
        difference() {
            square([300, 335], center=true);
            square([135, 135], center=true);
        }
    }
}

module test()
{
    bracket(0, 0);
    translate([0, 700, 0])
    bracket(0, 1);
    translate([0, 1400, 0])
    bracket(1, 0);
    translate([0, 2100, 0])
    bracket(1, 1);
}

module frameBracket() 
{
    linear_extrude(100)
    difference() {
        hull() {
            translate([-1500, 0, 0])
            circle(370/2, $fn=96);
            translate([1500, 0, 0])
            circle(370/2, $fn=96);
        }

        for(ii = [-1500:500:1500]) {
            translate([ii, 0, 0])
            circle(170/2, $fn=96);
        }
//         circle(170/2, $fn=96);
//         translate([500, 0, 0])
//         circle(170/2, $fn=96);
     }
     for(ii = [-1000, 1000]) {
        translate([ii, -250, 0]) 
        linear_extrude(100)
        square([300, 200], center=true);

        translate([ii, 0, 335/2]) {
            translate([0, 0, 0])
            rotate([90, 0, 0])
            translate([0, 0, 330])
            linear_extrude(200)
            difference() {
                square([300, 335], center=true);
                translate([0, 50, 0])
                square([135, 135], center=true);
            }
        }
     }
}

module frameBrackets()
{
//    translate([190, 2200, 40]) rotate([0, 0, -90]) bracket();
    translate([190, 3200, 40]) rotate([0, 0, -90]) frameBracket();
//     translate([190, 4200, 40]) rotate([0, 0, -90]) scale([-1, 1, 1]) bracket();
// 
//    translate([3890, 2200, 40]) rotate([0, 0, 90]) scale([-1, 1, 1]) bracket();
    translate([3890, 3200, 40]) rotate([0, 0, 90]) frameBracket();
//     translate([3890, 4200, 40]) rotate([0, 0, 90]) bracket();
}

module pcbBrackets() {
//    translate([440, 2230, 500]) rotate([0, 180, 90]) bracket();
    translate([440, 3230, 500]) rotate([0, 180, 90]) frameBracket();
//    translate([440, 4230, 500]) rotate([180, 0, 90]) scale([1, -1, 1]) bracket();

//    translate([3640, 2230, 500]) rotate([0, 180, -90]) scale([-1, 1, 1]) bracket();
    translate([3640, 3230, 500]) rotate([0, 180, -90]) scale([-1, 1, 1]) frameBracket();
//    translate([3640, 4230, 500]) rotate([0, 180, -90]) scale([1, 1, 1]) bracket();

}

module forViewing()
{
    color("cornflowerblue")
    translate([-50, 120, 500])
    model_pcb();
    model_bracket();
    translate([3600-400, 0, 0])
    model_bracket();
    color("SpringGreen")
    frameBrackets();

    color("BurlyWood")
    pcbBrackets();

    translate([2000-50, 2950+120, 950])
    rotate([0, 180, 0])
    aspheric_mount();
    translate([2000, 0, 0])
    *color("BurlyWood")
    frameBracket();


}

module forPrinting()
{
//    bracket();
//    translate([1500, 0, 0])
//    scale([-1, 1, 1])
//    bracket();
    frameBracket();
}

scale(ViewScale)
{
//    bracket();
//    forViewing();
    forPrinting();
}
