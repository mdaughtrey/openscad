ViewScale = [0.0254, 0.0254, 0.0254];
clearance = 30;

module motor_housing_body()
{
    // motor body
    difference() {
    intersection() {
    circle((574+clearance)/2, $fn=96);
    square([494+clearance,650], center=true);
    }
    intersection() {
    circle((473+clearance)/2, $fn=96);
    square([394+clearance,550], center=true);
    }}
}

module motor_housing_cap()
{
    // motor body
    difference() {
    intersection() {
    circle((574+clearance)/2, $fn=96);
    square([494+clearance,650], center=true);
    }
    intersection() {
    circle((473+clearance)/2, $fn=96);
    square([294+clearance,550], center=true);
    }}
}

module gear_housing0()
{
    difference() {
    square([493+clearance, 570+clearance], center=true);
    square([393+clearance, 470+clearance], center=true);
    }
}

module gear_housing1()
{
    difference() {
    square([593+clearance, 670+clearance], center=true);
    square([393+clearance, 470+clearance], center=true);
    }
}

module motor_housing()
//scale(ViewScale)
{
    linear_extrude(50)
    motor_housing_cap();
    translate([0, 0, 49])
    linear_extrude(600)
    motor_housing_body();
    translate([0, 0, 648])
    linear_extrude(365)
    gear_housing0();

    translate([0, 0, 648+365-166-50])
    linear_extrude(50)
    gear_housing1();

}

