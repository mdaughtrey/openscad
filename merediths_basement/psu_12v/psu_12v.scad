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
    color("cornflowerblue")
    linear_extrude(PSUH)
    square([PSUL, PSUW]);

    translate([0, 0, PSUH])
    color("lightblue")
    linear_extrude(100)
    {
        translate([1200, 650, 0])
        square([1270, 1000]);
        translate([1200, 2850, 0])
        square([1270, 1000]);
        translate([5330+1200, 3000, 0])
        circle(2250/2, $fn=96);

        translate([0, 0, 0])
        square([660, PSUW]);
    }
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
    h = PSUH+200+wallthick+60;
    rotate([0, -90, 0]) {
        linear_extrude(100)
        difference() {
            square([h, w]);
            translate([h/2, 1200,, 0])
            circle(750/2, $fn=96);
            translate([h/2, 3000, 0])
            circle(300/2, $fn=96);
        }
        translate([0, 0, -1999])
        linear_extrude(2000)
        difference() {
            square([h,w]);
            translate([wallthick, wallthick])
            square([h-wallthick*2, w-wallthick*2]);
        }
        translate([0, 0, -2099])
        linear_extrude(100)
        difference() {
            square([h,w]);
            translate([wallthick*2, wallthick*2])
            square([h-wallthick*4, w-wallthick*4]);
        }
        translate([0, 0, -2899])
        linear_extrude(800)
        difference() {
            square([h,w]);
            translate([wallthick, wallthick])
            square([h-wallthick*2, w-wallthick*2]);

            translate([500, -10, 0])
            square([h-1000, w+100]);

            translate([-200, 500, 0])
            square([h+100, w-1000]);
        }
        translate([0, 0, -3699])
        linear_extrude(800)
        difference() {
            square([h,w]);
            translate([wallthick, wallthick])
            square([h-wallthick*2, w-wallthick*2]);

            translate([500, -10, 0])
            square([h-1000, w+100]);

            translate([-10, 500, 0])
            square([h+100, w-1000]);
        }
    }
    translate([200, -ro, 0])
    oneclip();
}

module forViewing()
{
    translate([0, wallthick+20+ro, 220])
    model_psu();
    translate([-2200, ro, 0])
    endclip();
    *translate([6000, 0, 0])
    *oneclip();
}

module forPrinting()
{
    //oneclip();
    endclip();
}

scale(ViewScale)
{
    forPrinting();
//    forViewing();
}
