
//*******************************************************************
// Utility modules and functions
//*******************************************************************

use <../imports/Chamfer.scad>;


module ccylinder(h,r,c1h=0,c2h=0,a = 360) {
	//chamferCylinder(h, r, r, chamferHeight = c1h, chamferHeight2 = c2h);
	module cc() {
		if (c1h != 0) cylinder(abs(c1h)+0.001,r-c1h,r);
		translate([0,0,abs(c1h)]) cylinder(h-abs(c1h)-abs(c2h),r,r);
		if (c2h != 0) translate([0,0,h-abs(c2h)-0.001]) cylinder(abs(c2h)+0.001,r,r-c2h);
	}
	if (a >= 360 || a <= 0) {
		cc();
	} else {
		difference() {
			cc();
			translate([-r-1,-r-1,-1]) cube([r+1,r*2+2,h+2]);
			rotate([0,0,-180+min(a,180)]) translate([-r-1,-r-1,-1]) cube([r+1,r*2+2,h+2]);
		}
		if (a > 180) difference() {
			cc();
			translate([0,-r-1,-1]) cube([r+1,r*2+2,h+2]);
			rotate([0,0,-360+a]) translate([0,-r-1,-1]) cube([r+1,r*2+2,h+2]);
		}
	}
}

module cpieQuater(h,r,c1h=0,c2h=0) {
	difference() {
		cube([r,r,h]);
		translate([-0.001,-0.001,-0.001]) ccylinder(h+0.002,r,c1h=c1h,c2h=c2h);
	}
}
cpieQuater(20,6,-1,-1);


module ccube(x,y,z,ch=0,sides=[1,0,0,0],sides2=[0,0,0,0],sides3=[0,0,0,0]) {
	chamferCube(x,y,z,ch,sides,sides2,sides3);
}

module ccubeHalf(x,y,z,ch=0,sides=[0,0,0,0],sides2=[0,0,0,0],sides3=[0,0,0,0]) {
	difference() {
		ccube(x,y,z,ch,[sides[0],0,0,sides[3]],sides2,sides3);
		rotate([0,0,atan(y/x)]) translate([0,-y,0]) 
			difference() {
				translate([0,y-ch,-0.001]) cube([x*2,y*2,z+0.002]);
				translate([0,0,-0.001]) ccube(x*2,y,z+0.002,ch,[0,sides[1],sides[2],0]);
			};
		//translate([10,0,-1]) //rotate([0,0,atan(y/x)]) {
	}
}

//ccubeHalf(6,3,4,0.5,[0,1,1,0],[0,0,0,0],[0,0,0,0]);

/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/