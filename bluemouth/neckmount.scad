ViewScale = [0.0254, 0.0254, 0.0254];

// Neck Circum = 19"
// Neck Radius = 6.05", round up to 7:
nextR = 7000;


module section()
{
    translate([-5000, -2500, 0])
    difference() {
        union() {
            rotate_extrude(angle = 60, convexity = 10, $fn=48)
            translate([7000, 0, 0])
            difference() {
                circle(510, $fn=96);
                circle(460, $fn=96);
            }

        }
        union() {
            rotate([0, 0, -60])
            translate([0, 7000, 0])
            rotate([-90, 0, 0])
            linear_extrude(1000)
            hull() {
                translate([-350, 0, 0])
                circle(250, $fn=96);
                translate([350, 0, 0])
                circle(250, $fn=96);
            }
        }
    }
//    #translate([7000, 40, 0])
//    rotate([90, 0, 0])
    linear_extrude(500)
    difference() {
        circle(450, $fn=96);
        circle(400, $fn=96);
    }
}


module neckmount()
{
    section();
}

scale(ViewScale)
{
    neckmount();
}
