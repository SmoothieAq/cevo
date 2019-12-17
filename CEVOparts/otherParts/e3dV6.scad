
//*******************************************************************
// Genric bushings
//*******************************************************************

use <../imports/e3d_v6_all_metall_hotend.scad>;
include <../CEVOdefinitions.scad>;


module e3dV6(fan=1,color=aluColor,fanColor=otherPartColor) {
	color(color) difference() {
		translate([0,0,3]) rotate([180,0,180]) e3d();
		translate([-10,-10,0]) cube([20,20,4]);
	}
	if (fan)
		color(fanColor) translate([-15,-25.6/2-10,-17-30]) cube([30,10,30]);
}

e3dV6();



/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/