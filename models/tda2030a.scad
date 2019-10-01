ViewScale = [0.0254, 0.0254, 0.0254];


module tda2030a()
{
    xs=1267;
    ys=951;
    color("Cyan")
    linear_extrude(62)
    square([xs, ys], center=true);
    
    color("CornflowerBlue")
    {
        // heatsink
        translate([-xs/2+589/2+350, ys/2-394/2+69, 61])
        linear_extrude(810)
        square([589, 394], center=true);
        // cap1
        translate([-xs/2+196/2+111, ys/2-195/2-210, 61])
        linear_extrude(337)
        circle(196/2, $fn=96);
        // cap2
        translate([xs/2-320/2, ys/2-320/2-133, 61])
        linear_extrude(500)
        circle(320/2, $fn=96);
        // pot
        translate([-xs/2+300/2+150, ys/2-250/2-430, 61])
        linear_extrude(300)
        square([200, 250], center=true);
        // terminal
        translate([xs/2-300/2, -ys/2+383/2+10, 61])
        linear_extrude(300)
        square([300, 383], center=true);
        // pins
        translate([-xs/2+100/2, -ys/2+400/2+100, 61])
        linear_extrude(300)
        square([100, 400], center=true);
        // discretes 1
        translate([-xs/2+220/2+120, ys/2-170/2-40, 61])
        linear_extrude(46)
        square([220, 170], center=true);
        // discretes 2
        translate([xs/2-220/2-80, ys/2-80/2-40, 61])
        linear_extrude(46)
        square([220, 80], center=true);
        // discretes 3
        translate([-xs/2+363/2+480, -ys/2+480/2+40, 61])
        linear_extrude(46)
        square([363, 480], center=true);
        // discretes 4
        translate([-xs/2+180/2+237, -ys/2+160/2+40, 61])
        linear_extrude(46)
        square([180, 160], center=true);
    }
}

//scale(ViewScale)
//{
//    tda2030a();
//}
