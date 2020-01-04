//*******************************************************************
// Right part of xCarriage
//*******************************************************************

use <../imports/Chamfer.scad>;

include <yCarriagesDefinitions.scad>
use <../util/diamants.scad>
use <../util/util.scad>
use <../xutil/xutil.scad>

module yCarriageXHolder(lg,backSide) {
	module xdc(diamants = true) rotate([90, 0, 0]) xDiamantCube([ycXHolderWidth, ycXHolderLenght, ycXTubeRadius], sides = [1, 0, 1, 0], bevel = [1, 0, 1, 0], diamants = diamants);
	difference() {
		union() {
			xDiamantTube(ycXTubeRadius, ycXHolderLenght, 235);
			xdc();
			mirror([0, 1, 0]) xdc(diamants = false);
			rt(ycXHolderPos) {
				ch = backSide ? ycScrew[nutHeight] : ycScrew[headHeight];
				translate([ycScrewPs[1].x, ycScrewPs[1].y, ch])
					cylinder(r = ycScrewTubeRadius2, h = ycSideWidth-ch);
				translate([ycScrewPs[2].x, ycScrewPs[2].y, ch])
					cylinder(r = ycScrewTubeRadius2, h = ycWidth/2-ch);
				*for (p = [ycScrewPs[1], ycScrewPs[2]]) // tubes for the large screws
					translate([p.x, p.y, chamfer])
						cylinder(r = ycScrewTubeRadius2, h = ycSideWidth-chamfer);
			}
		}
		translate([0,0,ycXHolderLenght]) shaftHole(xshaft,ycXHolderLenght);
		//xholes(ycXHolderPs);
		rt(ycXHolderPos) {
			if (backSide) xholes(ycScrewPs);
			else translate([0, 0, ycWidth]) mirror([0, 0, 1]) xholes(ycScrewPs,twist=30); // holes for the side assembly screws
		}
	}
}

module yCarriageXHolderInner(color,lg,backSide) {
	color(color) difference() {
		yCarriageXHolder(lg,backSide);
		translate([-ycXHolderWidth+assembleSlack,-ycXTubeRadius-5,-1]) cube([ycXHolderWidth,ycXTubeRadius*2+10,ycXHolderLenght+2]);
	}
}

module yCarriageXHolderOuter(color,lg,backSide) {
	color(color) difference() {
		yCarriageXHolder(lg,backSide);
		translate([-assembleSlack,-ycXTubeRadius-5,-1]) cube([ycWidth+2,ycXTubeRadius*2+10,ycXHolderLenght+2]); // cut inner part off
		rt(ycXHolderPos) cylinder(r=ycTubeRadius+bevelHeight+assembleSlack,h=ycWidth); // cut y tube offset
		*rt(ycXHolderPos) for (p = ycScrewPs) // cut off tubes for the large screws
			translate([p.x, p.y, chamfer])
				cylinder(r = ycScrewTubeRadius+assembleSlack, h = ycSideWidth-chamfer);

	}
	//xscrews(ycXHolderPs,lg);
}

module yCarriageXHolderRightBack(color) {
	lg = xl(a="Y carriage",sa="X holder left side");
	xxPartLog(lg,c="printed part",n="yCarriageXHolderLeftSide",t="PETG");

	yCarriageXHolderOuter(color,lg,true);
	rt(ycXHolderPos) xnuts([ycScrewPs[1], ycScrewPs[2]], lg = lg, plate = 0,twist=30); // screws for the assembly
}

//$doRealDiamants=true;
*yCarriageXHolderInner(); //xnuts(ycXHolderPs,lg);
//yCarriageXHolderOuter();

yCarriageXHolderRightBack();


/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/