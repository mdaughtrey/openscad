ViewScale = [0.0254, 0.0254, 0.0254];

module cutouts()
{
    translate([0, 60, 0])
    square([1000,40], center=true);
    translate([0, -60, 0])
    square([1000,40], center=true);

    translate([60, 0, 0])
    square([40,1000], center=true);
    translate([-60, 0, 0])
    square([40,1000], center=true);
}

module outerfins()
{
    for(ii=[0:90:360]) {
        rotate([0,0,ii])
        translate([40,295,0])
        rotate([0, -90, 0])
        linear_extrude(80)
        polygon(points=[[0,0],[250,0],[100,50],[0,50]]);
    }
}

module innerfins()
{
    for(ii=[0:90:360]) {
        rotate([0,0,ii])
        translate([-40,-440/2-10,0])
        rotate([180, 90, 180])
        linear_extrude(80)
        polygon(points=[[0,0],[200,0],[0,100]]);
    }
}

scale(ViewScale)
{
    // base
    linear_extrude(950)
    difference() {
        circle(600/2, $fn=96);
        circle(460/2, $fn=96);
    }
    // thin bas
    translate([0, 0, 949])
    linear_extrude(120)
    difference() {
        circle(550/2, $fn=96);
        circle(440/2, $fn=96);
    }
    // thin cutout
    translate([0, 0, 1068])
    linear_extrude(310)
    difference() {
        circle(550/2, $fn=96);
        circle(440/2, $fn=96);
        cutouts();
    }
    // thick cutout
    translate([0, 0, 1377])
    linear_extrude(325)
    difference() {
        circle(600/2, $fn=96);
        circle(440/2, $fn=96);
        cutouts();
    }
    // outerfins
    translate([0, 0, 1377])
    outerfins();
    // inner fins
    translate([0, 0, 1702])
    innerfins();

}
