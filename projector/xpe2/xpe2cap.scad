ViewScale = [0.0254, 0.0254, 0.0254];

module case()
{
    linear_extrude(20)
    difference() {
        circle(1490/2, $fn=96);
        circle(1240/2, $fn=96);
    }
    // Outer
    linear_extrude(200)
    difference() {
        circle(1490/2, $fn=96);
        circle(1440/2, $fn=96);
    }
}

scale(ViewScale)
{
    case();
}
