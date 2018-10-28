ViewScale = [0.0254, 0.0254, 0.0254];

module roundedTemplate(w,h)
{
    xoffset=w/2;
    yoffset=h/2;
    r=60;
    //square([3800, 2000], center=true);
    hull() {
        translate([xoffset-r, yoffset-r, 0])
        circle(r, $fn=96);
        translate([-xoffset+r, yoffset-r, 0])
        circle(r, $fn=96);
        translate([-xoffset+r, -yoffset+r, 0])
        circle(r, $fn=96);
        translate([xoffset-r, -yoffset+r, 0])
        circle(r, $fn=96);
    }
}

module cover()
{
    *translate([-2730/2,-1640/2])
    square([2730, 1640]);
    linear_extrude(70)
    difference() {
    roundedTemplate(2730,1640);
    roundedTemplate(2630,1540);
    }
}

scale(ViewScale)
{
    cover();
}
