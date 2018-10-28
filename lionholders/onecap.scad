ViewScale = [0.0254, 0.0254, 0.0254];

module oneCap(count)
{
    space = 790;
    for (ii = [0: space: space * count - 1])
    {
        translate([ii, 0, 0]) {
            linear_extrude(200)
            difference() {
            circle(830/2, $fn=96);
            circle(740/2, $fn=96);
            }

            translate([0, 0, 200])
            linear_extrude(100)
            difference() {
            circle(830/2, $fn=96);
            circle(530/2, $fn=96);
    }}}

}

//scale(ViewScale)
//{
//    oneCap(3);
//    translate([400, 700, 0])
//    oneCap(2);
//}
