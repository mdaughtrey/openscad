ViewScale = [0.0254, 0.0254, 0.0254];

module surround()
{
    difference() 
    {
        square(3000, center=true);
        square(2000, center=true);
    }
}

module brace()
{
    difference() 
    {
        square(2200, center=true);
        square(2000, center=true);
    }
}


scale(ViewScale)
{
    linear_extrude(200)
    surround();

    translate([0, 0, 200])
    linear_extrude(200)
    brace();
}

