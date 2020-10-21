ViewScale = [0.0254, 0.0254, 0.0254];


module epdHolderBodyTemplate()
{
    difference() {
        square([150, 150]);
        translate([25, 50, 0])
        square([20, 100]);
        translate([100, 0, 0])
        square([50, 100]);
    }
    square([25, 801]);
}


module epdHolderMain()
{
    rotate_extrude(angle=52.5, $fn=96) {
        translate([3000, 0, 0])
        epdHolderBodyTemplate();
        translate([3000, 1600, 0])
        scale([1.0, -1.0, 1.0])
        epdHolderBodyTemplate();
    }

//    rotate_extrude(angle=45, $fn=96)
 //   translate([1500, 0, 0])
//    rotate([0,0, 180])
//    scale(
//    !epdHolderBodyTemplate();
    
}

module endcap()
{
    translate([3000, -100, 100])
    linear_extrude(1400) {
        difference() {
            square([150, 130]);
            translate([25, 30, 0])
            square([20, 101]);
            translate([100, 0, 0])
            square([50, 50]);
        }
        *color("cyan")
        translate([0, -20, 0])
        cliptemplate();
    }
}

module endcap2()
{
    rotate([0, 0, 52.5])
    translate([3000, 0, 100])
    linear_extrude(1400)
    difference() {
        square([150, 320]);
        translate([25, 0, 0])
        square([30, 350]);
        translate([100, 50, 0])
        square([50, 300]);
    }
}

// 3150 x 1500
// displayable 2750 + 80 + 320
module model()
{
    translate([3025, -120, 50])
    color("red")
    linear_extrude(1500)
    square([20, 100]);
}

module model_board()
{
    color("cyan")
    linear_extrude(70)
    difference() {
        // board
        hull() {
        circle(138, $fn=96);
        translate([974, 0, 0])
        circle(138, $fn=96);
        translate([0, 413, 0])
        circle(138, $fn=96);
        translate([974, 413, 0])
        circle(138, $fn=96);
        }
        // holes
        circle(60, $fn=96);
        translate([974, 0, 0])
        circle(60, $fn=96);
        translate([0, 413, 0])
        circle(60, $fn=96);
        translate([974, 413, 0])
        circle(60, $fn=96);
    }
    color("cornflowerblue")
    translate([0, 0, 70])
    linear_extrude(80) {
    translate([974/2-610/2, -150, 0])
    square([610, 230]);
    translate([974/2-610/2, 320, 0])
    square([610, 230]);
    }
}

module boardmount()
{
//    translate([138, 138, 52])
//    model_board();
    boardW = 974+138*2;
    boardL = 413+138*2+20;

    linear_extrude(50)
    square([boardW, boardL]);
    translate([138, 138, 40]) {
        linear_extrude(140) {
        circle(50, $fn=96);
        translate([974, 0, 0])
        circle(50, $fn=96);
        translate([0, 413, 0])
        circle(50, $fn=96);
        translate([974, 413, 0])
        circle(50, $fn=96);
    }}
    // extended base
    translate([0, boardL, 0])
    linear_extrude(50)
    square([boardW, 300]);

    // square flush with the connector
    translate([boardW/2-375, boardL, 49])
    linear_extrude(101)
    square([750, 300]);

    // side supports
    translate([boardW/2-250-120, boardL, 149])
    linear_extrude(51)
    square([100, 300]);

    translate([boardW/2+250-+0, boardL, 149])
    linear_extrude(51)
    square([100, 300]);

    // square above slot
    translate([boardW/2-370, boardL, 199])
    linear_extrude(41)
    square([720, 300]);
}

module link()
{
    for(ii = [250, 800, 1350])
    {
        translate([0, 0, ii])
        rotate([0, 0, 55])
        rotate_extrude(angle=15, $fn=96) 
        translate([2980, 0, 0])
        square([50, 100]);
    }
}

module cliptemplate()
{
    union() {
        translate([150, -30, 0])
        square([50, 180]);
        translate([30, -80, 0])
        square([170, 50]);
    }
}

module clip()
{
    rotate_extrude(angle=52.5, $fn=96) {
        translate([3000, 0, 0])
        cliptemplate();
        translate([3000, 1600, 0])
        scale([1.0, -1.0, 1.0])
        cliptemplate();
    }
    translate([3000, 0, -80]) {
        translate([30, -230, 0]) 
        linear_extrude(50)
        square([170, 230]);

        translate([0, -150, 49]) 
        linear_extrude(1671)
        cliptemplate();

        translate([30, -230, 1710]) 
        linear_extrude(50)
        square([170, 230]);
    }

    // linear_extrude(1760) 
     *translate([0, -20, 0]) {
        cliptemplate();
        #translate([30, -80, 0])
        square([170, 230]);
     }

    rotate([0, 0, 52.5]) 
    translate([3150, 0, -80]) {
        linear_extrude(50)
        translate([-120, 0, 0])
        square([150, 150]);

        //translate([0, 0, 0])
        linear_extrude(1760)
        square([50, 150]);

        translate([-120, 0, 1710])
        linear_extrude(50)
        square([150, 150]);
    }
}

module forViewing()
{
    model();

     epdHolderMain();
     endcap();
     endcap2();
     rotate([0, 0, 52.5+21-3.7])
     translate([3000, -200, 1600/2+(974+138*2)/2+35])
     rotate([0, 90, 0]) {
         boardmount();
     }
     link();
     color("cyan")
    clip();
}


scale(ViewScale)
{
    forViewing();
}
