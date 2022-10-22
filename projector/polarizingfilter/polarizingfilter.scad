ViewScale = [0.0254, 0.0254, 0.0254];

models=1;
modelcolor = 1;

module section(o,t,x) {
    linear_extrude(x)
    difference() {
        circle(o/2, $fn=96);
        circle((o-t)/2, $fn=96);
    }
}

module model_filter()
{

    if (modelcolor) color("silver") {
        section(1180, 53, 286); // Body
        translate([0, 0, 178]) // Thread
        section(1092, 90, 142);
        translate([0, 0, 63])   // lens retainer
        section(1160, 100, 46);
    }
    if (modelcolor) color ("black")
    translate([0, 0, 140])   // lens 
    section(1070, 1070, 38);
}

module onetab() {
    difference() {
        hull() {
            circle(330/2, $fn=96);
            translate([330/2, 0, 0])
            square([330, 330], center=true);
        }
        circle(170/2, $fn=96);
    }
}

module bolttabs(space)
{
    linear_extrude(100) {
        translate([-space/2, 0, 0])
        onetab();
        translate([space/2, 0, 0])
        scale([-1.0, 1.0, 1.0])
        onetab();
    }
}

module halfclamp()
{
    linear_extrude(330)
    intersection() {
        difference() {
            circle(1300/2, $fn=96);
            circle(1200/2, $fn=96);
        }
        translate([0, -385, 0])
        square([1500, 1500/2], center=true);
    }
    translate([0, -10, 330/2])
    rotate([90, 0, 0])
    bolttabs(1900);

}


module forViewing()
{
    model_filter();
    translate([0, 0, 286])
    model_filter();
    halfclamp();
    scale([1.0, -1.0, 1.0])
    halfclamp();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
