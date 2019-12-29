
//*******************************************************************
// The frame
//*******************************************************************

include <frameDefinitions.scad>


module frame(color=undef) {

	color(color) {
		
		theExtrusion(extrusionH);
		translate([exWidth+extrusionWidth,0,0]) theExtrusion(extrusionH);
		translate([0,exDepth+extrusionWidth,0]) theExtrusion(extrusionH);
		translate([exWidth+extrusionWidth,exDepth+extrusionWidth,0]) theExtrusion(extrusionH);

		translate([extrusionWidth,exDepth+extrusionWidth,exLength]) rotate([0,90,0]) theExtrusion(extrusionW);
		translate([extrusionWidth,exDepth+extrusionWidth,botBrace]) rotate([0,90,0]) theExtrusion(extrusionW);
		translate([extrusionWidth,0,topBrace-extrusionWidth]) rotate([0,90,0]) theExtrusion(extrusionW);
		translate([extrusionWidth,0,botBrace]) rotate([0,90,0]) theExtrusion(extrusionW);

		translate([0,exDepth+extrusionWidth,exLength-extrusionWidth]) rotate([90,0,0]) theExtrusion(extrusionD);
		translate([0,exDepth+extrusionWidth,topBrace-2*extrusionWidth]) rotate([90,0,0]) theExtrusion(extrusionD);
		translate([0,exDepth+extrusionWidth,botBrace-extrusionWidth]) rotate([90,0,0]) theExtrusion(extrusionD);
		translate([exWidth+extrusionWidth,exDepth+extrusionWidth,exLength-extrusionWidth]) rotate([90,0,0]) theExtrusion(extrusionD);
		translate([exWidth+extrusionWidth,exDepth+extrusionWidth,topBrace-2*extrusionWidth]) rotate([90,0,0]) theExtrusion(extrusionD);
		translate([exWidth+extrusionWidth,exDepth+extrusionWidth,botBrace-extrusionWidth]) rotate([90,0,0]) theExtrusion(extrusionD);

	}
}

frame();

/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/