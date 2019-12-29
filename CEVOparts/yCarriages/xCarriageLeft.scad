
//*******************************************************************
// Left part of xCarriage
//*******************************************************************

include <xCarriageDefinitions.scad>
use <xCarriageRight.scad>



module xCarriageLeft(color=undef,showScrews=false) {
	rotate([180,0,0]) mirror([0,0,1]) {
		difference() {
			carriageSide(color,showScrews);
			color(color) {
				translate([carriageScrewX,carriageScrewY,0])
					rotate([180,0,0]) 
						nutHole(ycScrew);
				translate([xshaftDistance-carriageScrewX,carriageScrewY,0])
					rotate([180,0,0]) 
						nutHole(ycScrew);
			}
		}
		if (showScrews) color(screwColor) {
			translate([carriageScrewX,carriageScrewY,0])
				rotate([180,0,0]) 
					nut(ycScrew,1);
			translate([xshaftDistance-carriageScrewX,carriageScrewY,0])
				rotate([180,0,0]) 
					nut(ycScrew,1);
		}
	}
}

xCarriageLeft();



/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/