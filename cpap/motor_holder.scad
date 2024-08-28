ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>

$fn = 96;
mountNW = [0,0];
mountNE = [1720+145,0];
mountS = zrot(-79, p=[3770+175,0]);
mountC = zrot(-61, p=[2386,0]);
echo("mountNW ",mountNW," mountNE ",mountNE," mountS ",mountS);


//module volute(a, b, f, n=100, rev=1) {
//  // Parametric equations for the Archimedean spiral
//  function x(a, b, theta) = (a + b * theta) * sin(theta);
//  function y(a, b, theta) = (a + b * theta) * cos(theta);
//
//  // Generate the spiral by drawing circles along the curve
//  assign (da = rev * 360 / n)
//  for (i = [1:n])
//    translate([x(a, b, da * i), y(a, b, da * i), 0])
//      circle(f);
//}

// Example usage:
//linear_extrude(height = 10) volute(15, 0.03, 2, rev = 1);

module intake(anchor=CENTER,spin=0,orient=UP)
{
    rgn=[
    move([2000,0], p=circle(d=2670)),
    move([2000,0], p=circle(d=2370))
    ];
    baseHeight = 200;
    module intake_()
    {
        path = [mountNW, mountNE, mountS];
        move([-mountC[0], -mountC[1],0])
        diff("intake_remove")
        {
            hull()
            {
                move(mountNW) cyl(d=175,h=baseHeight,anchor=BOT);
                move(mountNE) cyl(d=175,h=baseHeight,anchor=BOT);
                move(mountS) cyl(d=175,h=baseHeight,anchor=BOT);
            }
            move(mountNW) cyl(d=450,h=baseHeight,anchor=BOT);
            move(mountNE) cyl(d=450,h=baseHeight,anchor=BOT);
            move(mountS) cyl(d=450,h=baseHeight,anchor=BOT);
            move(mountC) cyl(d=2770,h=baseHeight,anchor=BOT);
            tag("intake_remove")
            {
                move(mountNW) cyl(d=175,h=baseHeight,anchor=BOT);
                move(mountNE) cyl(d=175,h=baseHeight,anchor=BOT);
                move(mountS) cyl(d=175,h=baseHeight,anchor=BOT);
                move(mountC) cyl(d=2370,h=baseHeight,anchor=BOT);
            }
        }

        up(baseHeight-1)
        fwd(2370/2+800)
        yrot(-90)
        rotate_sweep(rgn, angle=90);
        *tube(id=2370,wall=400,h=200);
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        intake_();
        children();
    }
}

module intake_gasket(anchor=CENTER,spin=0,orient=UP)
{
    baseHeight = 200;
    module intake_gasket_()
    {
        path = [mountNW, mountNE, mountS];
        move([-mountC[0], -mountC[1],0])
        diff("intake_gasket_remove")
        {
            linear_extrude(baseHeight)
            stroke(path, width=200, closed=true,joints="dot");
//            hull()
//            {
//                move(mountNW) cyl(d=175,h=baseHeight,anchor=BOT);
//                move(mountNE) cyl(d=175,h=baseHeight,anchor=BOT);
//                move(mountS) cyl(d=175,h=baseHeight,anchor=BOT);
//            }
            move(mountNW) cyl(d=450,h=baseHeight,anchor=BOT);
            move(mountNE) cyl(d=450,h=baseHeight,anchor=BOT);
            move(mountS) cyl(d=450,h=baseHeight,anchor=BOT);
            move(mountC) cyl(d=2770,h=baseHeight,anchor=BOT);
            tag("intake_gasket_remove")
            {
                move(mountNW) cyl(d=185,h=baseHeight,anchor=BOT);
                move(mountNE) cyl(d=185,h=baseHeight,anchor=BOT);
                move(mountS) cyl(d=185,h=baseHeight,anchor=BOT);
                move(mountC) cyl(d=2370,h=baseHeight,anchor=BOT);
            }
        }
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        intake_gasket_();
        children();
    }
}

module test_fixture(anchor=CENTER,spin=0,orient=UP)
{
    path = [mountNW, mountNE, mountS];
    module test_fixture_()
    {
        linear_extrude(100)
        stroke(path, width=100, closed=true,joints="dot");
        move(mountNW) cyl(d=150,h=500,anchor=TOP);
        move(mountNE) cyl(d=150,h=500,anchor=TOP);
        move(mountS) cyl(d=150,h=500,anchor=TOP);
        move(mountC) tube(id=2370,wall=100,h=100,anchor=BOT);
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        test_fixture_();
        children();
    }
}


module intake_fastener(anchor=CENTER,spin=0,orient=UP)
{
    module test_fixture_()
    {
        cyl(d=400,h=100)
        attach(TOP, norot=1) cyl(d=155,h=700,anchor=BOT);
//        linear_extrude(100)
//        stroke(path, width=100, closed=true,joints="dot");
//        move(mountNW) cyl(d=150,h=500,anchor=TOP);
//        move(mountNE) cyl(d=150,h=500,anchor=TOP);
//        move(mountS) cyl(d=150,h=500,anchor=TOP);
//        move(mountC) tube(id=2370,wall=100,h=100,anchor=BOT);
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        test_fixture_();
        children();
    }
}

//module case()
//{
//}
//

module forViewing()
{
//    intake();
    intake_gasket();
//       intake_fastener();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
