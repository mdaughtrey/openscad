module model_laser_case_large()
{
    linear_extrude(20)
    difference() {
        circle(467/2, $fn=96);
        circle(136/2, $fn=96);
    }
    translate([0, 0, 19])
    linear_extrude(867)
    difference() {
        circle(467/2, $fn=96);
        circle(448/2, $fn=96);
    }

}

module model_laser_case_small()
{
    linear_extrude(130)
    difference() {
        circle(420/2, $fn=96);
        circle(185/2, $fn=96);
    }
    translate([0, 0, 129])
    linear_extrude(436)
    difference() {
        circle(467/2, $fn=96);
        circle(337/2, $fn=96);
    }
}

module laser_lens_insert()
{
    linear_extrude(255)
    circle(348/2, $fn=96);
}

module model_laser_case()
{
    *model_laser_case_large();
    translate([0, 0, 887])
    model_laser_case_small();
}
