ViewScale = [0.0254, 0.0254, 0.0254];
include <collars.scad>
include <../../BOSL2-master/std.scad>

model=0;

module b2tabs(id=1360,h=300,anchor=CENTER)
{
    $fn=96;
    tube(od=1460,id=id,h=h,anchor=anchor)
    zrot_copies(n=3) position(RIGHT+BOTTOM) cube([100,180,120],anchor=LEFT+BOTTOM);
}

module b2insert()
{
    $fn=96;
    diff()
    tube(od=1600,id=1490,h=300) {
    tag("remove") zrot_copies(n=3) up(1) left(120)  position(RIGHT+TOP) cube([200,200,152],anchor=LEFT+TOP);
    tag("remove") zrot_copies(n=3) back(100) left(120) down(1) position(RIGHT+BOT) cube([200,400,151],anchor=LEFT+BOT);
    }
}


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
    //b2tabs(id=1340,h=520,anchor=BOT);
    tabbed_collar(id=1340,h=520,anchor=BOT);
    // Insert collar
    //tabbed_insert_collar();
    //b2tabs();
    *#linear_extrude(520)
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


    translate([0, 0, 2250])
    tabbed_accept_collar();


}

module forViewing()
{
    *if (model) {
        color("tan")
        model_projector_lens();
    }
    projector_lens_mount();

//    up(2260) recolor("cyan") zrot(15) b2tabs();
//    up(2960) recolor("cyan") zrot(15) b2insert();
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
    forViewing();
//    forPrinting();
}
