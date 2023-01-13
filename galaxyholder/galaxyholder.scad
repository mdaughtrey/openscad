include <../libs/MCAD/2Dshapes.scad>
ViewScale = [0.0254, 0.0254, 0.0254];
include <../models/model_fan_caizhu_1inch.scad>

models=1;

module model_tablet()
{
//    9600x5625x300
    linear_extrude(300)
    square([9600, 5625], center=true);

    // speaker
    translate([4800, 0, 95])
    linear_extrude(130) {
        translate([0, -3880/2, 0])
        square([100, 650], center=true);
        translate([0, 3880/2, 0])
        square([100, 650], center=true);
        square([100, 450], center=true);
    }
}

module hook()
{
    module hookTemplate()
    {
        translate([-20, -300, 0])
        square([2000, 300]);
        translate([-50, -150, 0])
        roundedSquare(pos=[400,300],r=100);
        translate([-125, 150, 0])
        roundedSquare(pos=[250,750],r=100);
        translate([0, 430, 0])
        roundedSquare(pos=[500,200],r=50);
    }

    module endHookTemplate()
    {
        translate([150, -150, 0])
        roundedSquare(pos=[800,300],r=100);
        translate([0, 430, 0])
        roundedSquare(pos=[500,200],r=50);
    }

//    color("cornflowerblue")
//    square([2000, 320]);
    linear_extrude(1000)
    hookTemplate();
    translate([0, 0, 999])
    linear_extrude(100)
    hull() {endHookTemplate();}


//    roundedSquare(pos=[2000,500],r=100);

}

module forViewing()
{
    if (models) {
        color("grey")
        model_tablet();
    }
    translate([3830, -2850, 0])
    rotate([90, 0, 90])
    hook();

    translate([-3830, -2850, 0])
    scale([-1.0, 1.0, 1.0])
    rotate([90, 0, 90])
    hook();


}

module forPrinting()
{
    hook();
}

scale(ViewScale)
{
    forViewing();
//    forPrinting();
}
