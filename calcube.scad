
ViewScale = [0.0254, 0.0254, 0.0254];
scale(ViewScale)
{
    linear_extrude(1000)
    difference() {
    square([1000, 1000], center=true);
    square([500, 500], center=true);
    }
}
   
