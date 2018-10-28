ViewScale = [0.0254, 0.0254, 0.0254];

module motorBody()
{
    // tabs
    linear_extrude(100)
    rotate([0, 0, 90])
    translate([270/2, 0, 0])
    square([20, 80], center=true);

    linear_extrude(100)
    rotate([0, 0, -90])
    translate([270/2, 0, 0])
    square([20, 80], center=true);

    // rear circle
    translate([0, 0, 50])
    linear_extrude(50)
    circle(196/2, $fn=96);

    // motor body
    translate([0, 0, 100])
    linear_extrude(586)
    intersection() {
    circle(475/2, $fn=96);
    square([394,500], center=true);
    }
}

module gearset()
{
    // lower plate
    linear_extrude(30)
    square([470, 392], center=true);

    // mid plate
    translate([0, 0, 130])
    linear_extrude(30)
    square([470, 392], center=true);

    // upper plate
    translate([0, 0, 323])
    linear_extrude(30)
    square([470, 392], center=true);

    // shaft hub
    translate([0, 0, 353])
    linear_extrude(26)
    circle(157/2, $fn=96);

    // column
    translate([470/2-117/2-30, 392/2-117/2-30, 30])
    linear_extrude(300)
    circle(117/2, $fn=96);

    // column
    translate([-470/2+117/2+30, -392/2+117/2+30, 30])
    linear_extrude(300)
    circle(117/2, $fn=96);

    // shaft
    translate([0, 0, 353+26])
    linear_extrude(264)
    intersection() {
    circle(118/2, $fn=96);
    translate([20, 0, 0])
    square(118, center=true);
    }

}

module model_geared2()
{
    motorBody();
    translate([0, 0, 686])
    rotate([0, 0, 90])
    gearset();
}

//scale(ViewScale)
//{
//    model_geared2();
//}
