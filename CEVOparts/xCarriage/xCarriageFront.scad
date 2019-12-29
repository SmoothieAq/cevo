
//*******************************************************************
// front of xCarriage
//*******************************************************************

use <../imports/Chamfer.scad>;

include <xCarriageDefinitions.scad>
use <../util/diamants.scad>
use <../util/util.scad>




module xCarriageFront(color=undef) {
	color(color) {
		difference() {
			cylinder(h=carriageWidthHole,r=carriageFrontRadius);
			translate([xshaft[bushingRadius]-carriageTubeRadius,xshaft[bushingRadius]/2-carriageFrontRadius+bevelHeight,-1]) 
				cylinder(carriageWidth,carriageScrew[holeRadius],carriageScrew[holeRadius]);
			translate([0,-xshaft[bushingRadius]-1,-1]) 
				cube([xshaft[bushingRadius]*2,xshaft[bushingRadius]*2,carriageWidthHole+2]);
			translate([-xshaft[bushingRadius],carriageThick*carriageFrontScale,-1]) 
				cube([xshaft[bushingRadius]*2,xshaft[bushingRadius]*2,carriageWidthHole+2]);
		}
		translate([-xshaft[bushingRadius]/2+bevelHeight,-xshaft[bushingRadius]/2+bevelHeight,carriageWidthHole/2])
			rotate([135,90,0])
				linear_extrude(1)
					text("CEVO",font="Arial:style=Bold", size=5, valign="center", halign="center");
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