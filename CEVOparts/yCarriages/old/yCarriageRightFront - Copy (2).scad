
//*******************************************************************
// Right part of xCarriage
//*******************************************************************

use <../imports/Chamfer.scad>;

include <yCarriagesDefinitions.scad>
use <../util/diamants.scad>
use <../util/util.scad>
use <../xutil/xutil.scad>


module yCarriageSide(color=undef,showScrews=false) {
	motorClearance = 16;
	idlerX = ycTubeRadius;
	idlerTopY = xshaftOffset+ycTubeRadius+idlerSpacer/2;
	idlerBotY = xshaftOffset+ycTubeRadius-idlerHeight(yidler)-idlerSpacer/2;
	idlerBackZ = carriageWidth/2-2*yidler[radius]-idlerSpacer/2;
	idlerFrontZ = carriageWidth/2+2*yidler[radius]+idlerSpacer/2;
	idlerBoxX = -yshaft[radius];
	idlerSpaceThick = 2*idlerHeight(yidler)+3*idlerSpacer;
	idlerSpaceWidth = carriageWidthHole;
	idlerSpaceDepth = idlerX+yidler[radius]-beltBaseThick(belt)-idlerBoxX; //max(yidler[radius]*3,ycTubeRadius-yshaft[radius]+yidler[radius]);
echo(idlerX=idlerX,idlerTopY=idlerTopY,idlerBotY=idlerBotY);
echo(idlerSpaceThick=idlerX,idlerSpaceWidth=idlerSpaceWidth,idlerSpaceDepth=idlerSpaceDepth);
	module idlerBox() {
		difference() {
			ccube(carriageWidthBox/2,idlerSpaceDepth,idlerSpaceThick+ycIdlerHolderBotThick+ycIdlerHolderTopThick);
			translate([-1,-1,ycIdlerHolderTopThick]) ccube(idlerSpaceWidth/2+1,idlerSpaceDepth+2,idlerSpaceThick);
		}
	}
	module tube() {
		color(color) difference() {
			union() {
				translate([0,ycTubeRadius,0]) xHalfDiamantTube(ycTubeRadius,carriageWidth/2);
				/*translate([0,ycTubeRadius,0])
					ccylinder(bevelWidth+chamfer,ycTubeRadius+bevelHeight,chamfer,bevelHeight);
				translate([0,ycTubeRadius,bevelWidth+chamfer])
					cylinder(h=carriageWidth/2-bevelWidth-chamfer,r=ycTubeRadius);
				translate([0,ycTubeRadius,carriageWidth/2])
					rotate([180,0,-180])
						diamantTube(ycTubeRadius,360,carriageWidth/2-bevelWidth+chamfer-bevelHeight,zoffset=-diamantLength/2-diamantSpacing);*/
				ir = ycTubeRadius-(ycTubeRadius+xshaftOffset+ycXTubeRadius); echo(ycTubeRadius=ycTubeRadius,xshaftOffset=xshaftOffset,ir=ir);
				translate([-ycTubeRadius-ir,ycTubeRadius,]) rotate([0,0,-90])
					cpieQuater(bevelWidth+chamfer,ir-bevelHeight,-chamfer,-bevelHeight); 
				*translate([0,ycTubeRadius,bevelWidth+chamfer])
					cylinder(h=carriageWidth/2-bevelWidth-chamfer,r=ycTubeRadius);
				translate([-ycXHolderLenght+idlerBoxX+idlerSpaceDepth-motorClearance,xshaftOffset+ycTubeRadius-ycXTubeRadius,0])
					cube([ycXHolderLenght,ycXTubeRadius*2,carriageSideWidth]);
				translate([idlerBoxX,idlerTopY+idlerHeight(yidler)+idlerSpacer+ycIdlerHolderTopThick,carriageWidth/2])
					rotate([90,90,0])
						idlerBox();
				translate([0,ycTubeRadius,0])
					ccylinder(bevelWidth+chamfer,ycTubeRadius+bevelHeight,chamfer,bevelHeight);
				translate([0,ycTubeRadius,bevelWidth+chamfer])
					cylinder(h=carriageWidth/2-bevelWidth-chamfer,r=ycTubeRadius);
			}
			translate([0,ycTubeRadius,bushingTap])
				cylinder(h=carriageWidth/2, r=yshaft[bushingRadius]);
			translate([0,ycTubeRadius,-1])
				cylinder(h=bushingTap+2, r=yshaft[bushingRadius]-bushingTap);
			translate([ycTubeRadius-screwTapMinThick-0.1,xshaftOffset+ycTubeRadius,ycXTubeRadius])
				rotate([0,-90,0])
					cylinder(r=xshaft[radius],h=ycTubeRadius*2-screwTapMinThick+0.1);
			translate([0,ycTubeRadius,0])
				rotate([0,0,35])
					translate([-ycTubeRadius*2,-ycTubeRadius*1.1,carriageSideWidth])
						cube([ycTubeRadius*2,ycTubeRadius*2.2,carriageWidth/2]);
			translate([ycTubeRadius-yshaft[radius]+ycScrew[nutHoleWidth],ycTubeRadius-yshaft[radius]-ycScrew[nutHoleWidth],-5]) rotate([0,0,0]) cylinder(r=2,h=90);
			translate([idlerX,-30,idlerBackZ]) rotate([-90,0,0]) cylinder(r=1.5,h=60);
		}
	}
	
	tube();
}

module yCarriageRightFront(color=undef,showScrews=false) {
	yCarriageSide(color=color,showScrews=showScrews);
	translate([0,0,carriageWidth]) mirror([0,0,1]) yCarriageSide(color=color,showScrews=showScrews);

	translate([yIdlerDist,xshaftOffset+idlerSpacer/2+ycTubeRadius,carriageWidth/2-yidler[radius]*2-beltBaseThick(belt)])
			rotate([-90,0,0])
				thePulley(yidler);
		translate([yIdlerDist,xshaftOffset-idlerSpacer/2-idlerHeight(yidler)+ycTubeRadius,carriageWidth/2+yidler[radius]*2+beltBaseThick(belt)])
			rotate([-90,0,0])
				thePulley(yidler);
}

yCarriageRightFront();



/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/