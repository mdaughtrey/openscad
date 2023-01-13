ViewScale = [0.0254, 0.0254, 0.0254];
include <../libs/MCAD/2Dshapes.scad>

models=0;
w=3140;
h=4730;
c=175;
o=320;

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
    mount();
}

module forPrinting()
{
    difference() {
    mount();
    translate([0, 2000, -1])
    linear_extrude(800)
    square([4000, 4000], center=true);
    }
}

scale(ViewScale)
{
    //forViewing();
    forPrinting();
}
