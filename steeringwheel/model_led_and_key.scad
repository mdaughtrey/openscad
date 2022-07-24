ViewScale = [0.0254, 0.0254, 0.0254];

mlak_pcbx = 3000;
mlak_pcby = 1950;
mlak_holex = 1337;
mlak_holey = 790;

function fromtop(ofs, h) = mlak_pcby/2 - ofs - h/2;
function frombottom(ofs, h) = (-mlak_pcby/2) + ofs + h/2;
function fromleft(ofs, w) = (-mlak_pcbx/2) + ofs + w/2;

module mlak_led()
{
    linear_extrude(215)
    circle(153/2, $fn=96);
}

module mlak_7seg()
{
    linear_extrude(290)
    square([1196, 562], center=true);
}

module mlak_button()
{
    linear_extrude(140)
    square([242, 242], center=true);
    translate([0, 0, 139])
    circle(132/2, $fn=96);
}

module mlak_pcb()
{
    // PCB and holes
    linear_extrude(65)
    difference() {
        square([mlak_pcbx, mlak_pcby], center=true);
        for (ii = [-1337, 1337]) {
            for (jj = [-790, 790]) {
                translate([ii, jj, 0])
                circle(120/2, $fn=96);
            }
        }
    }

    // LEDs
    for (ii = [-3:4]) {
        translate([ii * 323 -162, fromtop(73, 153), 64])
        mlak_led();
    }

    // 7 Segment Displays
    translate([-1196/2, fromtop(345, 562), 64])
    mlak_7seg();
    translate([1196/2, fromtop(345, 562), 64])
    mlak_7seg();

    // Buttons
    for (ii = [-3:4]) {
        translate([ii * 290 -171, frombottom(75, 242), 64])
        mlak_button();
    }

    // Terminals
    translate([fromleft(50, 100), frombottom(443, 500), 64])
    linear_extrude(310)
    square([100, 500], center=true);



}

module model_led_and_key()
{
    mlak_pcb();
}

//module forViewing()
//{
//    pcb();
//}
//
//module forPrinting()
//{
//}
//
//scale(ViewScale)
//{
//    forViewing();
//}
