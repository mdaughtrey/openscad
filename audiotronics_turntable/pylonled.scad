ViewScale = [0.0254, 0.0254, 0.0254];
include <../models/model_ws2812strip.scad>

modelcolor=1;
models=0;

module ledstripcover(numleds = 1)
{

    for(ii=[0:1:numleds-1]) {
        translate([ii*410,0,0]) {
            // Square cutout
            translate([0, 0, 40])
            linear_extrude(21)
            difference() {
                square([410, 473]);
                translate([(410-210)/2, 95])
                square([210, 210]);
            }

            // Circle cutout
            translate([0, 0, 60])
            linear_extrude(20)
            difference() {
                square([410, 473]);
                translate([410/2, 200, 0])
                circle(195/2, $fn=96);
            }

            // Sides
            translate([0, 0, 0])
            linear_extrude(41)
            difference() {
                square([410, 473]);
                translate([(410-450)/2, (473-373)/2])
                square([450, 373]);
            }
        }
    }
}

module pylonmount()
{
    ledstripcover(1);
    translate([410/2, 200, 40])
    linear_extrude(100)
    difference() {
        circle(520/2, $fn=96);
        circle(420/2, $fn=96);
    }
}

module forViewing()
{
    if (models) {
        model_ws2812strip(1);
    }
    pylonmount();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
