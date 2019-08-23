ViewScale = [0.0254, 0.0254, 0.0254];
lensR = 1083/2;

module barrel()
{
    difference() {
        circle(1335/2, $fn=96);
        circle(1230/2, $fn=96);
    }
}

module mask()
{
    difference() {
        circle(1335/2, $fn=96);
        circle(425/2, $fn=96);
    }
}

module lensmount()
{
    difference() {
        circle(lensR+45, $fn=96);
        circle(lensR+10, $fn=96);
    }
}

scale(ViewScale)
{
    linear_extrude(30)
    mask();
    translate([0, 0, 29])
    linear_extrude(100)
    barrel();
    translate([0, 0, 29])
    linear_extrude(100)
    lensmount();
}
