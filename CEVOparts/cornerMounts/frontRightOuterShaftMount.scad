
//*******************************************************************
// The front right outer shaft mount
//*******************************************************************

include <cornerMountsDefinitions.scad>
use <frontRightInnerShaftMount.scad>
use <../xutil/xutil.scad>


module frontRightOuterShaftMount(color) {
	lg = xl(a="Y gantry",sa="Front right shaft mount");
	xxPartLog(lg,c="printed part",n="frontRightOuterShaftMount",t="PETG");
	
	mirror([0,1,0]) {
		color(color) difference() {
			frontYshaftMount();
			translate([cmYDistx-cmYHolderRadius*2+assembleSlack,-partMountingExWidth-1,-cmYHolderRadius*2.5]) cube([cmYHolderRadius*2,partMountingExWidth+cmYHolderLenght,partMountingExWidth+cmYHolderRadius*3]);
		}
		xscrews(cmScrewPs,lg=xxl(lg,d="X holder mount"));
	}
}

frontRightOuterShaftMount();

/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/