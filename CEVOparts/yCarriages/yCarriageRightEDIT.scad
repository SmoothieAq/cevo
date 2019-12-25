
//*******************************************************************
// right yCarriage assembly
//*******************************************************************

use <../imports/e3d_v6_all_metall_hotend.scad>;

include <../CEVOdefinitions.scad>
include <yCarriagesDefinitions.scad> 
include <../util/helperEDIT.scad>
use <yCarriageRightFront.scad>



show 		= 0; 

onlyShow 	= false;
alpha		= 0.2;
showColor 	= undef;
showScrews 	= true;
showExtra	= true;
//showExtraExtra = true;

module yCarriageRightAssembly() {
	place = [[],
		[0,xshaftDistance/2,0,0,0,90], 																				// y shaft 
		[-xshaft[length]/2+yTubeRadius-screwTapMinThick-slack,0,xshaftZ,0,0,0], 																				// shaft front
		[-xshaft[length]/2+yTubeRadius-screwTapMinThick-slack,xshaftDistance,xshaftZ,0,0,0], 																// shaft back
		[0,(carriageWidth-xshaftDistance)/2+xshaftDistance,-yTubeRadius,90,0,0], 													// yCarriageRightFront
	[]];
	show(place) {
		place(place,1,true,true) color(alpha(1,carbonYshaft ? carbonColor : aluColor)) theShaft(yshaft);
		place(place,2,true) color(alpha(2,carbonXshaft ? carbonColor : aluColor)) theShaft(xshaft);
		place(place,3,true) color(alpha(3,carbonXshaft ? carbonColor : aluColor)) theShaft(xshaft);
		place(place,4) yCarriageRightFront(color=alpha(4,mainColor),showScrews=showScrews); 
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