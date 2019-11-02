ViewScale = [0.0254, 0.0254, 0.0254];

PLATETHICKNESS=30;
PLATELIFT=190;
PLATELIFT2=70;
PLATELIFT1=PLATELIFT-PLATELIFT2;
KEYCUTOUTR=230/2;
RINGTHICKNESS=51;
RINGHEIGHT=30;
EYELETR=275/2;
EYELETCLEARANCE=20;
HOLESHIFTY=90;
MAGNETR=325/2;
MAGNETH=80;

include <holecoords.scad>
magholes1=[ [-1900,2300.00], [1940,2300.00] ];

module magsupports()
{
    magholes2=[
    [-1000,400,0],
//    [500,400,0],
    [1800,400,0]
    
    ];
    for(ii = magholes2){
        translate([ii[0], ii[1], -MAGNETH])
        linear_extrude(MAGNETH+5)
        difference(){
            circle(MAGNETR, $fn=96);
            circle(MAGNETR-50, $fn=96);
        }
        translate([ii[0], ii[1], -PLATELIFT])
        linear_extrude(PLATELIFT)
        difference(){
            circle(MAGNETR+50, $fn=96);
            circle(MAGNETR, $fn=96);
        }
    }
}

module keyplate()
{
    linear_extrude(PLATETHICKNESS)
    difference() {
    translate([-2210, -20, 0])
    square([4420, 3010]);
    translate([0, HOLESHIFTY, 0])
    {
        for(ii = holecoords){
            translate([ii[0],ii[1],0])
            circle(KEYCUTOUTR, $fn=96);
        }
    }

    *translate([1399, 509, 0])
    circle(330/2, $fn=6);
    // pen keyplate
    //!translate([-1400, 165, 0])
    *translate([-1400, 520, 0])
    circle(330/2, $fn=96);
    // corner cutout
    translate([-1590, -20, 0])
    rotate([0, 0, 45+90])
    square([1200, 500]);
    }
}

module sides()
{
    // sides with corner cutout
    translate([0, 0, -PLATELIFT])
    linear_extrude(PLATELIFT) {
        // side
        translate([2110, 30, 0])
        square([100, 2920]);
        // side next to cutout
        translate([-2210, 600, 0])
        square([100, 2350]);
        // bottom
        translate([-2210+620, -20, 0])
        square([2210+1590, 150]);
        // corner cutout
        translate([-2210+620, -20, 0])
        rotate([0, 0, 135])
        translate([0, -100, 0])
        square([877, 100]);
        // top
        translate([-2210, 2890, 0])
        square([2210+2210, 100]);
    }
    // either side of tab
    *translate([760, -20, -PLATELIFT-180])
    linear_extrude(PLATELIFT+80)
    square([1450, 50]);

    *translate([-1585, -20, -PLATELIFT-140])
    linear_extrude(PLATELIFT+80)
    square([3795, 50]);

}

module tab()
{
    //bottom tab
    *translate([-800, -20, -PLATELIFT-80])
    linear_extrude(80)
    square([1600, 100-70+50]);

    *translate([-810, -20, -PLATELIFT-140])
    linear_extrude(50)
    square([1620, 200]);
}

module supports()
{
    // supports
    translate([0, 70, -PLATELIFT])
    linear_extrude(PLATELIFT) {
        // top letters
        for(ii = [-2000:400:2000]){
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
        for(ii = [-610:400:1810]){
            translate([ii, 2340, 0])
            circle(50, $fn=96);
        }
        // between letters and mod keys
        for(ii = [-1800:400:1800]){
            translate([ii, 940, 0])
            circle(50, $fn=96);
        }
        // mod keys 1
        for(ii = [780:400:1820]){
            translate([ii, 630, 0])
            circle(50, $fn=96);
        }
        // mod keys 2
        for(ii = [-1600:400:-600]){
            translate([ii, 630, 0])
            circle(50, $fn=96);
        }
        // dirkeys 
        translate([-1800,2300, 0])
        circle(50, $fn=96);
        translate([-1200,2400, 0])
        circle(50, $fn=96);

        // space keys
        translate([0,630, 0])
        circle(50, $fn=96);
        translate([300,500, 0])
        circle(50, $fn=96);
        translate([-300,500, 0])
        circle(50, $fn=96);
    }

}

module rings()
{
    for(ii = holecoords){
        //translate([ii[0], ii[1]+HOLESHIFTY, -RINGHEIGHT-5])
        translate([ii[0], ii[1]+HOLESHIFTY, -RINGHEIGHT])
        linear_extrude(RINGHEIGHT+5)
        difference(){
            circle(KEYCUTOUTR+RINGTHICKNESS, $fn=96);
            circle(KEYCUTOUTR, $fn=96);
        }
    }
    // pen support
    translate([-1400, 520, -PLATELIFT-350])
    linear_extrude(PLATELIFT+350)
    difference() {
        circle(346/2-10, $fn=96);
        circle(246/2, $fn=96);
    }
    // pencil support
    translate([1399, 509, -PLATELIFT-350])
    linear_extrude(PLATELIFT+350)
    difference() {
        circle(360/2-10, $fn=6);
        circle(260/2, $fn=6);
    }
    // magnet holes
    for(ii = magholes1){
        translate([ii[0], ii[1], -MAGNETH])
        linear_extrude(MAGNETH+5)
        difference(){
            circle(MAGNETR, $fn=96);
            circle(MAGNETR-50, $fn=96);
        }
    }

    magsupports();
}

module supports1()
{
    difference() {
        union() {
            translate([-1960-100, 680, 0])
            square([3920+200, 2080]);
            translate([-800, 200, 0])
            square([1600, 500]);
        }
        translate([0, HOLESHIFTY, 0])
        {
            for(ii = holecoords){
                translate([ii[0],ii[1],0])
                circle(EYELETR+EYELETCLEARANCE, $fn=96);
            }
        }

        translate([1399, 509, 0])
        circle(330/2, $fn=6);
        // pen keyplate
        //!translate([-1400, 165, 0])
        *translate([-1400, 520, 0])
        circle(330/2, $fn=96);
        // corner cutout
        *translate([-1590, 30, 0])
        rotate([0, 0, 135])
        square([1000, 500]);

        // Magnet holes
        for(ii = magholes1){
            translate([ii[0],ii[1],0])
            circle(MAGNETR, $fn=96);
        }
    }
}

module supports2()
{
    difference() {
        supports1();
        translate([0, 660, 0])
        square([1200,180], center=true);

        translate([0, 1070, 0])
        square([3800,140], center=true);
        translate([0, 1740, 0])
        square([3800,100], center=true);
        translate([600, 2460, 0])
        square([2700,100], center=true);

    
        translate([-1200, 2460, 0])
        rotate([0, 0, 45])
        union() {
            square([600,100], center=true);
            square([100,600], center=true);
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

color("Green")
scale(ViewScale)
{
    keyplate();
    sides();
    tab();

    translate([0, 0, -PLATELIFT1])
    linear_extrude(PLATELIFT1) 
    supports1();

    translate([0, 0, -PLATELIFT2-PLATELIFT1+1])
    linear_extrude(PLATELIFT2) 
    supports2();

    rings();
}
