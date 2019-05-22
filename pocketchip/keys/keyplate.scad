ViewScale = [0.0254, 0.0254, 0.0254];


// 2610+275=2885
// 2990-2885=110
module keyplate()
{
    linear_extrude(100)
    difference() {
    translate([-2210, -40, 0])
    square([4420, 2920]);
include <cutouts.scad>
// pencil keyplate
    translate([1399, 439, 0])
    circle(330/2, $fn=6);
    // pen keyplate
    translate([-1400, 450, 0])
    circle(330/2, $fn=96);
    // corner cutout
    translate([-1590, -40, 0])
    rotate([0, 0, 45+90])
    square([1000, 500]);
    }


    // sides
    *translate([-2210, -40, -120])
    linear_extrude(120)
    difference() {
        square([4420, 2920]);
        translate([100, 100, 0])
        square([4220, 2820]);
    }

    // sides with corner cutout
    translate([0, 0, -120])
    linear_extrude(120) {
        translate([2110, -40, 0])
        square([100, 2920]);
        translate([-2210, 580, 0])
        square([100, 2300]);
        translate([-2210+620, -40, 0])
        square([2210+1590, 100]);
        translate([-2210+620, -40, 0])
        rotate([0, 0, 135])
        translate([0, -100, 0])
        square([877, 100]);
    }

    //bottom tab
    translate([-800, -40, -200])
    linear_extrude(80)
    square([1600, 100]);

    translate([-800, -40, -300])
    linear_extrude(100)
    square([1600, 250]);
    // supports
    translate([0, 0, -100])
    linear_extrude(120) {
        // top letters
        for(ii = [-800:400:2000]){
            translate([ii, 1980, 0])
            circle(50, $fn=96);
        }
        // middle letters
        for(ii = [-1800:400:2000]){
            translate([ii, 1590, 0])
            circle(50, $fn=96);
        }
        // bottom letters
        for(ii = [-2000:400:2000]){
            translate([ii, 1260, 0])
            circle(50, $fn=96);
        }
        // top numbers
        for(ii = [-800:400:2000]){
            translate([ii, 2730, 0])
            circle(50, $fn=96);
        }
        // middle numbers
        for(ii = [-400:400:2000]){
            translate([ii, 2430, 0])
            circle(50, $fn=96);
        }
        // between letters and mod keys
        for(ii = [-2000:400:2000]){
            translate([ii, 1040, 0])
            circle(50, $fn=96);
        }
        // mod keys 1
        for(ii = [600:400:1600]){
            translate([ii, 700, 0])
            circle(50, $fn=96);
        }
        // mod keys 2
        for(ii = [-1800:400:-400]){
            translate([ii, 700, 0])
            circle(50, $fn=96);
        }
        // dirkey 
        translate([-1800,2300, 0])
        circle(50, $fn=96);
    }


}

scale(ViewScale)
{
    keyplate();
}
