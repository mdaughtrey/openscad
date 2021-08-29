include <../models/0805_resistor.scad>

model_shoot_chipSocket = function (pins) [400, pins * 100 + 40];
model_shoot_chipIC = function (pins) [240, 770];
model_shoot_pcb = function() [3940, 1970];
model_shoot_pcbX = function(x,xofs) -(model_shoot_pcb()[0]/2)+(x/2)+xofs;
model_shoot_pcbY = function(y,yofs) -(model_shoot_pcb()[1]/2)+(y/2)+yofs;

module model_shoot_ic(pins)
{
    // Socket
    color("darkslategray")
    linear_extrude(170)
    square(model_shoot_chipSocket(pins/2), center=true);

    // IC
    color("darkslategray")
    translate([0, 0, 169])
    linear_extrude(169)
    square(model_shoot_chipIC(pins/2), center=true);

    // Pins
    offset = (pins % 2) ? -50 : 0;
    pinV = [-floor(pins/4)*100+offset:100:floor(pins/4)*100+offset];
    for(ii = pinV)
    {
        for(jj = [-200+30+10, 200-30-10])
        {
            translate([jj, ii, 159])
            color("lightgrey")
            linear_extrude(20)
            circle(60/2, $fn=96);
        }
    }
}

module model_shoot_led()
{
    color("white")
    linear_extrude(10)
    square([130, 60], center=true);

    color("springgreen")
    translate([0, 0, 9])
    linear_extrude(28)
    square([75, 60], center=true);
}


module model_shoot()
{
    mspcbx = model_shoot_pcbX;
    mspcby = model_shoot_pcbY;
    mscs = model_shoot_chipSocket;

    pcbW = 3940;
    pcbH = 1970;
//    chipSocketW = 400;
    // PCB
    color("darkblue")
    linear_extrude(62)
    square(model_shoot_pcb(), center=true);

    // ICs
    translate([mspcbx(mscs(7)[0], 1400), mspcby(mscs(7)[1], 1076), 61])
    model_shoot_ic(14);
    translate([mspcbx(mscs(7)[0], 1400), mspcby(mscs(7)[1], 193), 61])
    model_shoot_ic(14);

    translate([mspcbx(mscs(8)[0], 2580), mspcby(mscs(8)[1], 990), 61])
    model_shoot_ic(16);
    translate([mspcbx(mscs(8)[0], 2580), mspcby(mscs(8)[1], 147), 61])
    model_shoot_ic(16);


    // LEDs
    for (ii = [-800:200:800])
    {
        translate([pcbW/2-130/2-394, ii+30, 62])
        model_shoot_led();
    }
    // Resistors
    for (ii = [-800:200:800])
    {
        translate([pcbW/2-120/2-625, ii+30, 62])
        model_0805_resistor();
    }
    // Button body
    color("darkslategray")
    translate([-pcbW/2+250/2+280, 0, 62])
    linear_extrude(166)
    square([250, 250], center=true);
    // Button actuator
    color("darkred")
    translate([-pcbW/2+250/2+280, 0, 215])
    linear_extrude(50)
    circle(135/2, $fn=96);

    // speed pot
    color("lightslategray")
    translate([-pcbW/2+200/2+320, pcbH/2-100-310, 62])
    linear_extrude(100)
    square([200, 200], center=true);
    translate([-pcbW/2+200/2+320, pcbH/2-100-310, 150])
    color("lightgray")
    linear_extrude(20)
    circle(50, $fn=96);

}

//module forViewing()
//{
//    model_shoot();
//}
//
//
//scale(ViewScale)
//{
//    forViewing();
//}
