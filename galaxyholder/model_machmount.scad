ViewScale = [0.0254, 0.0254, 0.0254];
include <../libs/MCAD/2Dshapes.scad>

models=0;
//w=3100; // model width
w=3150; // model width
h=4730; // model height 
c=175;  // mounting hole diameter
o=320;  // mounting hole center offset from edges
cw=1410; // cutout width
ch=2690; // cutout height

module model_tabletmount()
{
    linear_extrude(50) {
        difference() {
            roundedSquare([w, h], 200);
            for (ww=[-1,1]) {
                for (hh=[-1,1]) {
                    translate([ww*(w/2-o), hh*(h/2-o), 0])
                    circle(c/2, $fn=96);
                }
            }
            square([1410, 2690], center=true);
        }
    }
    translate([0, 0, 49])
    linear_extrude(360) {
        difference() {
            roundedSquare([w, h], 200);
            roundedSquare([w-100, h-100], 140);
        }
    }
}

module mounthalf()
{
    a=(w/2)-(cw/2)+180;
    b=a-170;
    //r=471;
    r=500;
//    for (ii=[1.0,-1.0]) {
//        scale([ii, 1.0])
        translate([cw/2, 0, 0])
        {
            square([a, 350]);
            translate([a-150, 349, 0])
            square([150, r]);
            translate([a-150-r, 350, 0])
            intersection() {
                translate([200, 0, 0])
                square([300, 500]);
                difference() {
                    square([r, r]);
                    circle(r, $fn=96);
                }
            }
        }
//    }
}

module mountbottomhalf()
{
    a=(w/2)-(cw/2)+180;
    b=a-170;
//    for (ii=[1.0,-1.0]) {
//        scale([ii, 1.0])
        translate([cw/2, 0, 0])
        {
            square([a, 350]);
            translate([a-150, 349, 0])
            square([150, 571]);
            translate([a-450, 350+571-130, 0])
            square([450, 200]);
        }
//    }
}

module crossmount()
{
    a=(w/2)-(cw/2)+180;
    b=a-170;
    linear_extrude(500) {
        for (ii=[1.0,-1.0]) {
            scale([ii, 1.0])
            mounthalf();
        }
        translate([0, 170, 0])
        square([2000, 340], center=true);
   }
}

module lowermount()
{
    crossmount();
    translate([250, 0, -600])
    rotate([0, -90, 0])
    linear_extrude(500)
    mountbottomhalf();
}

module mount0()
{
    linear_extrude(200)
    difference() {
        roundedSquare([w+440, h+440], 200);
        square([1410, 2690], center=true);
    } 

    translate([0, 0, 199])
    linear_extrude(471) {
        difference() {
            roundedSquare([w+440, h+440], 200);
            roundedSquare([w+100, h+100], 140);
            translate([0, h/2, 0])
            square([w*2, h/4], center=true);
        }
    }

    translate([0, 0, 669])
    linear_extrude(100) {
        difference() {
            roundedSquare([w+440, h+440], 200);
            roundedSquare([w-300, h-300], 140);
            translate([0, h/2, 0])
            square([w*2, h/4], center=true);
        }
    }

}


module forViewing()
{
    if (models) {
        color("cornflowerblue")
        translate([0, 0, 370])
        model_tabletmount();
    }
    intersection() {
        translate([-2500, -800, 17323])
        rotate([0, 90, 0])
        linear_extrude(5000)
        circle(17323, $fn=96);
        union() {
            *translate([0, -1400, 0])
            rotate([90, 0, 0])
            lowermount();
            translate([0, 600, 0])
            rotate([90, 0, 0])
            crossmount();
        }
    }
}


module forPrinting()
{
    //crossmount();
    lowermount();
}

scale(ViewScale)
{
    forViewing();
//    forPrinting();
}
