ViewScale = [0.0254, 0.0254, 0.0254];

EYELETR=334/2;
EYELETCLEARANCE=20;

include <holecoords.scad>

module onekey()
{
    linear_extrude(50)
    difference() {
        circle(520/2, $fn=96);
        circle(200/2, $fn=96);
    }
    linear_extrude(150)
    circle(220/2, $fn=96);

    translate([0, 0, 50])
    linear_extrude(125)
    difference() {
    circle(EYELETR, $fn=96);
    circle(200/2, $fn=96);
    }
}

scale(ViewScale)
{
    for(ii = holecoords){
        translate([ii[0],ii[1],0])
        onekey();
    }
}
