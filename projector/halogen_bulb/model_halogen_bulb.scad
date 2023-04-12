//ViewScale = [0.0254, 0.0254, 0.0254];

$fn=96;

module model_halogen_bulb()
{
    linear_extrude(340)
    {
        circle(40/2);
        translate([140, 0, 0])
        circle(40/2);
    }
    translate([-350/2+70, -125/2, 339])
    linear_extrude(335)
    square([350, 125]);
    translate([70, 0, 670])
    linear_extrude(400)
    circle(322/2);

    translate([70, 0, 1060])
    linear_extrude(140)
    circle(140/2);
}

module model_halogen_holder()
{
    a=325/2+133/2;
    b=-a;
    c=325/2+133/2;
    d=-c;

    xa=153;
    xb=160;
    xc=133;

    linear_extrude(xa)
    intersection() {
        rotate([0, 0, 45])
        square([330, 545], center=true);
        difference() {
            circle(545/2);
            translate([c, 0, 0])
            circle(200/2);
            translate([d, 0, 0])
            circle(200/2);

        }
    }

    translate([0, 0, xa-1])
    linear_extrude(xb)
    difference() {
        circle(643/2);
        translate([a, 0, 0])
        circle(133/2);
        translate([b, 0, 0])
        circle(133/2);
    }
    translate([0, 0, xa+xb-1])
    linear_extrude(xc)
    difference() {
        circle(643/2);
        translate([c, 0, 0])
        circle(200/2);
        translate([d, 0, 0])
        circle(200/2);

        rotate([0, 0, 45]) {
            translate([140/2, 0, 0])
            circle(63/2);
            translate([-140/2, 0, 0])
            circle(63/2);
    }

    }
} 

//module forViewing()
//{
//    color("cornflowerblue")
//    translate([70, 0, 0])
//    rotate([0, 0, -45])
//    model_halogen_holder();
//    translate([0, 0, 160])
//    model_halogen_bulb();
//
//}
//
//module forPrinting()
//{
//}
//
//scale(ViewScale)
//{
//    forViewing();
//}
