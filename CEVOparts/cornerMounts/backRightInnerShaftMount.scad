
//*******************************************************************
// The back right inner shaft mount
//*******************************************************************

include <cornerMountsDefinitions.scad>
use <../util/diamants.scad>
use <../util/util.scad>
use <../xutil/xutil.scad>

module yHolder() {
	difference() {
		union() {
			tr(cmYHolderPos) xDiamantTube(cmYHolderRadius, cmYHolderLenght);
			tr([0,cmYHolderLenght-cmYDisty,-cmYDistz,0,-90,180]) xcube([cmYDistz+partMountingExWidth, cmYHolderLenght-cmYDisty, partMountingThick], [0, 1, 1, 0]);
			tr([0,0,-cmYDistz-0.1,90,-90,90]) xcube([cmYDistz+0.1, partMountingExWidth, partMountingThick], [1, 0, 0, 0]);
			tr([0,-partMountingExWidth,-cmYDistz,0,90,0]) xcubex([cmPlateCut, partMountingExWidth-cmYDisty+cmPlateCut, partMountingExWidth-cmYDisty, partMountingThick], [1, 0, 1, 1]);
		}
		translate([-cmYHolderRadius,-cmYHolderLenght,-cmYHolderRadius*2+0.1]) cube([cmYHolderRadius,cmYHolderLenght*2,cmYHolderRadius*2]);
		tr(cmYHolderPos) rotate([180,0,0]) shaftHole(yshaft,ycXHolderLenght+10);
	}
}

// the whole mount - inner and outer cut their own parts
module backYshaftMount() {
	difference() {
		union() {
			yHolder();
		}
		translate([0,-cmYHolderRadius*2,0]) cube([cmYHolderRadius*2,cmYHolderRadius*2,cmYHolderRadius]);
		xholes(cmScrewPs);
		xholes(cmFrameScrewPs);
	}
}

module backInnerShaftMount(color,lg) {
	color(color) {
		difference() {
			backYshaftMount();
			translate([cmYDistx,-partMountingExWidth-1,-cmYHolderRadius*2.5]) cube([cmYHolderRadius*2,partMountingExWidth+cmYHolderLenght,partMountingExWidth+cmYHolderRadius*3]);
		}
	}
	for (p=[cmFrameScrewPs[0],cmFrameScrewPs[1]]) xFrameScrew(p,lg=xxl(lg,d="frame mount"));
	xnuts(cmScrewPs,lg=xxl(lg,d="Y holder mount"));
}

module backRightInnerShaftMount(color) {
	lg = xl(a="Y gantry",sa="Back right shaft mount");
	xxPartLog(lg,c="printed part",n="backRightInnerShaftMount",t="PETG");

	backInnerShaftMount(color,lg);
}

backRightInnerShaftMount();


/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/