
//*******************************************************************
// The front right outer shaft mount
//*******************************************************************

include <cornerMountsDefinitions.scad>
use <frontRightInnerShaftMount.scad>
use <../xutil.scad>


module frontRightOuterShaftMount(color=undef,showScrews=false) {
	lg = xl(a="Y gantry",sa="Front right shaft mount");
	xxPartLog(lg,c="printed part",n="frontRightOuterShaftMount",t="PETG");
	
	translate([0,0,yshaftFrontMountDepth-yshaftMountDepthIn]) rotate([0,90,0]) {
		color(color) difference() {
			yshaftMount(color,showScrews);
			translate([-1,-50,yshaftDistx+yshaft[radius]-50]) cube([100,100,50]);	
		}
		for (p=yshaftFrontMounts) xscrew(p,yshaftTubeScrew,depth=0,showScrews=showScrews,lg=xxl(lg,d="tube assembly"));
	}
}

frontRightOuterShaftMount(showScrews=true);

/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/