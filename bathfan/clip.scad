ViewScale = [0.0254, 0.0254, 0.0254];


circumcenter_d = function (a,b,c) 2*((a[0]*(b[1]-c[1])) + (b[0]*(c[1]-a[1])) + (c[0]*(a[1]-b[1])));
circumcenter_x = function (a,b,c) (1/circumcenter_d(a,b,c)) *
    (((pow(a[0],2) + pow(a[1],2))*(b[1]-c[1])) +
    ((pow(b[0],2) + pow(b[1],2)) * (c[1]-a[1])) +
    ((pow(c[0],2) + pow(c[1],2)) * (a[1]-b[1])));

circumcenter_y = function (a,b,c)  (1/circumcenter_d(a,b,c)) *
    (((pow(a[0],2) + pow(a[1],2))*(c[0]-b[0])) +
    ((pow(b[0],2) + pow(b[1],2)) * (a[0]-c[0])) +
    ((pow(c[0],2) + pow(c[1],2)) * (b[0]-a[0])));


// module circumcenter(a, b, c)
// {
//     d=2*((a[0]*(b[1]-c[1])) + (b[0]*(c[1]-a[1])) + (c[0]*(a[1]-b[1])));
//     x = (1/d) * (((pow(a[0],2) + pow(a[1],2))*(b[1]-c[1])) + ((pow(b[0],2) + pow(b[1],2)) * (c[1]-a[1])) + ((pow(c[0],2) + pow(c[1],2)) * (a[1]-b[1])));
//     y = (1/d) * (((pow(a[0],2) + pow(a[1],2))*(c[0]-b[0])) + ((pow(b[0],2) + pow(b[1],2)) * (a[0]-c[0])) + ((pow(c[0],2) + pow(c[1],2)) * (b[0]-a[0])));
//     echo("X ",x," Y ",y);
//     return x,y;
// }

module template(pad=0)
{
    l=500;
    w=200;
    ofs=100;
    abc=[[0, 0],[l,w],[l,-w]];
    x = circumcenter_x([0, 0],[l,w],[l,-w]);
    y = circumcenter_y([0, 0],[l,w],[l,-w]);
    echo("X ",x," Y ",y);

    translate([ofs, 0, 0])
    scale([pad, pad])
    translate([-x, 0, 0])
    polygon([[0, 0], [l, w], [l, -w]]);

    translate([-ofs, 0, 0])
    rotate([0, 0, 180])
    scale([pad, pad])
    translate([-x, 0, 0])
    polygon([[0, 0], [l, w], [l, -w]]);
}

module ruler(len)
{
    for(ii=[0:200:len]) {
        translate([ii, 0, 0])
        square([100, 100], center=true);
    }
}

module testmount()
{
    linear_extrude(100)
    translate([-250, 0, 0])
    square([500, 1000], center=true);

    translate([0, 0, 99])
    linear_extrude(100)
    translate([-500, 0, 0])
    intersection() {
        difference() {
            template(1.3);
            template(1.1);
        }
        translate([500, 0, 0])
        square([1000, 1000], center=true);
    }
}

module forViewing()
{
    testmount();

    translate([-500, 0, 99])
    linear_extrude(100)
    template(1.0);
//    ruler(1000);
//    difference() {
//        template(1.1);
//        template(1.0);
//    }
}

module forPrinting()
{
    linear_extrude(100)
    template(1.025);
    //testmount();
}

scale(ViewScale)
{
    forPrinting();
   // forViewing();
}
