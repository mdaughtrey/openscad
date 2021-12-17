include <model_boostbuck.scad>
ViewScale = [0.0254, 0.0254, 0.0254];

module case0()
{
    // PCB standoffs
    linear_extrude(400)
    {
        //translate([200, 955/2-750, 0])

        translate([1624, 133, 0])
        difference()
        {
            circle(250/2, $fn=96);
            circle(70/2, $fn=96);
        }

        translate([256, 855, 0])
        difference()
        {
            circle(250/2, $fn=96);
            circle(70/2, $fn=96);
        }
    }

    // Vex mounts
    linear_extrude(200)
    difference()
    {
        union()
        {
            translate([200, 955/2-750, 0])
            square([1500, 1500]);
            for (ii=[0,1500])
            {
                for (jj=[-750,750])
                {
                    translate([ii+200, 955/2+jj, 0])
                    circle(380/2, $fn=96);
                }
            }
        }

        translate([0, 955/2-500, 0])
        {
            translate([400, -50, 0])
            square([1100, 1100]);
            for (ii=[0,1500])
            {
                for (jj=[-750,750])
                {
                    translate([ii+200, 955/2+jj, 0])
                    circle(180/2, $fn=96);
                }
            }
        }
    }


//        translate([200, 200, 0])
//        {
//        square([1100, 1100]);
//        for (ii=[0,1500])
//        {
//            for (jj=[-750,750])
//            {
//                translate([ii+200, 955/2+jj, 0])
//                circle(180/2, $fn=96);
//            }
//        }
//        }
//    }
}

squareX = 1875+1200;
squareY = 1055+40;
boardX = 1875;
boardY = 955;

module base()
{
    linear_extrude(50)
    difference()
    {
        square([squareX, squareY]);
        for (ii=[200, 500, 800])
        {
            translate([700, ii+50, 0])
            hull()
            {
                circle(100/2, $fn=96);
                translate([1600, 0, 0])
                circle(100/2, $fn=96);
            }
        }
    }
}

module layer1(x=0)
{
    for (ii =[0, 1045])
    {
        translate([0, ii, 0])
        square([squareX, 50]);
    }

    for (ii =[0, 3025])
    {
        translate([ii, 0, 0])
        if (x == 2 || x == 3)
        {
            difference()
            {
                square([50, squareY]);
                translate([0, 300, 0])
                square([100, 150]);
            }
        }
        else
        {
            square([50, squareY]);
        }
    }

    if (x != 3)
    {
        for (ii=[squareX/2-boardX/2-60, squareX/2+boardX/2+10])
        {
            for (jj=[50, squareY-200])
            {
                translate([ii, jj, 0])
                square([50, 200]);
            }
        }
    }

    if (x == 0)
    {
        for (jj=[400, 700])
        {
            translate([squareX/2-500, jj, 0])
            square([1000, 50]);
        }
    }

    if (x !=3)
    {
        for (ii = [150, squareX - 150])
        {
            for (jj = [150, squareY - 150])
            {
                translate([ii, jj, 0])
                difference()
                {
                    circle(200/2, $fn=96);
                    circle(50/2, $fn=96);
                }


            }
        }
    }
}

module case()
{
    base();
    translate([0, 0, 49])
//    color("red")
    linear_extrude(51)
    layer1();
    translate([0, 0, 99])
    linear_extrude(201)
    layer1(1);
    translate([0, 0, 299])
    linear_extrude(301)
    layer1(2);
    translate([0, 0, 599])
    linear_extrude(101)
    layer1(3);
}

module lidcutouts(x=0)
{
    ofs = (x == 1) ? 80 : 0;
    for (ii=[200, 500, 800])
    {
        translate([700, ii+50-ofs, 0])
        hull()
        {
            circle(100/2, $fn=96);
            translate([1600, 0, 0])
            circle(100/2, $fn=96);
        }
    }
}


module lid()
{
    linear_extrude(61)
    difference()
    {
        square([squareX, squareY]);
        for (ii = [150, squareX - 150])
        {
            for (jj = [150, squareY - 150])
            {
                translate([ii, jj, 0])
                circle(160/2, $fn=96);
            }
        }
        lidcutouts();
    }
    translate([70, 70, 60])
    linear_extrude(50)
    difference()
    {
        square([squareX - 140, squareY - 140]);
        for (ii = [150, squareX - 150])
        {
            for (jj = [150, squareY - 150])
            {
                translate([ii-70, jj-70, 0])
                circle(100/2, $fn=96);
            }
        }
        lidcutouts(1);
    }
}


module forViewing()
{
    color("lightblue")
    translate([600, 70, 100])
    model_boostbuck();
    case();

    translate([0, squareY, 1000])
    rotate([180, 0, 0])
    lid();
}

module forPrinting()
{
    case();
    translate([0, 1400, 0])
    lid();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
