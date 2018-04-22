ViewScale = [0.0254, 0.0254, 0.0254];

module overlens1()
{
    // curve over lens
    rotate([0, 0, 60])
    intersection() {
        rotate_extrude(angle=60, convexity=2, $fn=96)
        translate([1668, 0, 0])
        square([30, 180]);
        linear_extrude(180)
        polygon(points=[[0,0],[2400,0],[2400,4160]]);
    }
}

module overlens2()
{
    // curve over lens
 //   rotate([0, 0, 75])
    intersection() {
        rotate_extrude(angle=30, convexity=2, $fn=96)
        translate([666, 0, 0])
        square([30, 180]);
        linear_extrude(180)
        polygon(points=[[0,0],[2400,0],[2400,4160]]);
    }
}

module bridge()
{
    // curve over lens
  //  rotate([0, 0, 75])
    intersection() {
        rotate_extrude(angle=30, convexity=2, $fn=96)
        translate([655, 0, 0])
        square([30, 180]);
        linear_extrude(180)
        polygon(points=[[0,0],[2400,0],[2400,4160]]);
    }
}
module halfcrosspiece()
{
    overlens1();
    overlens2();
    translate([1000, 0, 0])
    bridge();
}

scale(ViewScale)
{
    halfcrosspiece();
}
