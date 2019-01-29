ViewScale = [0.0254, 0.0254, 0.0254];

INSERTLENGTH=440;

module insertwall()
{
    square([544, 200], center=true);
    translate([744/2-100, 0, 0]) {
        circle(100, $fn=96);
        square([100, 100]);
    }

    translate([-544/2, 0, 0]) 
    rotate([0, 0, 90]) {
        circle(100, $fn=96);
        square([100, 100]);
    }
}

module strap()
{
    // front wall
    linear_extrude(120) {
        square([800, 310], center=true);
        translate([450, 0, 0])
        square([100, 310], center=true);
        translate([-450, 0, 0])
        square([100, 310], center=true);
    }
    // sides
    translate([0, 0, 120])
        linear_extrude(330) {
        translate([450, 0, 0])
        square([100, 310], center=true);
        translate([-450, 0, 0])
        square([100, 310], center=true);
    }
    // cross bits
    translate([-335, 0, 20+330])
    linear_extrude(100) 
    square([140, 310], center=true);

    translate([335, 0, 20+330])
    linear_extrude(100) 
    square([140, 310], center=true);
    
}

module holder()
{
    linear_extrude(50)
    square([700, 200], center=true);
    translate([-225, 0, 50])
    linear_extrude(250){
    square(90, center=true);
    translate([450, 0, 0])
    square(90, center=true);
    }
}

module insert()
{
    // front wall
    linear_extrude(80) insertwall();
    // side walls
    translate([0, 0, 80])
    linear_extrude(INSERTLENGTH-80)
    difference() {
        insertwall();
        square([544, 204], center=true);
    }

    translate([0, 0, INSERTLENGTH+20+330+100])
    rotate([180, 0, 0])
    strap();
}

scale(ViewScale)
{
    *insert();
    //translate([1000, 0, 0])
    holder();
}
