ViewScale = [0.0254, 0.0254, 0.0254];

module motor()
{
    linear_extrude(190)
    difference()
    {
        circle(224,,$fn=96);
        circle(135,,$fn=96);
    }
}

module shaft()
{
    linear_extrude(190)
    difference()
    {
        circle(224,,$fn=96);
        circle(169,,$fn=96);
    }
}


scale(ViewScale)
{
    union()
    {
        motor();
        translate([0, 0,190])  shaft();
    }
}

