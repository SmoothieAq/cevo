
//*******************************************************************
// The plate for electronics at the bottom of the frame
//*******************************************************************

include <frameDefinitions.scad>


module bottomPlate(color=undef,showScrews=false) {

	indent = 3;
	nudge = slack*2.5;
	cut = extrusionWidth-indent+nudge;
	
	width = frameWidth-2*indent;
	depth = frameDepth-2*indent;
		
	color(color) {
		
		difference() {
			translate([indent,indent,0]) cube([width,depth,plateThick]);
			translate([indent-1,indent-1,-1]) cube([cut+1,cut+1,plateThick+2]);
			translate([width-cut+indent,indent-1,-1]) cube([cut+1,cut+1,plateThick+2]);
			translate([indent-1,depth-cut+indent,-1]) cube([cut+1,cut+1,plateThick+2]);
			translate([width-cut+indent,depth-cut+indent,-1]) cube([cut+1,cut+1,plateThick+2]);
		}
	}
}

bottomPlate();

/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/