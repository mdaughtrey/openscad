ViewScale = [0.0254, 0.0254, 0.0254];
include <../../../BOSL2-master/std.scad>
include <../../../models/fan-arctic-p12-pwm.scad>
$fn=96;

//module modname(anchor=CENTER,spin=0,orient=UP)
//{
//    module modname_()
//    {
//    }
//    attachable(anchor,spin,orient,size=)
//    {
//        modname_();
//        children();
//    }
//}

offset=4135/2;
holes = [
    [-offset, offset, 0],
    [offset, offset, 0],
    [-offset, -offset, 0],
    [offset, -offset, 0],
];

rods = [
    [0,1,2],
    [1,3],
    [2,3]
];

module fan_bracket(anchor=CENTER,spin=0,orient=UP)
{
    lift = 140;
    module fan_bracket_()
    {
        rmtag="r41vrq";
        diff(rmtag)
        cuboid([5200, 4910, lift], edges=[BACK+LEFT,BACK+RIGHT], rounding=100)
        {
            tag(rmtag) back(100)
            {
                up(1) cyl(d=4500, h=lift+2);
                for (hole_tx = holes)
                {
                    translate(hole_tx) cyl(d=180, h=lift+2);
                }
            }
            position(FRONT+BOT) cuboid([5200, 200, 1100], anchor=TOP+FRONT)
            {
                position(RIGHT+BACK+TOP) wedge([100,1000,1000], orient=BOT);
                position(LEFT+BACK+TOP) wedge([100,1000,1000], orient=BOT, anchor=BOT+FRONT+RIGHT);
                // Base
                position(FRONT+RIGHT+BOT) cuboid([200,1000,1200], anchor=BACK+RIGHT+BOT)
                {
                    position(BOT+RIGHT+FRONT) pie_slice(ang=90, r=1200, l=200, orient=RIGHT,anchor=TOP);
                    position(TOP+FRONT+LEFT) pie_slice(ang=90, r=1200, l=200, orient=LEFT, anchor=TOP);
                }
                position(FRONT+LEFT+BOT) cuboid([200,1000,1200], anchor=BACK+LEFT+BOT)
                {
                    position(BOT+RIGHT+FRONT) pie_slice(ang=90, r=1200, l=200, orient=RIGHT,anchor=TOP);
                    position(TOP+FRONT+LEFT) pie_slice(ang=90, r=1200, l=200, orient=LEFT, anchor=TOP);
                }
            }
            *for (rod = rods)
            {
                origin = rod[0];
                r0_offset = -holes[origin];
                for (r = [1:len(rod)-1])
                {
                    o0 = holes[origin][0];
                    r0 = holes[rod[r]][0];
                    xlength = (r0 - o0);
                    xsign = (r0 - o0) >= 0 ? 1: -1;
                    o1 = holes[origin][1];
                    r1 = holes[rod[r]][1];
                    ylength = (r1 - o1);
                    ysign = (r1 - o1) >= 0 ? 1: -1;
                    length = sqrt(pow(xlength, 2) + pow(ylength, 2));
                    
                    angle = xlength == 0 ? -90 : ylength == 0 ? 0 : atan2(ylength, xlength);
                    translate(holes[origin])
                    zrot(angle) cuboid([length, 100, lift], anchor=LEFT);
                }
            }
        }

    }
    attachable(anchor,spin,orient,size=[offset*2, offset*2, lift])
    {
        fan_bracket_();
        children();
    }
}


//jmodule fan_enclosure(anchor=CENTER,spin=0,orient=UP)
//j{
//j    module fan_enclosure_()
//j    {
//j    }
//j    attachable(anchor,spin,orient,size=)
//j    {
//j        fan_enclosure_();
//j        children();
//j    }
//j}

//jmodule tilt_base(anchor=CENTER,spin=0,orient=UP)
//j{
//j    module tilt_base_()
//j    {
//j    }
//j    attachable(anchor,spin,orient,size=)
//j    {
//j        tilt_base_();
//j        children();
//j    }
//j}
//j
//jmodule monitor_adapter(anchor=CENTER,spin=0,orient=UP)
//j{
//j    module monitor_adapter_()
//j    {
//j    }
//j    attachable(anchor,spin,orient,size=)
//j    {
//j        monitor_adapter_();
//j        children();
//j    }
//j}
//j

module case()
{
}

module forViewing()
{
    artic_p12_pwm();
    up(1100) fwd(100)
    fan_bracket();
}

module forPrinting()
{
    fan_bracket();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
