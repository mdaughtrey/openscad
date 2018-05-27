ViewScale = [0.0254, 0.0254, 0.0254];

module tabs()
{
    // right tabs - top 
    translate([50, 2620-750-50, 0])
    square([100, 750]);
    translate([50+500, 2620-250-50, 0])
    square([340, 250]);
    translate([50+1130, 2620-250-50, 0])
    square([340, 250]);

    // left tabs - top
    translate([50, 50+260, 0])
    square([200, 260]);
    translate([50+570, 50, 0])
    square([180, 200]);
    translate([50+1180, 50, 0])
    square([100, 200]);
}

module bms()
{
    linear_extrude(100)
    difference() {
    square([1990+100, 2750]);
    translate([150, 150, 0])
    square([1790, 2300]); 
    tabs();
    }

    translate([0, 0, 100])
    linear_extrude(70)
    difference() {
    square([1990+100, 2750]);
    translate([50, 50, 0])
    square([2100, 2520]); }

    translate([0, 0, 170])
    linear_extrude(50)
    difference() {
    square([1990+100, 2500+120]);
    translate([50, 50, 0])
    square([2100, 2520]); }


}


scale(ViewScale)
{
    bms();
    translate([0, 0, 170])
    linear_extrude(50)
    tabs();
}
