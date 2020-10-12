ViewScale = [0.0254, 0.0254, 0.0254];

module arduino()
{
    translate([0, 0, 82+36])
    linear_extrude(60)
    square([794, 760]);

    translate([0, 0, 36])
    linear_extrude(82){
    square([794, 760]);
    translate([156, 760, 0])
    square([486, 430]);
    }
    linear_extrude(36)
    translate([270, 270, 0])
    square([310, 310]);
}


module model_button()
{
    linear_extrude(136)
    square([470, 470], center=true);
    translate([0, 0, 136])
    linear_extrude(30)
    circle(308/2, $fn=96);

    for(jj = [470/2+180/2,-470/2-180/2]) {
        for(ii = [-100,100]) {
            translate([jj, ii, 0])
            linear_extrude(40)
            square([180, 40], center=true);
        }
    }
}

module buttoncase()
{
    *translate([0, 0, 400]) {
        *translate([0, 0, 50])
        color("cyan")
        model_button();

//        *#linear_extrude(50)
//        square([480, 480], center=true);

        //translate([0, 0, 49])
        linear_extrude(120)
        difference() { 
            square([580, 580], center=true);
            square([480, 480], center=true);
            for(ii = [-100,100]) {
                translate([0, ii, 0])
                square([600, 60], center=true);
            }
        }

        *linear_extrude(500, center=true, scale=0.58)
        square([1000, 1000], center=true);
    }

    linear_extrude(100)
    circle(1000, $fn=96);
    
    translate([0, 0, 99]) {
        linear_extrude(141)
        difference() {
            circle(1000, $fn=96);
            circle(900, $fn=96);
            translate([1000, 0, 0])
            square([400, 150], center=true);
        }
    }

//    *translate([0, 0, 49]) {
//        linear_extrude(401)
//        square([480, 480], center=true);
//    }

    translate([0, 0, 239])
    linear_extrude(281)
    difference() {
        circle(1000, $fn=96);
        circle(900, $fn=96);
    }

    linear_extrude(300)
    color("darkgreen") {
        translate([0, 450, 100])
        square([830, 100], center=true);

        translate([-570, 300, 100])
        square([400, 100], center=true);

        translate([0, -460, 100])
        square([830, 100], center=true);

        translate([-570, -300, 100])
        square([400, 100], center=true);

        translate([460, 0, 100])
        square([100, 1000], center=true);
    }

}

module lid()
{
    linear_extrude(70)
    difference() {
        circle(1000, $fn=96);
        square([580, 580], center=true);
    }

    translate([0, 0, -150]) {
        *translate([0, 0, 50])
        color("cyan")
        model_button();
        linear_extrude(50)
        square([480, 480], center=true);

//        *#linear_extrude(50)
//        square([480, 480], center=true);

        //translate([0, 0, 49])
        linear_extrude(220)
        difference() { 
            square([580, 580], center=true);
            square([480, 480], center=true);
            for(ii = [-100,100]) {
                translate([0, ii, 0])
                square([600, 60], center=true);
            }
        }

    }

    translate([0, 0, -150])
    linear_extrude(151)
    difference() {
        circle(890, $fn=96);
        circle(840, $fn=96);
    }

    *translate([0, 0, -100])
    model_button();
}

scale(ViewScale)
{
    *buttoncase();
    translate([0, 0, 1520])
//    color("cornflowerblue")
    lid();
    *color("royalblue")
    translate([400, -400, 100])
    rotate([0, 0, 90])
    arduino();
}
