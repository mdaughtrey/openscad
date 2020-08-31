ViewScale = [0.0254, 0.0254, 0.0254];


module part1()
{
    square([30, 50], center=true);
    translate([0, 29, 0])
    square([100, 20], center=true);
}

module part2()
{
    translate([0, -15, 0])
    difference() 
    {
        square([100, 60], center=true);
        translate([0, 10, 0])
        square([40, 50], center=true);
    }
}

module forviewing()
{
	part1();
    part2();
}

module forprinting()
{
    rotate([-90, 0, 0])
    linear_extrude(2300)
	part1();
    translate([200, 2300, 0])
    rotate([90, 0, 0])
    linear_extrude(2300)
    part2();
}

scale(ViewScale)
{
	//forviewing();
	forprinting();
}
