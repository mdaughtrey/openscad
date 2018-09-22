ViewScale = [0.0254, 0.0254, 0.0254];

module lucy()
{
    translate([0, 0, 100])
   linear_extrude(2000)
    text("lucy", font="curlz MT", size=2000, spacing=1);

    linear_extrude(100)
    translate([0, -800, 0])
    square([4000, 1000]);

    linear_extrude(1600)
    translate([0, -800, 0])
    square([4000, 100]);

}

scale(ViewScale)
{
    lucy();
}
