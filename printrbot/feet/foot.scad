ViewScale = [0.0254, 0.0254, 0.0254];

models=0;
draft=0;

module model_chassis(end=1)
{
    linear_extrude(1000) {
        // chassis sides
        square([65, 1000]);
        translate([65+3580, 0, 0])
        square([65, 1000]);

        if (end) {
            // chassis end
            translate([(3580-3000)/2+65, 1200, 0])
            square([3000, 65]);
        }

        // power supply
        translate([65+3580+65+250, 0, 0])
        square([3430, 1000]);
    }
}

module foot(end=1)
{
    linear_extrude(200)
    if (draft) {
        difference() {
            square([7840, 1475]);
            translate([300, 0, 0])
            square([3500, 1000]);

            translate([4300, 0, 0])
            square([3300, 1000]);
        }
    } else {
        square([7840, 1475]);
    }
    translate([0, 0, 199]) 
    linear_extrude(draft?200: 1000) {
        square([200, 1465]); // left end
        if (end) {
            translate([0, 1465-190, 0]) // back
            square([4140, 200]);
            translate([1000, 1465-190-300, 0]) // back
            square([2000, 200]);
        }
        translate([3940, 0, 0]) 
        square([200, 1465]); // left end

        translate([7790-150, 0, 0]) 
        square([200, 1475]); // right end
    }
    translate([0, 0, 199])
    linear_extrude(draft?200:1000) {
        translate([4140, 1275, 199])
        square([1000, 200]);
        translate([4140+3620-1000, 1275, 199])
        square([1000, 200]);
    }
}

module forViewing()
{
    if(models) translate([210, 0, 210]) color("cyan") model_chassis();
//    translate([-210, 0, 0])
    foot();
    translate([0, -1000, 0]) scale([1.0, -1.0, 1.0]) foot(0);
    translate([0, -3000, 0]) scale([1.0, -1.0, 1.0]) foot();

}

module forPrinting()
{
    foot();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
