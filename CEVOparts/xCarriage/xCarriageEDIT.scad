
//*******************************************************************
// Right part of xCarriage
//*******************************************************************

use <../imports/e3d_v6_all_metall_hotend.scad>;

include <../CEVOdefinitions.scad>
include <xCarriageDefinitions.scad>
include <../util/helperEDIT.scad>
use <xCarriageRight.scad>
use <xCarriageLeft.scad>
use <xCarriagePlate.scad>
use <xCarriageFront.scad>
use <xCarriageBushingBack.scad>
use <xCarriageBushingFront.scad>
use <../otherParts/e3dV6.scad>
use <../otherParts/blowerFan.scad>



show 		= 0; 

onlyShow 	= false;
alpha		= 0.2;
showColor 	= undef;
showScrews 	= true;
showExtra	= true;

place = [[],
	[carriageWidth/2,0,xTubeRadius,-90,0,90], 													// xCarriageRight
	[-carriageWidth/2,0,xTubeRadius,90,0,90], 													// xCarriageLeft
	[0,xshaftDistance/2,xTubeRadius-carriageThick+bevelHeight,0,0,0], 							// xCarriagePlate
	[carriageWidthHole/2,carriageTubeRadius,-carriageFrontRadius+xTubeRadius+bevelHeight,-90,0,90], 	// xCarriageFront
	[-carriageWidth/2+bushingTap,xshaftDistance,0,90,0,90], 									// xCarriageBushingBack
	[carriageWidthHole/2,0,0,90,0,90], 															// xCarriageBushingFront right
	[-carriageWidthHole/2,0,0,90,0,-90], 														// xCarriageBushingFront left
	[0,0,0,0,0,0], 																				// shaft front
	[0,xshaftDistance,0,0,0,0], 																// shaft back
	[hotendOffset[0],hotendOffset[1]+xshaftDistance/2,hotendOffset[2]+xTubeRadius+4-14,0,0,0],		// e3dV6
//	[-30,50+hotendOffset[1]-20/2+xshaftDistance/2,-55,90,-90,90],		// blowerFan left
//	[-25,50+hotendOffset[1]-20/2+xshaftDistance/2,-55,90,-90,90],		// blowerFan left
	[-25,50+hotendOffset[1]-20/2+xshaftDistance/2,-55,90,-90,90],		// blowerFan left
//	[-20,xshaftDistance/2+hotendOffset[1]+15/2,-7,-90,0,180],		// blowerFan left
	[-34/2,xshaftDistance+xTubeRadius+bevelHeight,-54+xTubeRadius+bevelHeight,0,0,0], 																				// connector
[]];
show() {
	place(1) xCarriageRight(color=alpha(1,mainColor),showScrews=showScrews);
	place(2) xCarriageLeft(color=alpha(2,mainColor),showScrews=showScrews);
	place(3) xCarriagePlate(color=alpha(3,mainColor),showScrews=showScrews);
	place(4) xCarriageFront(color=alpha(4,accentColor),showScrews=showScrews);
	place(5) xCarriageBushingBack(color=alpha(5,accentColor),showScrews=showScrews);
	place(6) xCarriageBushingFront(color=alpha(6,accentColor),showScrews=showScrews);
	place(7) xCarriageBushingFront(color=alpha(7,accentColor),showScrews=showScrews);
	place(8,true) color(alpha(8,carbonXshaft ? carbonColor : aluColor)) theShaft(xshaft);
	place(9,true) color(alpha(9,carbonXshaft ? carbonColor : aluColor)) theShaft(xshaft);
	place(10,true) e3dV6(color=alpha(10,aluColor),fanColor=alpha(10,otherPartColor));
//	place(11,true) rotate([0,45,0]) blowerFan5015(color=alpha(11,otherPartColor),showScrews=showScrews);
//	place(11,true) rotate([0,0,0]) color(alpha(11,otherPartColor)) cube([40,40,10]);
	place(11,true) rotate([0,35,0]) color(alpha(11,otherPartColor)) cube([45,45,10]);
//	place(11,true) rotate([0,0,0]) blowerFan5015(color=alpha(11,otherPartColor),showScrews=showScrews);
	place(12) color(alpha(12,mainColor)) cube([34,15,54]);
}



/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/