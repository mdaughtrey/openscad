ViewScale = [0.0254, 0.0254, 0.0254];

extension = 0;
rows = 3;
cols = 3;
facemils = 40;
module cell()
{
    //rotate([180, 0, 0]) {
    linear_extrude(310+extension)
    difference() {
        square(300, center=true);
        square(254, center=true);
    }
    translate([0, 0, 310+extension])
    linear_extrude(facemils)
    square(300, center=true);
    //}
}


scale(ViewScale)
{
    // cells
    translate([-(rows * 100), -(cols*100), 0])
    for (jj = [0:300:(rows-1)*300]) {
    for (ii = [0:300:(cols-1)*300]) {
        translate([ii, jj, 0]) cell();
    }}

    // outer box
    translate([0, 0, -40 + facemils]) 
    linear_extrude(350 + extension)
    difference() {
        square(rows * 300 + 100, center=true);
        square(cols * 300, center=true);
    }
}

