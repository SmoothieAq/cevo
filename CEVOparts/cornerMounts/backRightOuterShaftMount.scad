
//*******************************************************************
// The back right inner shaft mount
//*******************************************************************

include <cornerMountsDefinitions.scad>
use <../util/diamants.scad>
use <../util/util.scad>
use <../xutil/xutil.scad>
use <backRightInnerShaftMount.scad>

module backRightOuterShaftMount(color=undef,showScrews=false) {
	lg = xl(a="Y gantry",sa="Back right shaft mount");
	xxPartLog(lg,c="printed part",n="backRightOuterShaftMount",t="PETG");
	
	color(color) {
		difference() {
			backYshaftMount();
			translate([cmYDistx-cmYHolderRadius*2+assembleSlack,-partMountingExWidth-1,-cmYHolderRadius*2.5]) cube([cmYHolderRadius*2,partMountingExWidth+cmYHolderLenght,partMountingExWidth+cmYHolderRadius*3]);
		}
	}
	xscrews(cmScrewPs,lg=xxl(lg,d="X holder mount"));
}

backRightOuterShaftMount();


/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/