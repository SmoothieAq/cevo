
//*******************************************************************
// frame assembly
//*******************************************************************


include <CEVOdefinitions.scad>
include <util/helperEDIT.scad>
include <cornerMounts/cornerMountsDefinitions.scad>
include <yCarriages/yCarriagesDefinitions.scad>
use <frame/frameAssembly.scad>
use <xCarriage/xCarriageAssembly.scad>
use <yCarriages/yCarriageRightAssembly.scad>
use <cornerMounts/frontRightCornerAssembly.scad>



module fullAssembly() {
	yCarriageRel = 0.21;
	xCarriageRel = 0.2;

	frameWidthEx = frameWidth-extrusionWidth;
	frameHeightEx = frameHeight-extrusionWidth;
	yshaftx = frameWidthEx-yshaft[radius]-yshaftDistx;
	yshaftz = frameHeightEx-yshaft[radius]-yshaftDistz;
	yCarriagePos = frameDepth*yCarriageRel-xshaftDistance/2;
	xCarriagePos = frameWidth*xCarriageRel;

	place = [[],
		[0,0,0,0,0,0], 														// frame
		[xCarriagePos,yCarriagePos,yshaftz+xshaftOffset,0,0,0], 	// xCarriage
		[yshaftx,yCarriagePos,yshaftz,0,0,0], 	// yCarriageRight
		[frameWidthEx,0,frameHeightEx,0,0,0], 														// frontRightCornerAssembly
		[yshaftx+ycIdlerOuterEdge,0,yshaftz+ycUpperIdlerTop-belt[width],0,0,90],
	[]];
	show(place) {
		place(place,1) frameAssembly();
		place(place,2) xCarriageAssembly();
		place(place,3) yCarriageRightAssembly();
		place(place,4) frontRightCornerAssembly();
		place(place,5,true) color("red") cube([frameDepth,beltBaseThick(belt),belt[width]]);
	}
}

fullAssembly();


/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/