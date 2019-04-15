ViewScale = [0.0254, 0.0254, 0.0254];

module barrel()
{
    difference() {
        circle(1110/2, $fn=96);
        circle(1010/2, $fn=96);
    }
}

module lensmount()
{
    translate([0, 0, 500])
    linear_extrude(100)
    difference() {
        square(2684, center=true);
        circle(1010/2, $fn=96);
        for(ii = [45:90:360]) {
            rotate([0, 0, ii])
            translate([1100, 0, 0])
            circle(300, $fn=96);
        }
    }
    linear_extrude(500)
    difference() {
        square(2684, center=true);
        square(2484, center=true);
    }

// 2584
}

scale(ViewScale)
{
//    translate([0, 0, 1000])
    lensmount();
    translate([0, 0, 599])
    linear_extrude(1000)
    barrel();
}
