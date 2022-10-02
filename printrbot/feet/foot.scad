ViewScale = [0.0254, 0.0254, 0.0254];

models=1;
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
//        translate([65+3580+65+250, 0, 0])
//        square([3430, 1000]);
    }
}

module model_powersupply()
{
    // chassis
    linear_extrude(5875)
    square([3340, 5500]);

    // Cables
    translate([2050, 5500+2000, 80+600])
    rotate([90, 0, 0])
    linear_extrude(2000)
    circle(1200/2, $fn=96);

    // 120v Socket
    translate([1420, 0, 450])
    rotate([90, 0, 0])
    linear_extrude(2000)
    square([940, 1850]);
}

module foot(end=1, lift=0)
{
    linear_extrude(200)
    if (draft) {
        difference() {
            square([7760, 1475]);
            translate([300, 0, 0])
            square([3500, 1000]);

            translate([4300, 0, 0])
            square([3300, 1000]);
        }
    } else {
        square([7740, 1475]);
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

        translate([7790-250, 0, 0]) 
        square([200, 1475]); // right end
    }
    translate([0, 0, 199])
    linear_extrude(draft?200:1000) {
        translate([3940, 1275, 199])
        square([1300, 200]);
        translate([4140+3620-620, 1275, 199])
        square([500, 200]);
    }
    if (lift >0) {
        translate([4940, 1275, 199])
        linear_extrude(lift)
        square([2300, 200]);

    }
}

module cap()
{
    outerD=2430;
    innerD=1200;
    module caplayer() {
        intersection() {
            difference() {
                circle(outerD/2, $fn=96);
                circle(innerD/2, $fn=96);
            }
            translate([-2000, 0, 0])
            square([4000, 2000]);
        }
    }
    leglength=700;
    linear_extrude(100) {
        caplayer();
        translate([innerD/2, -leglength, 0]) square([(outerD-innerD)/2, leglength]);
        translate([-outerD/2, -leglength, 0]) square([(outerD-innerD)/2, leglength]);
    }
    translate([0, 0, 99])
    linear_extrude(230) {
        intersection() {
            union() {
                caplayer();
                translate([(-innerD/2)-370, -leglength, 0])
                square([370, leglength]);
                translate([innerD/2, -leglength, 0])
                square([370, leglength]);
            }
            translate([-1900/2, -1000, 0])
            square([1860, 2000]);
        }
    }
    translate([0, 0, 329])
    linear_extrude(100) {
        caplayer();
        translate([innerD/2, -leglength, 0]) square([(outerD-innerD)/2, leglength]);
        translate([-outerD/2, -leglength, 0]) square([(outerD-innerD)/2, leglength]);
    }

}

module forViewing()
{
    if(models) translate([210, 0, 210]) color("cyan") {
        model_chassis();
        translate([3960, -4400, 0])
        model_powersupply();
    }
    color("green")
    translate([5675+540, 1475+110, 900])
    rotate([90, 0, 0])
    cap();

//    translate([-210, 0, 0])
    foot();
    translate([0, -3200, 0]) scale([1.0, -1.0, 1.0]) foot(end=0, lift=400);
    translate([0, -6500, 0]) scale([1.0, -1.0, 1.0]) foot(end=1, lift=1000);
}

module forPrinting()
{
    //foot();
//    scale([1.0, -1.0, 1.0]) foot(end=0, lift=400);
cap();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
