ViewScale = [0.0254, 0.0254, 0.0254];


module oneside()
{
    difference() {
        linear_extrude(2000)
        difference() {
        square([80, 350], center=true);
        translate([-26, 90, 0])
        square([30, 70], center=true);
        }
        for(ii=[200:300:1800])
        {
            translate([-100, -30, ii])
            rotate([0, 90, 0])
            linear_extrude(200)
            circle(100, $fn=6);
        }
    }
}

module sides()
{
    translate([1000, 360, 0])
    rotate([-90,0,90])
    {
        oneside();
        translate([-720, 0, 2000])
        rotate([180, 0, 180])
        oneside();
    }
}

module bottom()
{
    linear_extrude(50)
    difference() {
        square([2000, 800], center=true);
        translate([-600, 0, 0])
        circle(400/2, $fn=96);
        translate([600, 0, 0])
        circle(400/2, $fn=96);
        circle(400/2, $fn=96);
    }
}

//scale(ViewScale)
module convertermount()
{
    bottom();
    translate([0, 0, 225])
    sides();
}
