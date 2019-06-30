ViewScale = [0.0254, 0.0254, 0.0254];

module brace1()
{
    difference(){
        square([1170, 1385], center=true);
        square([940, 1155], center=true);
        translate([-1070/2, 0, 0])
        square([150, 955], center=true);
        translate([1050/2, 0, 0])
        square([150, 1100], center=true);
    }
}

module brace3()
{
    difference(){
        square([1170, 1385], center=true);
        square([940, 1155], center=true);
        translate([-1070/2, 0, 0])
        square([150, 955], center=true);
    }
}

module brace2()
{
    difference(){
        square([1170, 1385], center=true);
        square([940, 1155], center=true);
        translate([-1070/2, 0, 0])
        square([150, 955], center=true);
        translate([(1185-700)/2, -(1185-600+100)/2, 0])
        square([700, 700], center=true);
    }
}

scale(ViewScale)
{
    linear_extrude(1000)
    brace1();

    translate([0, 0, 1000])
    linear_extrude(1000)
    brace3();

    translate([0, 0, 2000])
    linear_extrude(1400)
    brace2();

    translate([0, 0, 3400])
    linear_extrude(2000)
    brace3();
}
