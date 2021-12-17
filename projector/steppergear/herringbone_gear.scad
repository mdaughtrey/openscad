//ViewScale = [0.0254, 0.0254, 0.0254];
$fn = 180;
function hb_base_face (r, d, mod) = [for(angle = [0: 360/$fn: 360-360/$fn]) [
    cos(angle)*(r + abs(angle%mod-mod/2)/mod*2*d - d/2),
    sin(angle)*(r + abs(angle%mod-mod/2)/mod*2*d - d/2)
  ]];

module hb_gear_base(diam=20, number=10) {
  render()
    polygon(hb_base_face(diam/2, diam/number*1.5, 360/number));
}

module herringbone_gear(diam=20, number=10, h = 5, orient = 1) {
  render()
    linear_extrude(height = h/2, twist = sign(orient)*90*h/diam)
      hb_gear_base(diam, number);
  translate([0, 0, h/2])
    rotate(-sign(orient) * 90*h/diam)
      render()
        linear_extrude(height = h/2, twist = -sign(orient) * 90*h/diam)
          hb_gear_base(diam, number);
}

//module cutout(e, o, i)
//{
//    linear_extrude(e)
//    difference()
//    {
//        circle(o/2, $fn=96);
//        circle(i/2, $fn=96);
//        square([o, i/2], center=true);
//        square([i/2, o], center=true);
//    }
//}
//
//module forViewing()
//{
//    rotate(90)
//    difference()
//    {
//        gear(1000, 20, 250);
//        translate([0, 0, -1])
//        {
//            cutout(300, 800, 300);
//            linear_extrude(300)
//            circle(170/2, $fn=96);
//        }
//    }
//    translate([1100,0])
//    difference()
//    {
//        gear(1000, 20, 250, -1);
//        translate([0, 0, -1])
//        {
//            cutout(300, 800, 300);
//            linear_extrude(300)
//            circle(170/2, $fn=96);
//        }
//    }
//}
//
//scale(ViewScale)
//{
//    forViewing();
//}
