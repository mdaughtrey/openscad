ViewScale = [0.0254, 0.0254, 0.0254];

module battery()
{
    linear_extrude(880)
    difference() {
    square([330, 590], center=true);
    square([230, 490], center=true);
    }
}

//scale(ViewScale)
//{
//    battery();
//}
