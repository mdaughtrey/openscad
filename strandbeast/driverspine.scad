include <defs.scad>
use <MCAD/involute_gears.scad>
RealityScale = 1.27;
RealityVec=[RealityScale, RealityScale, RealityScale]; 
ViewScale=[.02,.02,.02];
//ViewScale=[.02*RealityScale,.02*RealityScale,.02*RealityScale];

motorR = 190;
motorR2 = 163;
shroudOffset = 100;

useShroud = 1;
useUpperCam = 1;
useLowerCam = 1;
useCap = 1;
useBigCog = 0;
useMotorCog = 1;

module cutout()
{
    cutoutR = motorR+10;
    cutoutR2 = motorR2+20;
    difference() {
    cylinder(393, r=cutoutR, $fn=96);
    union() {
    translate([cutoutR2, -cutoutR2, -1]) cube([50, motorR*2, 297]);
    translate([-cutoutR2-50, -cutoutR2, -1]) cube([50, motorR*2, 297]);
    }}
}

//module mount()
//{
//    difference() // lower mount
//    {
//        cylinder(293, r=motorR+100, $fn=96);
//        translate([0, 0, -1]) cylinder(293+2, r=motorR+10, $fn=96);
//    }
//}

d1=60;// diameter of lower ring
t=100;// thickness of all gears
t1=1.2;// thickness of ring faces
b=0.25;// backlash
c=0.2;// clearance
pa=20;// pressure angle
s=0.4;// vertical clearance
td=0.8;// thickness of planet disk
pd=1.1;// planet disk diameter / pitch diameter
dp=0.85;// ring gear diameter / outside ring diameter

ns=6;// number of teeth on sun (lower)
np1=18;// number of teeth on lower planet
delta=-1;// difference in teeth between upper and lower

//--------- Don't edit below here unless you know what you're doing.

nr1=ns+2*np1;// number of teeth on lower ring
pitch=nr1/(d1*dp);// diametral pitch of all gears
nr2=nr1+delta;
np2=np1+delta;

pitch=1/20;
np2=18;

mcTeeth = 12;
mcPitch = 1/30;
mcClearance = 20;
mcThickness = 100;
//mcRadius =  mcPitch * mcTeeth / 3.14159 / 2 * 1000;
mcRadius = mcTeeth / mcPitch /2;
echo("mc radius ", mcRadius);

bcTeeth = mcTeeth * 3;
bcPitch = mcPitch;
bcClearance = 20;
bcThickness = 100;
//bcRadius = bcPitch * bcTeeth / 3.14159 / 2 * 1000;
bcRadius = bcTeeth / bcPitch/2;
echo("mc radius ", mcRadius);
echo("bc radius ", bcRadius);


module motorCog(cutout)
{
    difference() {
	gear(number_of_teeth=mcTeeth,
		diametral_pitch=mcPitch,
		gear_thickness=mcThickness,
		rim_thickness=mcThickness,
		hub_thickness=mcThickness,
		bore_diameter=0,
		backlash=b,
		clearance=c,
		pressure_angle=pa);
    //    cylinder(110, r=200, $fn=48);
        translate([0, 0, -1]) scale([1, 1, 1.02]) cylinder(110, r=cutout, $fn=6);
    }
}

module bigCog(cutout)
{
    difference() {
        union() {
            cylinder(240, r=110, $fn=96);
            gear(number_of_teeth=bcTeeth,
                diametral_pitch=bcPitch,
                gear_thickness=100,
                rim_thickness=100,
                hub_thickness=100,
                bore_diameter=0,
                backlash=b,
                clearance=bcClearance,
                pressure_angle=pa);
        }
        translate([0, 0, -1]) scale([1, 1, 1.02]) wheelCutouts(4, 100, 200, 420);
    }
}

module motormount() {
//    translate([0, 0, mcThickness + (mcClearance * 2)]) {
    radius = mcRadius * 4 / 3;
    thickness = mcThickness + (mcClearance * 2);
    difference() {
        union() {
            translate([0, 0, thickness + 99])
                cylinder(500+shroudOffset, r=motorR+100, $fn=96); // main mount
            // cog wheel shroud and cutout
            difference() {
                cylinder(thickness + 100, r=radius + 50, $fn=96);
                translate([0, 0, -1]) cylinder(thickness+1, r=radius,  $fn=96);
            }
        }
        translate([0, 0, 1+shroudOffset]) scale([1, 1, 1.01])
        scale([1, 1, 1.01])
        union(){ // circle with insets
            translate([0, 0, 291+thickness]) cutout();
            cylinder(292+thickness, r=motorR+20, $fn=96);
        }
    }
}

module bcShroud()
{
    // Big cog shroud
    union() {
        // big cog wheel shroud and cutout
        difference() {
            thickness = bcThickness + (bcClearance * 2);
            difference() {
                cylinder(thickness + 100 + shroudOffset, r=bcRadius + 100, $fn=96);
                union() {
                translate([0, 0, thickness-1+shroudOffset]) scale([1, 1, 1.02]) wheelCutouts(4, 100, 200, 420);
                // cutout from buttom
                translate([0, 0, -1]) cylinder(thickness+1+shroudOffset, r=bcRadius + bcClearance * 3,  $fn=96);
                // hole in top
                translate([0, 0, thickness-1+shroudOffset]) cylinder(thickness+1, r=120,  $fn=96);

                }
            }
            translate([mcRadius + bcRadius + (bcClearance * 2), 0, -1])
                cylinder(thickness + 102 + shroudOffset, r=mcRadius * 3 /2 ,  $fn=96);
        }
    }
}

module wheelCutouts(num, thickness, iradius, oradius)
{
    spoke = thickness; // spoke thickness
    zshift=[0, 0, -1];
    difference() {
        cylinder(thickness, r=oradius, $fn=96);
        union() {
            translate(zshift) cylinder(thickness+2, r=iradius, $fn=96);
            for(ii = [0: 360 / num: 360]) {
                rotate([0, 0, ii]) translate([-(spoke/2), 0, -1]) cube([spoke, oradius+100, spoke + 2]);
            }
        }
    }
}

module shroud() {
    // Motor mount and cutout
    translate([mcRadius + bcRadius + mcClearance, 0, 0]) union() {
        difference() {
            motormount();
            thickness = bcThickness + (bcClearance * 2) + shroudOffset;
            translate([-(mcRadius + bcRadius + mcClearance), 0, -1]) cylinder(thickness + 102, r=bcRadius + 100, $fn=96);
        }
        translate([0, 0, shroudOffset]) { motorCog(100); } 
    }
    bcShroud();
}

// ---------------------------------------------------------------
// Spine stuff
// ---------------------------------------------------------------

// upper
module upperCam()
{
    shaftHeight = SpacedLayer * 5 + 0.5 * LayerUnit;
    // Cam
    translate([0, 0, 0]) { difference() {
        union() {
            // shaft
            translate([0, 0, 0]) cylinder(shaftHeight, r=ShaftR, $fn=96);
            translate([0, 0, 0]) cylinder(LayerUnit, r=JointR, $fn=96);
            // strut
            translate([0, -200, 0]) cube([MagicM, 400, LayerUnit]);
            // central shaft
            translate([MagicM,0,0]) cylinder(LayerUnit, r=JointR, $fn=96);
        }
        // hex cutout
//        translate([MagicM,0,-10]) cylinder(220, r=ShaftTight, $fn=96);
        }
    }
}

// lower
module lowerCam()
{
    shaftHeight = SpacedLayer * 2 + LayerUnit;  
    // Cam
    translate([0, 0, 0]) { difference() {
        union() {
            // shaft
            translate([0, 0, 0]) cylinder(shaftHeight, r=ShaftR, $fn=96);
            // shaft circle
            translate([0, 0, 0]) cylinder(LayerUnit, r=JointR, $fn=96);
            // strut
            translate([0, -200, 0]) cube([MagicM, 400, LayerUnit]);
            // central shaft
            translate([MagicM,0,0]) cylinder(LayerUnit, r=JointR, $fn=96);
        }
        translate([MagicM,0,-10]) cylinder(220, r=ShaftTight, $fn=96);
        }
    }
}
module halfSpine(layers)
{
    layerSpace = SpacedLayer*layers;
    baseHeight = JointVertSpace + LayerUnit * 3;
    shaftHeight = 2*SpacedLayer + 210 + LayerUnit;
    difference() {
        translate([0, 0, 160+LayerUnit])
        union() {
            // shaft + base
                difference(){ union() {
                    translate([0, 0, -160-LayerUnit])
                    cylinder(baseHeight+LayerUnit+160, r=JointR,$fn=96); // base
                    if (useCap) {
                        translate([0, 0, baseHeight])
                        cylinder(shaftHeight, r=ShaftR,$fn=96); // shaft
                    }
                    // strut
                    translate([0,-200,]) cube([spineLength, 400, LayerUnit]);
                }
                union() {
                // hole in shaft
                translate([0, 0, -2]) cylinder(baseHeight + shaftHeight + 20,r=100,$fn=4);
                // insertion hole
                translate([0, 0, -165-LayerUnit]) cylinder(LayerUnit+230, r=ShaftTight, $fn=96);
                }}
            // central joint
            translate([spineLength,0,0]) cylinder(LayerUnit, r=JointR, $fn=96);
        }
        // shaft hole
        translate([spineLength,0,150]) cylinder(220, r=ShaftHole, $fn=96);
//        translate([0,0,100]) cylinder(layerSpace,r=440,$fn=96);
    }
}
// Outer joint plus half the rod
//module diffspine(layers) {
//    halfSpine(layers);
//    translate([-spineLength, 0, 0]) halfSpine(layers);
//}

// Outer joint plus half the rod
module spine(layers) {
    halfSpine(layers);
    if (useLowerCam) { union() {
    translate([spineLength, 0, JointVertSpace+LayerUnit]) lowerCam();
    } }

    if (useUpperCam) {
        translate([spineLength, 0, 0])
        rotate([0, 0, 60])
        translate([MagicM, 0, LayerUnit+JointVertSpace+(2*SpacedLayer)])
        rotate([0, 0, 180])
        upperCam();
    }

    translate([spineLength, 0, 0]) rotate([0, 0, 180-33.32]) 
    translate([-spineLength, 0, 0]) halfSpine(layers);
}

scale(ViewScale)
{
    offset = (JointVertSpace + LayerUnit + SpacedLayer * 2);
    if (useBigCog)
    {
        translate([spineLength, 0, offset]) 
        scale(RealityVec)
        translate([0, 0, 0]) bigCog(100); 
    }

   // Big cog and shaft
    union() {
        if (useShroud)
        {
            translate([spineLength, 0, offset]) {
            difference() {
//            union() {
                scale(RealityVec) translate([0, 0, -shroudOffset]) rotate([0, 0, -33.32]) shroud();
//            }
            translate([-spineLength, 0, -(offset+1)])
            union() {
                halfSpine(5);
                translate([spineLength, 0, 0]) rotate([0, 0, 180-33.32]) 
                translate([-spineLength, 0, 0]) halfSpine(5);
            } } }
        }
        spine(5);
   }
}

