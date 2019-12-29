//*******************************************************************
// Right part of xCarriage
//*******************************************************************

use <../imports/Chamfer.scad>;

include <yCarriagesDefinitions.scad>
use <../util/diamants.scad>
use <../util/util.scad>
use <../xutil/xutil.scad>

module yCarriageXHolder(lg) {
	module xdc(diamants = true) rotate([90, 0, 0]) xDiamantCube([ycXHolderWidth, ycXHolderLenght, ycXTubeRadius], sides = [1, 0, 1, 0], bevel = [1, 0, 1, 0], diamants = diamants);
	difference() {
		union() {
			xDiamantTube(ycXTubeRadius, ycXHolderLenght, 235);
			xdc();
			mirror([0, 1, 0]) xdc(diamants = false);
		}
		translate([0,0,ycXHolderLenght]) shaftHole(xshaft,ycXHolderLenght);
		xholes(ycXHolderPs);
	}
}

module yCarriageXHolderInner(color,lg) {
	color(color) difference() {
		yCarriageXHolder(color);
		translate([-ycXHolderWidth+assembleSlack,-ycXTubeRadius-1,-1]) cube([ycXHolderWidth,ycXTubeRadius*2+2,ycXHolderLenght+2]);
	}
}

module yCarriageXHolderOuter(color,lg) {
	color(color) difference() {
		yCarriageXHolder(color);
		translate([-assembleSlack,-ycXTubeRadius-1,-1]) cube([ycXHolderWidth+2,ycXTubeRadius*2+2,ycXHolderLenght+2]); // cut inner part off
		rt(ycXHolderPos) cylinder(r=ycTubeRadius+bevelHeight+assembleSlack,h=ycWidth); // cut y tube offset
		rt(ycXHolderPos) for (p = ycScrewPs) // cut off tubes for the large screws
			translate([p.x, p.y, chamfer])
				cylinder(r = ycScrewTubeRadius+assembleSlack, h = ycSideWidth-chamfer);

	}
	xscrews(ycXHolderPs,lg);
}

module yCarriageXHolderRightSide(color) {
	lg = xl(a="Y carriage",sa="X holder right side");
	xxPartLog(lg,c="printed part",n="yCarriageXHolderRightSide",t="PETG");

	yCarriageXHolderOuter(color,lg);
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