ViewScale = [0.0254, 0.0254, 0.0254];
include <collars.scad>

model=1;

module model_projector_lens()
{
    linear_extrude(250)
    circle(1240/2, $fn=96);
    translate([0, 0, 249])
    linear_extrude(1641)
    circle(1000/2, $fn=96);

    translate([0, 0, 1889])
    linear_extrude(201, scale=0.75)
    circle(1000/2, $fn=96);

}

module projector_lens_mount()
{
    // Insert collar
    tabbed_insert_collar();
    linear_extrude(520)
    difference() {
        circle(1470/2, $fn=96);
        circle(1340/2, $fn=96);
    }

    // Body
    *translate([0, 0, 319])
    linear_extrude(321)
    difference() {
        circle(1470/2, $fn=96);
        circle(1340/2, $fn=96);
    }
    translate([0, 0, 250]) 
    linear_extrude(1350) 
    intersection() {
        difference() {
            circle(1350/2, $fn=96);
            circle(1015/2, $fn=96);
        }
        union() {
            square([2000, 200], center=true);
            square([200, 2000], center=true);
        }
    }
    translate([0, 0, 1451]) 
    linear_extrude(650)
    difference() {
        circle(1600/2, $fn=96);
        circle(1340/2, $fn=96);
    }


    translate([0, 0, 2090])
    tabbed_accept_collar();


}

module forViewing()
{
    if (model) {
        color("tan")
        model_projector_lens();
    }
    projector_lens_mount();
}

module forPrinting()
{
//   frontend();
//    backend();
//    backend_tilt2();
    projector_lens_mount();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
