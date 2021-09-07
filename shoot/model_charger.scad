model_charger_pcb = function() [866, 675];

module model_charger(pcbcolor)
{
    pcbw = model_charger_pcb()[0];
    pcbh = model_charger_pcb()[1];
    // PCB
    color(pcbcolor)
    linear_extrude(45)
    square([pcbw, pcbh], center=true);

    // USB Connector
    color("silver")
    translate([pcbw/2-218/2+20, 0, 44])
    linear_extrude(100)
    square([218, 218], center=true);

    // IC
    color("darkslategray")
    translate([-pcbw/2+150/2+390, -pcbh/2+200/2+300, 44])
    linear_extrude(60)
    square([150, 200], center=true);

    // Inductor
    color("darkslategray")
    translate([-pcbw/2+168/2+140, -pcbh/2+168/2+280, 44])
    linear_extrude(120)
    square([168, 168], center=true);

}


