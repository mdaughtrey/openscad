ViewScale = [0.0254, 0.0254, 0.0254];

model=1;

module model_ledstrip(numleds)
{
    linear_extrude(90)
    square([660*numleds, 293]);
}

module switchbox()
{
}

module onemount()
{
    linear_extrude(8000) {
    polygon(points=[[0, 0],[450,0],[0,200]]);
    intersection() {
        square([600, 400]);
        translate([0, 200, 0])
        rotate([0, 0, -30])
        difference()
        {
            square([500, 200]);
            translate([90, 100, 0])
            square([320, 200]);
        }
    }
    }

}

module forViewing()
{
    if (model)
    {
        color("cornflowerblue")
        model_ledstrip(10);
    }
    rotate([0, 0, 90])
    onemount();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
