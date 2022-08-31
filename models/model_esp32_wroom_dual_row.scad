
model_esp32_wroom_dual_row_pcb = function() [1550,1230];

module model_esp32_wroom_dual_row()
{
    triangle = function() [[0, 0], [100, 0], [100, 100]];
    pcb = model_esp32_wroom_dual_row_pcb();
    if (modelcolor) color("darkblue")
    linear_extrude(40)
    difference() {
        square(pcb);
        translate([pcb[0]-100, 0, 0])
        polygon(triangle());

        translate([pcb[0], pcb[1]-100, 0])
        rotate([0, 0, 90])
        polygon(triangle());

        translate([0, pcb[1]-90, 0])
        square([250, 90]);

        // Holes
        for (jj=[50, 150, pcb[1]-150, pcb[1]-50]) {
            translate([340, jj, 0])
            for (ii = [0:1:9]) {
                translate([ii * 100, 0, 0])
                circle(50/2);
            }
        }
    }

    // ESP Module PCB
    translate([pcb[0]-1000, 265, 40])
    if (modelcolor) color("black")
    linear_extrude(30)
    square([1000, 700]);

    // ESP Module
    translate([pcb[0]-970, 310, 70])
    if (modelcolor) color("silver")
    linear_extrude(100)
    square([690, 620]);

    // USB Connector
    translate([-20, pcb[1]/2-295/2, 40])
    if (modelcolor) color("silver")
    linear_extrude(90)
    square([225, 295]);

    // Reset Button
    translate([10, 1000, 40])
    if (modelcolor) color("beige")
    linear_extrude(90)
    square([175, 140]);


}
