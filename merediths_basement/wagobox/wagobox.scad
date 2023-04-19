ViewScale = [0.0254, 0.0254, 0.0254];
$fn=96;

cells = [3,5,3];
models=1;
basethick=150;
wallthick=100;

function cumsum(v) = [for (a=0, ii=0; ii<len(v); a=a+v[ii], ii=ii+1) a];
function sum(v) = [for(p=v) 1]*v;

module wagoX(n)
{
    w=235;
    module wago1()
    {
        linear_extrude(23)
        square([235, 710]);

        translate([0, 0, 22])
        linear_extrude(184)
        square([47, 710]);

        translate([0, 0, 184])
        linear_extrude(132)
        square([235, 710]);
    }
    n = n -1;
    for (ii=[0:w:w*n]) {
        translate([ii, 0, 0])
        wago1();
    }
    translate([w*(n+1), 0, 0])
    linear_extrude(316)
    square([47,710]);
}

module screw_No8_5_8()
{
    linear_extrude(height=100, slices=10, scale=0.5)
    circle(300/2);
    translate([0, 0, 99])
    linear_extrude(500)
    circle(150/2);
}


module wagobox(cells)
{

    numcells=cumsum(cells);
    echo("numcells ",numcells);

    if (models) {
        for (ii=[0:len(numcells)-1]) {
            color("cornflowerblue")
            translate([wallthick+235*numcells[ii]+ii*50, wallthick, basethick])
            wagoX(cells[ii]);
        }
    }
    squareX = (wallthick*2)+(sum(cells)*235)+(len(cells)*47);
    squareY = 910;
    difference() {
        linear_extrude(basethick)
        difference() {
            square([squareX, squareY]);
            translate([squareX/2, squareY/2, 0])
            circle(180/2);
        }
        translate([squareX/2, squareY/2, 151])
        rotate([180, 0, 0])
        linear_extrude(height=130, slices=10, scale=0.5)
        circle(330/2);

    }

    // Lower sides and back
    translate([0, 0, basethick-1])
    linear_extrude(31)
    difference() {
        square([squareX, squareY]);
        translate([wallthick, wallthick-20, 0])
        square([squareX-wallthick*2, squareY-wallthick*2+20]);
    }

    // Upper sides and back
    translate([0, 0, basethick+29])
    linear_extrude(326-20)
    difference() {
        square([squareX, squareY]);
        translate([wallthick, -wallthick, 0])
        square([squareX-wallthick*2, squareY]);
    }

    // Top lip
    translate([0, squareY-300, basethick+335])
    linear_extrude(100)
    square([squareX, 300]);

    // Side tabs
    translate([-99, 710, 0])
    linear_extrude(basethick+435)
    square([100, 200]);

    translate([squareX-1, 710, 0])
    linear_extrude(basethick+435)
    square([100, 200]);

}

module lid(cells)
{
    squareX = (wallthick*2)+(sum(cells)*235)+(len(cells)*47);
    squareY = 910;

    module footprint(xadd, yadd)
    {
        translate([-xadd/2, -yadd/2, 0])
        square([squareX+xadd, squareY+yadd]);
        translate([-99-xadd/2, 710-yadd/2, 0])
        square([100, 200+yadd]);

        translate([squareX-1+xadd/2, 710-yadd/2, 0])
        square([100, 200+yadd]);
    }
    linear_extrude(170+50)
    difference() {
        footprint(120, 120);
        footprint(20, 20);
    }

    translate([-30, 100, 120])
    linear_extrude(100)
    square([squareX+40, 100]);

    translate([0, 0, 169+50])
    linear_extrude(50)
    footprint(120, 120);
}
    
module forViewing()
{
    //translate([-100, -100, 0])
    wagobox(cells);
    translate([0, 0, basethick+280-50])
    color("wheat")
    lid(cells);
}

module forPrinting()
{
//    wagobox(cells);
    lid(cells);
}

scale(ViewScale)
{
    forViewing();
//    forPrinting();
}
