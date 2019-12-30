//*******************************************************************
// Right part of xCarriage
//*******************************************************************

use <../imports/Chamfer.scad>;

include <yCarriagesDefinitions.scad>
use <yCarriageXHolderLeftSide.scad>


module yCarriageXHolderRightSide(color) {
	lg = xl(a="Y carriage",sa="X holder right side");
	xxPartLog(lg,c="printed part",n="yCarriageXHolderRightSide",t="PETG");

	rt(ycXHolderPos) mirror([0,0,1]) tr(ycXHolderPos) yCarriageXHolderOuter(color,lg);
	*mirror([0,0,1]) yCarriageXHolderOuter(color,lg);
}

//$doRealDiamants=true;
//yCarriageXHolderInner(); xnuts(ycXHolderPs,lg);
//yCarriageXHolderOuter();

yCarriageXHolderRightSide();


/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/