// Differential Planetary Gearset

use <MCAD/involute_gears.scad>

//fourgears();
//ring1();
//ring2();
assembly();

d1=60;// diameter of lower ring
t=4;// thickness of all gears
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

R1=(1+nr1/ns);// sun to planet-carrier ratio
R2=nr2/((ns+np1)*(1-np2/np1));// planet-carrier to ring ratio
Rp=(np1+ns)/np1;// planet to planet-carrier ratio
R=R1*R2;// total sun to ring ratio
echo(str("Gear Ratio is 1 : ",R));

module assembly(){
color([0.5,0.5,0.5])ring1();
translate([0,0,t])rotate([180,0,180/ns+360*R*$t])
	color([1,0,0])sun();
rotate([0,0,360*R2*$t])translate([(ns+np1)/pitch/2,0,0])rotate([0,0,-360*R2*(1+Rp)*$t])
	color([0,0,1])planet();
rotate([0,0,120+360*R2*$t])translate([(ns+np1)/pitch/2,0,0])rotate([0,0,-120-360*R2*(1+Rp)*$t])
	color([0,0,1])planet();
rotate([0,0,-120+360*R2*$t])translate([(ns+np1)/pitch/2,0,0])rotate([0,0,120-360*R2*(1+Rp)*$t])
	color([0,0,1])planet();
translate([0,0,2*t+2*s+td+0.1])rotate([180,0,360*$t])
	color([0,1,0])ring2a();
}

module fourgears(){
	sun();
	for(i=[0,120,-120])
		rotate([0,0,i])translate([1.2*(ns+np1)/pitch/2,0,0])
			rotate([0,0,-i])planet();
}

module sun()
union(){
	gear(number_of_teeth=ns,
		diametral_pitch=pitch,
		gear_thickness=t,
		rim_thickness=t,
		hub_thickness=t,
		bore_diameter=0,
		backlash=b,
		clearance=c,
		pressure_angle=pa);
	translate([0,0,t])cylinder(r=2, h=10);
}

module planet()
union(){
	gear(number_of_teeth=np1,
		diametral_pitch=pitch,
		gear_thickness=t+s+td/2,
		rim_thickness=t+s+td/2,
		hub_thickness=t+s+td/2,
		bore_diameter=0,
		backlash=b,
		clearance=c,
		pressure_angle=pa);
translate([0,0,t+s])cylinder(r=pd*np1/pitch/2,h=td,$fn=np1);
translate([0,0,t+s+td/2])
	gear(number_of_teeth=np2,
		diametral_pitch=pitch,
		gear_thickness=t+s+td/2,
		rim_thickness=t+s+td/2,
		hub_thickness=t+s+td/2,
		bore_diameter=0,
		backlash=b,
		clearance=c,
		pressure_angle=pa);
}

module ring1() insidegear(nr1);
module ring2() insidegear(nr2);

module insidegear(n)
rotate([180,0,0])translate([0,0,-t])
difference(){
	cylinder(r=n/pitch/2/dp,h=t+t1);
	translate([0,0,-0.5])cylinder(r=3,h=t+t1+1);
	translate([0,0,-1])
	gear(number_of_teeth=n,
		diametral_pitch=pitch,
		gear_thickness=t+1,
		rim_thickness=t+1,
		hub_thickness=t+1,
		bore_diameter=0,
		backlash=-b,
		clearance=0,
		pressure_angle=pa);
}

module ring2a()
rotate([180,0,0])translate([0,0,-t])
difference(){
	cylinder(r=nr2/pitch/2/dp,h=t);
	translate([0,0,-0.1])
	gear(number_of_teeth=nr2,
		diametral_pitch=pitch,
		gear_thickness=t+0.2,
		rim_thickness=t+0.2,
		hub_thickness=t+0.2,
		bore_diameter=0,
		backlash=-b,
		clearance=0,
		pressure_angle=pa);
}
