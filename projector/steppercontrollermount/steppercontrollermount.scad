include <model_steppercontroller.scad>
include <../../models/model_fan_caizhu_1inch.scad>
ViewScale = [0.0254, 0.0254, 0.0254];

module case()
{

    linear_extrude(101)
    difference()
    {
        square([pcbw + 200, pcbh + 199]);
        translate([150, 200, 0])
        square([pcbw-120, pcbh-400]);
        translate([66+75+110, pcbh-66-75+110, 0])
        circle(70/2, $fn=96);
        translate([pcbw-66-75+110, pcbh-66-75+110, 0])
        circle(70/2, $fn=96);
    }

    translate([0, 0, 100])
    linear_extrude(81)
    difference()
    {
        square([pcbw + 200, pcbh + 199]);
        translate([100, 100, 0])
        square([pcbw+20, pcbh+200]);
    }

    // Lower tabs
    translate([0, 0, 180])
    linear_extrude(50)
    square([300, 300]);

    translate([pcbw-150+50, 0, 180])
    linear_extrude(50)
    square([300, 300]);

    // Mounting tabs
    linear_extrude(180)
    difference()
    {
        hull()
        {
            translate([-250, pcbh/2, 0])
            circle(380/2);
            translate([2250, pcbh/2, 0])
            circle(380/2);
        }
        translate([-250, pcbh/2, 0])
        circle(180/2);
        translate([2250, pcbh/2, 0])
        circle(180/2);
        translate([100, 200, 0])
        square([pcbw+30, pcbh-200]);
    }
}

module fanmount()
{
    hsw = 927;
    hsh = 627;
    linear_extrude(400)
    difference() {
        roundedSquare(pos=[1100,1100],r=150);
        roundedSquare(pos=[1000,1000],r=110);
    }

    translate([-550, -(hsh+200)/2, -299])
    linear_extrude(300)
    difference() {
        square([1100, hsh+200]);
        translate([50, 100, 0])
        square([1000, hsh]);
        translate([150, -200, 0])
        square([800, 1200]);
    }

}

module forViewing()
{
    color("lightblue")
    translate([110, 110, 100])
    model_steppercontroller();
    case();
    hsw = 927;
    hsh = 627;
    translate([pcbw/2+110, pcbh-hsh+400, 1200]) {
        color("green")
        model_fan_caizhu_1inch();
        fanmount();
    }
}

module forPrinting()
{
//    case();
    fanmount();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
