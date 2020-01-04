
//*******************************************************************
// Genric bushings
//*******************************************************************

use <../imports/spiral_vase-linear_bearing.scad>
include <../CEVOdefinitions.scad>;


module bushing(shaft,length,drill=false) {
	if ($doRealDiamants) {
		translate([0,0,length/2]) spiralVaseLinearBearing(shaft[bushingRadius]*2,shaft[radius]*2,length,drill=drill);
	} else if (nnv($doDiamants,true)) {
		difference() {
			cylinder(r=shaft[bushingRadius],h=length);
			translate([0,0,-0.1]) cylinder(r=shaft[radius],h=length+0.2);
		}
	}
}


/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/