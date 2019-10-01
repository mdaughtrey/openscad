ViewScale = [0.0254, 0.0254, 0.0254];

module mount_ssmicro()
{
    linear_extrude(400)
    difference()
    {
        //square([480,435], center=true);
        square([720, 270], center=true);
        square([500, 62], center=true);
    }
}

//scale(ViewScale)
//{
//    mount_ssmicro();
//}
