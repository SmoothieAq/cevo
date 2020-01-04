
//*******************************************************************
// back bushings for x carriage
//*******************************************************************
// print PLA in vase mode
//*******************************************************************

use <../genericParts/bushing.scad>
include <yCarriagesDefinitions.scad>

module yCarriageBushingRight(color=undef,drill=false) {
	lg = xl(a="Y carriage",sa="Bushing rigth");
	xxPartLog(lg,c="printed part",n="yCarriageBushingRight",t="PLA");

	color(color) bushing(yshaft,ycSideWidth-bushingTap-ycBushingTapWidth,drill=drill);
}

if (false) {
	$doDiamants=true;
	$doRealDiamants=true;
	$showScrews=false;
	yCarriageBushingRight();
} else if (true) {
	yCarriageBushingRight(color = accentColor);
}

/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/