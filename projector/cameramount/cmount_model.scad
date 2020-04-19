ViewScale = [0.0254, 0.0254, 0.0254];

sqw = 978;
sqh = 937;
holer = 80/2;

module cmount_model()
{
    color("cyan")
    linear_extrude(38)
    difference() {
        square([sqw,sqh]);
        translate([35+holer, 35+holer, 0])
        circle(holer, $fn=96);
        translate([sqw-35-holer, 35+holer, 0])
        circle(holer, $fn=96);
        translate([sqw-35-holer, sqh-322-holer, 0])
        circle(holer, $fn=96);
        translate([35+holer, sqh-322-holer, 0])
        circle(holer, $fn=96);
    }
    // connector
    connw = 870;
    connh = 220;
    conne = 104;
    translate([(sqw-connw)/2, sqh-connh, 38])
    color("cornflowerblue")
    linear_extrude(conne)
    square([connw, connh]);

    // sensor
    sensorw = 330;
    sensorh = 330;
    translate([sqw/2-sensorw/2, sqh-322-sensorh/2-holer, -100])
    {
        color("cornflowerblue")
        linear_extrude(110)
        square([sensorw, sensorw]);

        sensorr = 285/2;
        translate([sensorw/2, sensorh/2, -70])
        color("cornflowerblue")
        linear_extrude(70)
        circle(sensorr, $fn=96);
    }
}

//scale(ViewScale)
//{
//    cmount_model();
//}
