ViewScale = [0.0254, 0.0254, 0.0254];
tvside = 780; // 780 side
tvfront = 500; // 500 front
tvbottom = 790; // 790 botton
tvindent = 150;// 150 indent
boxside = 1000;

module model_tv()
{
    linear_extrude(2000)
    square([tvfront, tvside], center=true);
}

module case()
{

    // bottom bit
    linear_extrude(50)
    difference() {
        square([tvfront+boxside, boxside], center=true);
        translate([tvfront/2, 0, 0])
        circle(230/2, $fn=96);
    }

    // main bit
    translate([tvfront/2, 0, 50])
    linear_extrude(1049)
    difference() {
        square([boxside, boxside], center=true);
        square([boxside-100, boxside-100], center=true);
    }
}

module holes()
{
    linear_extrude(200) {
        circle(50, $fn=96);
        translate([0, 300, 0])
        circle(50, $fn=96);
    }
}

module box()
{
    difference() {
        case();
        translate([tvfront/2+150, boxside/2-150, 800])
        rotate([0, 90, 90])
        holes();
    }
}

module forViewing()
{
    *color("cyan")
    model_tv();
    box();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
