ViewScale = [0.0254, 0.0254, 0.0254];

module key()
{
    linear_extrude(150)
    circle(280/2, $fn=96);
    translate([0, 0, 149])
    linear_extrude(50) {
    circle(270/2, $fn=96);
    intersection() {
        difference(){
            circle(320/2, $fn=96);
            circle(260/2, $fn=96);
        }
        union() {
            square([100, 400], center=true);
            square([400, 100], center=true);
        }
    }
    }

    translate([0, 0, 199])
    linear_extrude(30)
    circle(100/2, $fn=96);
}

module keys()
{
    for(ii = [0:500:4000]) {
        for(jj = [0:500:2500]) {
            translate([ii,jj,0])
                key();
        }
    }
}

module spacekey()
{
    linear_extrude(150)
    hull() {
        circle(270/2, $fn=96);
        translate([280,0,0])
        circle(270/2, $fn=96);
    }
    translate([0, 0, 149])
    linear_extrude(50)
    hull() {
        circle(320/2, $fn=96);
        translate([300,0,0])
        circle(320/2, $fn=96);
    }

    translate([0, 0, 199])
    linear_extrude(50) {
        circle(100/2, $fn=96);
        translate([300,0,0])
        circle(100/2, $fn=96);
    }
}

scale(ViewScale)
{
//    rotate([180, 0, 0])
//    key();
    rotate([180, 0, 0])
    keys();
    translate([0, 600,0])
    rotate([180, 0, 0])
    spacekey();
}
