ViewScale = [0.0254, 0.0254, 0.0254];
HoleR=62.5;

module rectHull(r, x, y)
{
    hull()
    {
        // place 4 circles in the corners, with the given r
        //translate([(-x/2)+(r/2), (-y/2)+(r/2), 0])
        translate([(-x/2)+r, (-y/2)+r, 0])
            circle(r=r);

        //translate([(x/2)-(r/2), (-y/2)+(r/2), 0])
        translate([(x/2)-r, (-y/2)+r, 0])
            circle(r=r);

        //translate([(-x/2)+(r/2), (y/2)-(r/2), 0])
        translate([(-x/2)+r, (y/2)-r, 0])
            circle(r=r);

        //translate([(x/2)-(r/2), (y/2)-(r/2), 0])
        translate([(x/2)-r, (y/2)-r, 0])
            circle(r=r);
    }
}

module layer0()
{
    linear_extrude(50)
    difference() {
        rectHull(100, 4200, 2550);
        translate([-2100+655+HoleR, -1275+90+HoleR]) circle(120, $fn=96);
        translate([2725-2100+655+HoleR, -1275+90+HoleR]) circle(120, $fn=96);
        translate([-2100+655+HoleR, 1275-90-HoleR]) circle(120, $fn=96);
        translate([2725-2100+655+HoleR, 1275-90-HoleR]) circle(120, $fn=96);
    }
}

module layer1()
{
    linear_extrude(100)
    difference() {
        rectHull(100, 4200, 2550);
        // temp
        square([3800, 2000], center=true);
        translate([-2100+655+HoleR, -1275+90+HoleR]) circle(120, $fn=96);
        translate([2725-2100+655+HoleR, -1275+90+HoleR]) circle(120, $fn=96);
        translate([-2100+655+HoleR, 1275-90-HoleR]) circle(120, $fn=96);
        translate([2725-2100+655+HoleR, 1275-90-HoleR]) circle(120, $fn=96);
    }
}

module layer2()
{
    linear_extrude(50) {
    difference() {
        rectHull(100, 4200, 2550);
        square([3800, 2000], center=true);
        translate([-2100+655+HoleR, -1275+90+HoleR]) circle(62.5, $fn=96);
        translate([2725-2100+655+HoleR, -1275+90+HoleR]) circle(62.5, $fn=96);
        translate([-2100+655+HoleR, 1275-90-HoleR]) circle(62.5, $fn=96);
        translate([2725-2100+655+HoleR, 1275-90-HoleR]) circle(62.5, $fn=96);
    }
    }
//    // charge board base
//    linear_extrude(50) translate([-2100+1250,175]) square([777, 1000]);
//    // guide
//    linear_extrude(150) translate([-2100+1250,275]) square([40, 1000]);
//    // guide
//    linear_extrude(150) translate([-2100+1250+737,275]) square([40, 1000]);
//    // rear guide
//    linear_extrude(150) translate([-2100+1250,250]) square([777, 50]);
//
//    // boost converter base
//    linear_extrude(100)
//    difference() {
//        translate([0, 0]) square([1120, 834]);
//        translate([50, 50]) square([1020, 734]);
//    }
}

module layer3()
{
    linear_extrude(580)
    difference() {
        rectHull(100, 4200, 2550);
        square([4100, 2450], center=true);
        translate([-2100+655+HoleR, -1275+90+HoleR]) circle(170, $fn=96);
        translate([2725-2100+655+HoleR, -1275+90+HoleR]) circle(170, $fn=96);
        translate([-2100+655+HoleR, 1275-90-HoleR]) circle(170, $fn=96);
        translate([2725-2100+655+HoleR, 1275-90-HoleR]) circle(170, $fn=96);
        translate([-1300, 1275-300]) square([450, 300]);
        //#translate([-2100-0, 1275-300]) square([1250, 300]);
        translate([-2100, -1215]) square([120, 480]);
        // charger connector cutout
        translate([-2100+1250+223, 1275-100]) square([350, 100]);
        // power switch cutout
        translate([2000, -500]) square([100, 240]);
    }
    // above charger connector
    translate([0, 0, 200])
    linear_extrude(370)
    translate([-2100+1250+223, 1275-50]) square([350, 50]);

    // switch holder
    linear_extrude(200)
    translate([1900, -750]) square([150, 100]);
    linear_extrude(200)
    translate([1900, -100]) square([150, 100]);

    // above switch cutout
    translate([0, 0, 100])
    linear_extrude(470)
    translate([2050, -500]) square([50, 240]);
    //translate([-2100+1250+213, 1275-50]) square([350, 50]);

    // corner support
    translate([2100-150, 1275-150]) linear_extrude(570) square([100, 100]);
    // corner support
    translate([2100-150, -1275+50]) linear_extrude(570) square([100, 100]);
    // corner support
    translate([-2100+50, 1275-150]) linear_extrude(570) square([100, 100]);
    // corner support
    translate([-2100+50, -1275+50]) linear_extrude(570) square([100, 80]);

    // left wall support
    translate([-2100+50, -575]) linear_extrude(570) square([100, 100]);
    // left wall support
    translate([-2100+50, 300]) linear_extrude(570) square([100, 100]);

    // right wall support
    translate([2100-150, 100]) linear_extrude(570) square([100, 100]);

    // front wall support
    translate([-2100+1050, -1275+50]) linear_extrude(570) square([100, 100]);
    // front wall support
    translate([950, -1275+50]) linear_extrude(570) square([100, 100]);
    // front wall support
    translate([-100, -1275+50]) linear_extrude(570) square([100, 100]);

    // rear wall support
    translate([0, 1275-150]) linear_extrude(570) square([100, 100]);
}

module charger()
{
    // charge board base
    translate([-2100+1250+391,1250-480]) {
        linear_extrude(250)
        difference() {
            square([783, 997], center=true);
            translate([0,40])
            square([683, 937], center=true);
        }
        linear_extrude(150)
        difference() {
        square([683, 897], center=true);
        square([583, 797], center=true);
        }
    }
}

module booster()
{
    // boost converter base
    linear_extrude(100)
    difference() {
        translate([0, 0]) square([1120, 834]);
        translate([50, 50]) square([1020, 734]);
    }
}

scale(ViewScale)
{
    layer0();
    translate([0, 0, 50]) layer1();
    translate([0, 0, 150]) layer2();
    translate([0, 0, 175]) layer3();
    translate([0, 0, 50]) charger();
    translate([0, 0, 50]) booster();
}
