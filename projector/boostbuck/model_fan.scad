ViewScale = [0.0254, 0.0254, 0.0254];

module fourcircles(size, dia)
{
    size = size - dia;
    translate([-size/2, -size/2, 0])
    circle(dia/2, $fn=96);
    translate([size/2, -size/2, 0])
    circle(dia/2, $fn=96);
    translate([-size/2, size/2, 0])
    circle(dia/2, $fn=96);
    translate([size/2, size/2, 0])
    circle(dia/2, $fn=96);
}

module model_fan()
{
    linear_extrude(420)
    difference()
    {
        hull()
        fourcircles(1570, 250);
        fourcircles(1400, 140);
    }
}

// scale(ViewScale)
// {
//     model_fan();
// }
