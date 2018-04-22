ViewScale = [0.0254, 0.0254, 0.0254];

module pegs()
{
    circle(60, $fn=96);
    translate([70, 1915, 0])
    circle(60, $fn=96);

    translate([2075, 246-60, 0])
    circle(60, $fn=96);

    translate([2075, 1481-120-60, 0])
    circle(60, $fn=96);
}

module skelbase()
{
    difference() {
    polygon(points = [[-100, -100],[-100, 2015],[2175, 1581-100],[2175, 206]]);
    polygon(points = [[100, 100],[100, 1815],[1975, 1481-140],[1975, 306]]);
    }
}

module screwHole()
{
    circle(20, $fn=96);
}

module screwHoles(offset)
{
    translate([-2890/2+offset, 2290/2-offset, 0]) screwHole();
    translate([-2890/2+offset, -2290/2+offset, 0]) screwHole();
    translate([2890/2-offset, -2290/2+offset, 0]) screwHole();
    translate([2890/2-offset, 2290/2-offset, 0]) screwHole();
}

module screwMount()
{
    circle(100, $fn=96);
}

module screwMounts(offset)
{
    translate([-2890/2+offset, 2290/2-offset, 0]) screwMount();
    translate([-2890/2+offset, -2290/2+offset, 0]) screwMount();
    translate([2890/2-offset, -2290/2+offset, 0]) screwMount();
    translate([2890/2-offset, 2290/2-offset, 0]) screwMount();
}

module base()
{
//    difference() {
        square([2890, 2290], center=true);
//        square([2200, 1600], center=true);
//    }
    screwMounts(50);
}

module baseWalls1()
{
    difference() {
        union() {
            square([2890, 2290], center=true);
            screwMounts(50);
        }
    square([2740, 2140], center=true);
    screwHoles(50);
    }
}

module baseWalls2()
{
    difference() {
        union() {
            square([2890, 2290], center=true);
            screwMounts(50);
        }
    translate([-2790/2, 2190/2-540/2-300, 0])
    square([680, 540], center=true); // USB connector
    translate([-2790/2, -2190/2-380/2+380+170, 0])
    square([560, 400], center=true); // USB connector
    square([2740, 2140], center=true);
    screwHoles(50);
    }
}

module caseBody()
{
//    linear_extrude(100)
//    skelbase();

//    translate([532+40, 150, 50])
//    linear_extrude(200)
//    pegs();

    translate([2790/2, 2190/2, 0]) {
    linear_extrude(50)
    base();

    translate([0, 0, 50])
    linear_extrude(150)
    baseWalls1();

    translate([0, 0, 200])
    linear_extrude(500)
    baseWalls2();
    }
}

module lidLedCutout()
{
    // 550,230
    square([550, 230], center=true);
}

module lid1()
{
    difference() {
        union() {
    screwMounts(50);
    square([2890, 2290], center=true);
        }
    translate([-2890/2+210/2+100+50, 55, 0])
    square([230, 340], center=true);
    lidLedCutout();
    screwHoles(50);
    }
}

module lid2()
{
    difference() {
    square([2120, 1820], center=true);
    square([2020, 1720], center=true);
    }
    translate([0, 230/2+100/2+130, 0])
    square([850, 100], center=true);

    translate([0, -230/2-100/2-130, 0])
    square([850, 100], center=true);
}

module lid()
{
    linear_extrude(50)
    lid1();
    translate([0, 0, 50])
    linear_extrude(100)
    lid2();
}

scale(ViewScale)
{
    *caseBody();
    translate([2890/2-50, 2290/2-50, 800])
    rotate([180, 0, 180])
    lid();
}
