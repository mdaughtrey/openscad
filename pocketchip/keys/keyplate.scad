ViewScale = [0.0254, 0.0254, 0.0254];

PLATETHICKNESS=30;
PLATELIFT=120;
KEYCUTOUTR=210/2;
RINGTHICKNESS=20;
RINGHEIGHT=80;

include <holecoords.scad>

// 2610+275=2885
// 2990-2885=110
module keyplate()
{
    linear_extrude(PLATETHICKNESS)
    difference() {
    translate([-2210, -40, 0])
    square([4420, 2920+70]);
    translate([0, 70, 0])
    {
        for(ii = holecoords){
            translate([ii[0],ii[1],0])
            circle(KEYCUTOUTR, $fn=96);
        }
    }
// space bar
//hull() {
//    translate([300.00,780.00,0])
//    circle(KEYCUTOUTR, $fn=96);
//    translate([-300.00,780.00,0])
//    circle(KEYCUTOUTR, $fn=96);
//}
// pencil keyplate
    translate([1399, 439+70, 0])
    circle(330/2, $fn=6);
    // pen keyplate
    //!translate([-1400, 165, 0])
    translate([-1400, 450+70, 0])
    circle(330/2, $fn=96);
    // corner cutout
    translate([-1590, -40, 0])
    rotate([0, 0, 45+90])
    square([1000, 500]);
    }
}

module sides()
{
    // sides with corner cutout
    translate([0, 0, -PLATELIFT])
    linear_extrude(PLATELIFT) {
        translate([2110, -40, 0])
        square([100, 2920+70]);
        translate([-2210, 580, 0])
        square([100, 2300+70]);
        translate([-2210+620, -40, 0])
        square([2210+1590, 100]);
        translate([-2210+620, -40, 0])
        rotate([0, 0, 135])
        translate([0, -100, 0])
        square([877, 100]);
    }
}

module tab()
{
    //bottom tab
    translate([-800, -40, -PLATELIFT-80])
    linear_extrude(80)
    square([1600, 100]);

    translate([-800, -40, -PLATELIFT-180])
    linear_extrude(100)
    square([1600, 250]);
}

module supports()
{
    // supports
    translate([0, 70, -PLATELIFT])
    linear_extrude(PLATELIFT) {
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

module rings()
{
    for(ii = holecoords){
        translate([ii[0], ii[1]+70, -RINGHEIGHT])
        linear_extrude(RINGHEIGHT)
        difference(){
            circle(KEYCUTOUTR+RINGTHICKNESS, $fn=96);
            circle(KEYCUTOUTR, $fn=96);
        }
    }
}

module test()
{
    arr=[[1,2,3],[4,5,6]];
    for(ii = arr){
        echo(ii[1]);
    }
}

scale(ViewScale)
{
    keyplate();
    sides();
    tab();
    supports();
    rings();
}
