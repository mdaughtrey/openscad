ViewScale = [0.0254, 0.0254, 0.0254];
include <model_led_and_key.scad>

model = 1;

module vexpoints()
{
    for (ii=[-4500/2, 4500/2]) {
        for (jj=[-1500/2, 1500/2]) {
            translate([ii, jj, 0])
            difference() {
                circle(400/2, $fn=96);
                circle(180/2, $fn=96);
            }
        }
    }
}

module boardmounts()
{
    for (ii = [-mlak_holex, mlak_holex]) {
        for (jj = [-mlak_holey, mlak_holey]) {
            translate([ii, jj, 0])
            difference() {
                circle(320/2, $fn=96);
                circle(130/2, $fn=96);
            }
        }
    }
}

module mount()
{
    function vexNW() = [-4500/2,  1500/2, 0];
    function vexNE() = [ 4500/2,  1500/2, 0];
    function vexSW() = [-4500/2, -1500/2, 0];
    function vexSE() = [ 4500/2, -1500/2, 0];

    function pcbNW() = [-mlak_holex,  mlak_holey, 0];
    function pcbNE() = [ mlak_holex,  mlak_holey, 0];
    function pcbSW() = [-mlak_holex, -mlak_holey, 0];
    function pcbSE() = [ mlak_holex, -mlak_holey, 0];

    vexOuter = 400/2;
    vexInner = 180/2;
    pcbOuter = 400/2;
    pcbInner = 130/2;

    linear_extrude(200)
    difference() {
        union() {
            hull() { translate(vexNW()) circle(vexOuter, $fn=96); translate(pcbNW()) circle(pcbOuter, $fn=96); }
            hull() { translate(pcbNW()) circle(pcbOuter, $fn=96); translate(pcbNE()) circle(pcbOuter, $fn=96); }
            hull() { translate(pcbNE()) circle(pcbOuter, $fn=96); translate(vexNE()) circle(vexOuter, $fn=96); }
        }
        translate(vexNW()) circle(vexInner, $fn=96);
        translate(pcbNW()) circle(pcbInner, $fn=96);
        translate(pcbNE()) circle(pcbInner, $fn=96);
        translate(vexNE()) circle(vexInner, $fn=96);
    }
    translate([0, 0, 199])
    linear_extrude(100) {
        translate(pcbNW()) { difference() { circle(pcbOuter, $fn=96); circle(pcbInner, $fn=96); } }
        translate(pcbNE()) { difference() { circle(pcbOuter, $fn=96); circle(pcbInner, $fn=96); } }
    }



    *difference() {
        hull() {
            translate([-4500/2, -1500/2, 0])
            circle(400/2, $fn=96);
            translate([4500/2, -1500/2, 0])
            circle(400/2, $fn=96);
        }
        translate([-4500/2, -1500/2, 0])
        circle(180/2, $fn=96);
        translate([4500/2, -1500/2, 0])
        circle(180/2, $fn=96);

        for (ii = [-mlak_holeX, mlak_holeX]) {
            for (jj = [-mlak_holeY, mlak_holeY]) {
                translate([ii, jj, 0])
                circle(130/2, $fn=96);
            }
        }
    }

    *for (ii=[-4500/2, 4500/2]) {
        for (jj=[-1500/2, 1500/2]) {
            translate([ii, jj, 0])
            difference() {
                circle(400/2, $fn=96);
                circle(180/2, $fn=96);
            }
        }
    }
}

module forViewing()
{
    if (model) {
        translate([0, 0, 300])
        color("cyan")
        model_led_and_key();
        color("grey")
        {
            vexpoints();
            boardmounts();
        }
    }
    mount();
}

module forPrinting()
{
    mount();
}

scale(ViewScale)
{
    //forViewing();
    forPrinting();
}
