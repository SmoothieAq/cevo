
//*******************************************************************
// right yCarriage assembly
//*******************************************************************

use <../imports/e3d_v6_all_metall_hotend.scad>;

include <../CEVOdefinitions.scad>
include <yCarriagesDefinitions.scad> 
use <../util/helperEDIT.scad>
use <yCarriageRightBack.scad>
use <yCarriageXHolderRightFront.scad>
use <yCarriageRightFront.scad>
use <yCarriageBoxBottom.scad>
use <yCarriageXHolderRightBack.scad>


module yCarriageRightAssembly() {
	xshaftX = -xshaft[length]/2-ycXHolderOffset-slack;
	xshaftBackY = -ycWidth/2+xshaftDistance/2;
	place = [[],
		[0,xshaftDistance/2,0,0,0,90], 												// y shaft
		[xshaftX,xshaftBackY-xshaftDistance,xshaftOffset,0,0,0], 	// x shaft front
		[xshaftX,xshaftBackY,xshaftOffset,0,0,0], // x shaft back
		[0,0,0,90,0,0], // yCarriageRightBack
		[0,0,0,90,0,0], // yCarriageXHolderLeftSide
		[0,-ycWidth,0,90,0,0], // yCarriageRightFront
		[0,0,0,90,0,0], // yCarriageBoxBottom
		[0,-ycWidth,0,90,0,0], // yCarriageXHolderRightSide
		[-xshaft[length]/2+yIdlerDist,-ycWidth/2-beltCarriageDistance/2-belt[thick]/2,ycUpperIdlerTop-belt[width],0,0,0], // upper belt
		[-xshaft[length]/2+yIdlerDist,-ycWidth/2+beltCarriageDistance/2+belt[thick]/2,ycLowerIdlerTop,180,0,0], // lower belt
	[]];
	show(place) {
		place(place,1,true,true) color(alpha(1,carbonYshaft ? carbonColor : aluColor)) theShaft(yshaft);
		place(place,2,true) color(alpha(2,carbonXshaft ? carbonColor : aluColor)) theShaft(xshaft);
		place(place,3,true) color(alpha(3,carbonXshaft ? carbonColor : aluColor)) theShaft(xshaft);
		place(place,4) yCarriageRightBack(color=alpha(4,mainColor));
		place(place,5) tr(ycXHolderPos) yCarriageXHolderRightBack(color=alpha(5,mainColor));
		place(place,6) yCarriageRightFront(color=alpha(6,mainColor));
		place(place,7) tr(ycBoxPos) yCarriageBoxBottom(color=alpha(7,mainColor));
		place(place,8) tr(ycXHolderPos) yCarriageXHolderRightFront(color=alpha(8,mainColor));
		place(place,9,true,true) xbelt(leng=xshaft[length]/2);
		place(place,10,true,true) xbelt(leng=xshaft[length]/2);
	}
}

yCarriageRightAssembly();


/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/