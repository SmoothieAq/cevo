
//*******************************************************************
// The front right inner shaft mount
//*******************************************************************

include <cornerMountsDefinitions.scad>
use <../util/diamants.scad>
use <../util/util.scad>
use <../xutil/xutil.scad>
use <backRightInnerShaftMount.scad>

// the whole mount - inner and outer cut their own parts
module frontYshaftMount() {
	difference() {
		union() {
			yHolder();
			tr([0,-partMountingExWidth,-cmYDistz,0,90,0]) xcubex([cmPlateCut, partMountingExWidth-cmYDisty+cmPlateCut, partMountingExWidth-cmYDisty, partMountingThick], [0, 0, 1, 0]);
			cmPlateCut2 = partMountingExWidth-1;
			tr([0,1,-1,0,-90,180]) xcube([partMountingExWidth+1, partMountingExWidth+1, partMountingThick], [1, 1, 0, 0]);
			translate([-extrusionWidth/3+assembleSlack,0,-partMountingThick]) cube([extrusionWidth/3,cmYHolderLenght-cmYDisty,partMountingThick]);
		}
		tr([0,-partMountingExWidth-0.01,0,90,-45,90]) xcubeForCut([partMountingExWidth*2,partMountingExWidth*2,partMountingThick]);
		xholes(cmScrewPs);
		xholes(cmFrameScrewPs);
		translate([-cmScrew[nutHoleHeight]*1.2,cmScrewPs[1].y-cmScrew[nutHoleRadius]*1.2,-partMountingThick-1]) cube([cmScrew[nutHoleHeight]*1.2,cmScrew[nutHoleRadius]*2.4,partMountingThick+2]);
	}
}

module frontInnerShaftMount(color,lg) {
	mirror([0,1,0]) {
		color(color) difference() {
			frontYshaftMount();
			translate([cmYDistx,-partMountingExWidth-1,-cmYHolderRadius*2.5]) cube([cmYHolderRadius*2,partMountingExWidth+cmYHolderLenght,partMountingExWidth+cmYHolderRadius*3]);
		}
		for (p=cmFrameScrewPs) xFrameScrew(p,lg=xxl(lg,d="frame mount"));
		xnuts(cmScrewPs,lg=xxl(lg,d="Y holder mount"));
	}
}

module frontRightInnerShaftMount(color) {
	lg = xl(a="Y gantry",sa="Back right shaft mount");
	xxPartLog(lg,c="printed part",n="frontRightInnerShaftMount",t="PETG");

	frontInnerShaftMount(color,lg);
}

frontRightInnerShaftMount();


/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/