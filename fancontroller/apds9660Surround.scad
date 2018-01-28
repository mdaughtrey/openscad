module side(l,d)
{
    rotate([90, 0, 0])
    translate([-d, 0, -l/2])
    linear_extrude(l)
    polygon(points=[[0, 0], [d, 0],[d, d]]);
}

module sides(w, h, d)
{
    union() {
   translate([h/2, 0, 0])  rotate([0, 0, 0]) side(w,d);
   translate([-h/2, 0, 0])  rotate([0, 0, 180]) side(w,d);

   translate([0, w/2, 0])  rotate([0, 0, 90]) side(h,d);
   translate([0, -w/2, 0])  rotate([0, 0, -90]) side(h,d);
    }
}

//// w,h,d 
//sides(500, 600, 100);
//
//linear_extrude(100)
//difference(){
//    square([800, 700], center=true);
//    square([600, 500], center=true);
//}
