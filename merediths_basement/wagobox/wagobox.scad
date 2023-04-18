ViewScale = [0.0254, 0.0254, 0.0254];
$fn=96;

models=0;

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
    basethick=150;
    wallthick=100;

    function cumsum(v) = [for (a=0, ii=0; ii<len(v); a=a+v[ii], ii=ii+1) a];
    function sum(v) = [for(p=v) 1]*v;
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
    difference() {
        linear_extrude(basethick)
        difference() {
            square([squareX, 910]);
            translate([squareX/2, 910/2, 0])
            circle(180/2);
        }
        translate([squareX/2, 910/2, 151])
        rotate([180, 0, 0])
        linear_extrude(height=130, slices=10, scale=0.5)
        circle(330/2);

    }

    translate([0, 0, basethick-1])
    linear_extrude(31)
    difference() {
        square([squareX, 910]);
        translate([wallthick, wallthick-20, 0])
        square([squareX-wallthick*2, 910-wallthick*2+20]);
    }

    translate([0, 0, basethick+29])
    linear_extrude(326-20)
    difference() {
        square([squareX, 910]);
        translate([wallthick, -wallthick, 0])
        square([squareX-wallthick*2, 910]);
    }

    translate([0, 910-300, basethick+29+326-20])
    linear_extrude(100)
    square([squareX, 300]);
}
    
module forViewing()
{
//    screw_No8_5_8();
    *translate([0, 0, 100])
    // Gnd
    *color("cornflowerblue") {
    wagoX(5);
    // 12v
    translate([1250, 0, 0])
    wagoX(3);
    // 5v
    translate([2030, 0, 0])
    wagoX(3);
    // WS2812 data
    translate([2820, 0, 0])
    wagoX(3);
    }
    translate([-100, -100, 0])
    wagobox([3]);
}

module forPrinting()
{
    wagobox();
}

scale(ViewScale)
{
    forViewing();
    //forPrinting();
}
