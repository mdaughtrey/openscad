ViewScale = [0.0254, 0.0254, 0.0254];


// Circle translate, extrude, diameter, fh
module cted(t,e,d,f=96) { translate(t) linear_extrude(e) circle(d/2, $fn=f); }
// Square translate, extrude, x, y
module stexy(t,e,xy) { translate(t) linear_extrude(e) square(xy, center=true); }

module cutouts()
{
    translate([0, (-1734/2)+230-1, 0])
    square([77, 460], center=true);
    translate([423, (-1734/2)+230-1, 0])
    square([77, 460], center=true);
    translate([-423, (-1734/2)+230-1, 0])
    square([77, 460], center=true);
}

module model_batteryclip()
{
    linear_extrude(190)
    {
        translate([0, (-1734/2)-125+250+1300, 0])
        square([1866, 250], center=true);
        difference() {
            square([1566, 1734], center=true);
            cutouts();
        }
    }
    translate([0, 0, 189])
    linear_extrude(251) {
        translate([0, (-1734/2)-125+250+1300, 0])
        square([1866, 250], center=true);
        difference() {
            translate([0, -434/2, 0])
            square([1866, 1300], center=true);
            cutouts();
            translate([0, (-1734/2)+1150, 0]) 
            circle(275/2, $fn=96);
        }
    }
    translate([0, 0, 189+251-90])
    linear_extrude(90)
    difference() {
        square([1866, 1734], center=true);
        translate([0, (-1734/2)+1150, 0]) 
        circle(275/2, $fn=96);
        cutouts();
    }
    // Platform
    stexy([0,(-1734/2)-500,-200],200,[1866,1000]);
    // 45 deg slop
    translate([1866/2,(-1734/2)-1000,-200])
    rotate([90,0,0])
    rotate([0,-90,0])
    linear_extrude(1866)
    polygon([[0,0],[200,0],[0,200],[0,0]]);


}

module model_aviation_connector_3pin()
{
    // Legs
    linear_extrude(186)
    for(ii=[0:120:360]) {
        rotate([0, 0, ii])
        translate([75, 0, 0])
        circle(60/2, $fn=96);
    }

    translate([0, 0, 185])
    linear_extrude(357)
    intersection() {
        circle(458/2, $fn=96);
        square([423, 1000],center=true);
    }

    translate([0, 0, 540])
    linear_extrude(71)
    circle(583/2, $fn=96);

    translate([0, 0, 610])
    linear_extrude(197)
    intersection() {
        circle(458/2, $fn=96);
        square([423, 1000],center=true);
    }

    // Nut
    translate([0, 0, 540-127])
    linear_extrude(137)
    circle(663/2, $fn=6);
}

module model_boost_buck_converter()
{
    stexy([0,0,0],731,[2800,1530]);    // Components
    stexy([0,0,730],880,[2800,1530]);        // Body
    stexy([0,0,1609],81,[3100,1660]);         // Lip
    cted([(2800/2)-600,0,1699],535,544);   // Knob
    stexy([(-2800/2)-(65/2),0,1150],443,[65,470]); // Side tab
    stexy([(2800/2),0,1150],443,[65,470]); // Side tab
}

module model_pcbtabs()
{
    linear_extrude(450)
    {
        translate([0, (-1734/2)+230-1, 0])
        square([65, 750], center=true);
        translate([423, (-1734/2)+230-1, 0])
        square([65, 750], center=true);
        translate([-423, (-1734/2)+230-1, 0])
        square([65, 750], center=true);
    }
}

module clip()
{
    module tabsurrounds()
    {
        for (ii=[0,423,-423]) {
            translate([ii, (-1734/2)+700, 0])
            difference() {
                square([175, 350], center=true);
                translate([0,50,0])
                square([85, 350], center=true);
            }
        }

        *translate([423, (-1734/2)+230-1, 0])
        square([85, 750], center=true);
        *translate([-423, (-1734/2)+230-1, 0])
        square([85, 750], center=true);
    }
    translate([0, 0, 20])
    linear_extrude(150)
    {
        difference() {
            difference() {
            translate([0, -775, 0])
            square([2066, 3184], center=true);
            translate([0, -750, 0])
            square([1616, 3254], center=true);
            translate([0, (-1734/2)-125+250+1300, 0])
            square([1896, 280], center=true);
            *translate([0, -200, 0])
            cutouts();
            }
        }
        *translate([0,-900,0])
        tabsurrounds();
    }

    translate([0, 0, 169])
    linear_extrude(301)
    {
        difference() {
            difference() {
            translate([0, -775, 0])
            square([2066, 3184], center=true);
            translate([0, -750, 0])
            square([1896, 3254], center=true);
            translate([0, (-1734/2)-125+250+1300, 0])
            square([1896, 280], center=true);
            *translate([0, -200, 0])
            cutouts();
            }
        }
        translate([0,-900,0])
        tabsurrounds();
    }
    translate([0, -100, 469])
    linear_extrude(50)
    difference() {
            translate([0, -675, 0])
            square([2066, 3184], center=true);
//        square([2066, 1264], center=true);
        translate([0, (-1734/2)+1250, 0]) 
        circle(675/2, $fn=96);
    }
    // Connector face
    translate([0, -2300, 70])
    rotate([90,0,0])
    linear_extrude(100)
    difference() {
        square([2066, 900],center=true);
        intersection() {
            circle(478/2, $fn=96);
            square([443, 1000],center=true);
        }
    }


}

module forViewing()
{
    *color("royalblue") {
        model_batteryclip();
    }
    color("oldlace")
    translate([0, -1850, 50])
    rotate([90,0,0])
    model_aviation_connector_3pin();
    clip();
    *color("burlywood")
    translate([0,-200,0])
    model_pcbtabs();
}

module forPrinting()
{
    clip();
}

scale(ViewScale)
{
//    model_boost_buck_converter();
//    forViewing();
    forPrinting();
}
