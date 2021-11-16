ViewScale = [0.0254, 0.0254, 0.0254];

module model_vexplate(holesX, holesY)
{
    holesX = holesX - 1;
    holesY = holesY - 1;

    p = [[65, 0],[435, 0],[500,65],[500,435],[435,500],[65,500],[0,445],[0,65],[65,0]];

    linear_extrude(65)
    for (xx = [-holesX/2:1:holesX/2])
    {
        for (yy = [-holesY/2:1:holesY/2])
        {
            translate([xx * 500, yy * 500, 0])
            difference()
            {
                translate([-250, -250, 0])
                polygon(points=p);
                square([180, 180], center=true);
            }
        }
    }
}
