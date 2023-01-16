ViewScale = [0.0254, 0.0254, 0.0254];
include <../libs/MCAD/2Dshapes.scad>

models=0;
//w=3100; // model width
w=3140; // model width
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

module mount()
{
    a=(w/2)-(cw/2)+180;
    b=a-170;
    linear_extrude(500) {
        translate([0, 100, 0])
        square([2000, 200], center=true);
        for (ii=[1.0,-1.0]) {
            scale([ii, 1.0])
            translate([cw/2, 0, 0])
            {
                square([a, 200]);
                translate([a-150, 199, 0])
                square([150, 471]);
                translate([a-150-471, 200, 0])
                intersection() {
                    translate([200, 0, 0])
                    square([300, 500]);
                    difference() {
                        square([471, 471]);
                        circle(471, $fn=96);
                    }
                }
            }
        }
   }
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
        translate([0, 0, 220])
        model_tabletmount();
    }
    rotate([90, 0, 0])
    mount();
}

module forPrinting()
{
    intersection() {
    mount();
    translate([0, 0, -1])
    linear_extrude(800)
    square([4000, 500], center=true);
    }
}

scale(ViewScale)
{
    forViewing();
//    forPrinting();
}
