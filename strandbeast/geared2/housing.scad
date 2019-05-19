ViewScale = [0.0254, 0.0254, 0.0254];
clearance = 25;

module motor_housing()
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

module gear_housing()
{
    difference() {
    square([493+clearance, 570+clearance], center=true);
    square([393+clearance, 470+clearance], center=true);
    }
}

//module housing()
//scale(ViewScale)
module motorhousing()
{
    //model_geared2();
    linear_extrude(700)
    motor_housing();
    translate([0, 0, 700])
    linear_extrude(365)
    gear_housing();
}

