ViewScale = [0.0254, 0.0254, 0.0254];

PSUL = 8500;
PSUW = 4480;
PSUH = 1970;
clearance = 20;
wallthick = 200;
ro=300;
ri=100;

module model_psu()
{
    linear_extrude(PSUH)
    square([PSUL, PSUW]);
}

module oneclip()
{
    // Base
    linear_extrude(200)
    difference() {
        hull() {
            circle(ro, $fn=96);
            translate([0, 40+(wallthick*2)+PSUW+ro*2, 0])
            circle(ro, $fn=96);
        }
        circle(ri, $fn=96);
            translate([0, 40+(wallthick*2)+PSUW+ro*2, 0])
            circle(ri, $fn=96);
    }
    // Walls
    translate([0, 0, 199])
    linear_extrude(PSUH+60) {
        translate([-ro, ro, 0])
        square([ro*2, wallthick]);
        translate([-ro, 40+ro+wallthick+PSUW, 0])
        square([ro*2, wallthick]);
    }
    // Top
    translate([-ro, ro, 220+PSUH+40-1])
    linear_extrude(200)
    square([ro*2, PSUW+(wallthick*2) + 40]);
}

module endclip()
{
    w = PSUW+wallthick*2+40;
    h = PSUH+wallthick*2+40;
    rotate([0, -90, 0]) {
        linear_extrude(100)
        difference() {
            square([h, w]);
            translate([h/2, 1200,, 0])
            circle(750/2, $fn=96);
            translate([h/3, 2500, 0])
            square([500, 1000]);
        }
        translate([0, 0, -999])
        linear_extrude(1000)
        difference() {
            square([h,w]);
            translate([wallthick/2, wallthick/2])
            square([h-wallthick, w-wallthick]);
        }
    }
    translate([200, -ro, 0])
    oneclip();
}

module forViewing()
{
    translate([0, wallthick+20+ro, 220])
    color("cornflowerblue")
    model_psu();
    translate([-1000, ro, 0])
    endclip();
    *translate([6000, 0, 0])
    *oneclip();
}

module forPrinting()
{
    oneclip();
}

scale(ViewScale)
{
//    forPrinting();
    forViewing();
}
