ViewScale = [0.0254, 0.0254, 0.0254];

include <../../BOSL2-master/std.scad>
include <model_psu_12v.scad>

model=1;
// model_psu12v_dim=[8740,4475,1960];

module mount0()
{
//    module box() {
    diff() { cuboid([2000,4675,2160],anchor=LEFT) {
        tag("remove") {
            // Inside
            position(RIGHT) left(100) cuboid([1901,4515,2000],anchor=RIGHT);
            // Front vents
            position(LEFT+FRONT) right(150) fwd(1) cuboid([810,201,980],rounding=60,edges="Y",anchor=LEFT);
            // Rear vents
            position(LEFT+BACK) right(150) back(1) cuboid([810,201,980],rounding=60,edges="Y",anchor=LEFT);
            // BX Cutout
            position(RIGHT+BACK) left(1) fwd(1000) up(300) yrot(90) cyl(r=500,h=200,$fn=96);
            // Grid cutout
            position(RIGHT+FRONT) back(1500) yrot(90) grid_copies(300,n=[5,8]) cyl(r=75,h=201);
        }
        tag("keep") {
            // Inner inset
            position(RIGHT+BOT) up(80) cuboid([930,4675,100],anchor=RIGHT+BOT);
            // Front foot
            position(FRONT+BOT) cuboid([500,300,200],anchor=BACK+BOT) 
            attach(FRONT) up(75) xrot(90) tube(id=150,od=500,h=200);
            // Back foot
            position(BACK+BOT) cuboid([500,300,200],anchor=FRONT+BOT) 
            attach(BACK) up(75) xrot(90) tube(id=150,od=500,h=200);

        }

    }}// } // box

//        }

}

module forViewing()
{
  model_psu12v();
    recolor("yellow") right(3300) mount0();
//union() {
//    diff() {
//        cuboid([1000,1000,1000]) {
//        tag("remove") cuboid([2000,600,600]);
//        }
//    }
//    position(FRONT) minkowski_difference()
//    {
//        cuboid([1000,200,1000],anchor=BACK) position(BACK) cuboid([400,400,400],anchor=BACK);
//        sphere(r=50);
//    }
//}
}

module forPrinting()
{
    mount0();
}

scale(ViewScale)
{
    forViewing();
//    forPrinting();
}
