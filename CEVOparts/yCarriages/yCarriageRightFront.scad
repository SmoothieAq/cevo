//*******************************************************************
// Right part of xCarriage
//*******************************************************************

use <../imports/Chamfer.scad>;

include <yCarriagesDefinitions.scad>
use <../util/diamants.scad>
use <../util/util.scad>
use <../xutil.scad>


module yCarriageSide(color = undef, showScrews = false) {

    module tube() {
        xHolderx = -xHolderLenght+idlerBoxX+idlerSpaceDepth-motorClearance;
        xxshaftz = carriageWidth/2-xshaftDistance/2;
        color(color) difference() {
            union() {
                translate([0, yTubeRadius, 0])
                    xHalfDiamantTube(yTubeRadius, carriageWidth/2);
                translate([xHolderx, xshaftZ+yTubeRadius, xxshaftz])
                    rotate([0, 90, 0]) rotate([0, 0, 180])
                        xDiamantTube(xTubeRadius, xHolderLenght, 235);
                translate([xHolderx, -xshaft[radius], xxshaftz])
                    rotate([0, -90, -90])
                        xDiamantCube([carriageSideWidth-xxshaftz, xHolderLenght, xTubeRadius], sides = [0, 0, 1, 0], bevel = [0, 0, 1, 0], yoffset = -
                        diamantLength/2-diamantSpacing);
                translate([xHolderx, -xshaft[radius], carriageWidth/2-xshaftDistance/2+carriageSideWidth-xxshaftz])
                    rotate([0, 90, -90])
                        xDiamantCube([carriageSideWidth-xxshaftz, xHolderLenght, xTubeRadius], sides = [1, 0, 1, 0], bevel = [1, 0, 1, 0], diamants = false);
                translate([idlerBoxX, idlerTopY+idlerHeight(yidler)+idlerSpacer+idlerHolderTopThick, carriageWidth/2])
                    rotate([90, 90, 0])
						ccube(carriageWidthBox/2, idlerSpaceDepth, idlerSpaceThick+idlerHolderBotThick+idlerHolderTopThick);
                translate([0, yTubeRadius, 0])
                    ccylinder(bevelWidth+chamfer, yTubeRadius+bevelHeight, chamfer, bevelHeight);
                for (p = yCarriageScrewPs)
					translate([p.x, p.y, chamfer])
						cylinder(r = yCarriageScrewPtr, h = carriageSideWidth-chamfer);
            }
			translate([idlerBoxX, idlerTopY+idlerHeight(yidler)+idlerSpacer+idlerHolderTopThick, carriageWidth/2])
				rotate([90, 90, 0])
					translate([-1, -1, idlerHolderTopThick]) ccube(idlerSpaceWidth/2+1, idlerSpaceDepth+2, idlerSpaceThick);
            translate([0, yTubeRadius, bushingTapWidth])
                cylinder(h = carriageWidth/2, r = yshaft[bushingRadius]);
            translate([0, yTubeRadius, -1])
                cylinder(h = bushingTapWidth+2, r = yshaft[bushingRadius]-bushingTap);
            translate([xHolderx-3, xshaftZ+yTubeRadius, xxshaftz])
                rotate([0, 90, 0])
                    cylinder(r = xshaft[radius], h = xHolderLenght+5);
            translate([0, yTubeRadius, 0])
                rotate([0, 0, 25])
                    translate([-yTubeRadius*2, -yTubeRadius*1.1, carriageSideWidth])
                        cube([yTubeRadius*2, yTubeRadius*2.2, carriageWidth/2]);
			xscrewHole(idlerP);
			for (p=yCarriageXScrewPs) {
				xscrewHole(p);
				xnutHole(p,twist=30);
			}
        }
    }
	xscrew(idlerP, showScrews = showScrews, plate = idlerHolderTopThick+0.5);
	xnut(idlerP, showScrews = showScrews);
	for (p=yCarriageXScrewPs) {
		xscrew(p, showScrews = showScrews);
		xnut(p, showScrews = showScrews,twist=30);
	}

    tube();
}

module yCarriageSpacer(color = undef) {
	module c() { translate([-yCarriageScrewPtr, 0, 0]) cube([yCarriageScrewPtr*2, bushingWall+bushingTap*1.5, carriageWidthHole]); }
	c();
	cylinder(r = yCarriageScrewPtr, h = carriageWidthHole);
	translate([0,0,carriageWidthHole]) intersection() {
		c();
		translate([0,yTubeRadius,0]) cylinder(r=yshaft[bushingRadius]-slack,h=bushingTap);
	}
}

module yCarriageRightFront(color = undef, showScrews = false) {
    difference() {
        union() {
            yCarriageSide(color = color, showScrews = showScrews);
            translate([0, 0, carriageWidth]) mirror([0, 0, 1]) yCarriageSide(color = color, showScrews = showScrews);
        }
        for (p = yCarriageScrewPs) {
            xscrewHole(p);
            xnutHole(p, twist = 30);
        }
    }
    for (p = yCarriageScrewPs) {
        xscrew(p, showScrews = showScrews, plate = 0);
        xnut(p, showScrews = showScrews, twist = 30, plate = 0);
    }

    translate([0, yTubeRadius, carriageSideWidth])
        color(accentColor)
			rotate([0, 0, -90+asin((yTubeRadius-yCarriageScrewP2y)/yTubeRadius)])
				translate([0, -yTubeRadius, 0])
					yCarriageSpacer();

    if (showScrews) color(aluColor) {
        translate([yIdlerDist, xshaftZ+idlerSpacer/2+yTubeRadius, carriageWidth/2-yidler[radius]*2-beltBaseThick(belt)])
            rotate([-90, 0, 0])
                thePulley(yidler);
        translate([yIdlerDist, xshaftZ-idlerSpacer/2-idlerHeight(yidler)+yTubeRadius, carriageWidth/2+yidler[radius]*2+beltBaseThick(belt)])
            rotate([-90, 0, 0])
                thePulley(yidler);
    }
}

yCarriageRightFront(showScrews = true);



/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/