ViewScale = [0.0254, 0.0254, 0.0254];

// square([1126, 145], center=true);
module extender()
{
    // slotty bit
    //linear_extrude(2000)
    difference() {
        square([1336, 350], center=true);
        #square([1136, 150], center=true);
        square([1036, 500], center=true);
    }
    // holdy bit
    extendlength = 6000;
    *translate([0, -350/2, 2000+extendlength/2-1])
    rotate([-90, 0, 0]) {
        linear_extrude(100)
        difference() {
            square([1336, extendlength], center=true);
            for(jj = [-2500, -1500, -500, 500, 1500, 2500]) {
                translate([0, jj, 0])
                circle(300, $fn=96);
            }
        }
        translate([0, 0, 99])
        linear_extrude(151) {
            translate([-1336/2+50, 0, 100])
            square([100, extendlength], center=true);
            translate([1336/2-50, 0, 100])
            square([100, extendlength], center=true);
        }
        translate([0, 0, 250])
        linear_extrude(100) {
            translate([-1336/2+75, 0, 100])
            square([150, extendlength], center=true);
            translate([1336/2-75, 0, 100])
            square([150, extendlength], center=true);
        }
    }
}

module filmmount()
{
    linear_extrude(150)
    difference() {
        square([1136, 1136], center=true);
        translate([0, 500, 0])
        square([736, 700], center=true);
        translate([0, -500, 0])
        square([736, 700], center=true);
    }

    linear_extrude(600)
    translate([0, 0, 150])
    difference() {
        square([600, 150], center=true);
        square([300, 150], center=true);
    }


    translate([0, 0, 1160])
    rotate([-90, 0, 0]) {
        linear_extrude(50)
        difference() {
            square([600, 1300], center=true);
            square([400, 1100], center=true);
        }

        translate([0, 0, 30])
        linear_extrude(50)
        difference() {
            square([600, 1050], center=true);
            square([400, 950], center=true);
        }

        linear_extrude(50)
        difference() {
            square([600, 900], center=true);
            square([400, 700], center=true);
        }
    }
}

scale(ViewScale)
{
    filmmount();
}
