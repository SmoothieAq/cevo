
//*******************************************************************
// Right part of xCarriage
//*******************************************************************

use <../imports/Chamfer.scad>;

include <yCarriagesDefinitions.scad>
use <../util/diamants.scad>
use <../util/util.scad>



module yCarriageSide(color=undef,showScrews=false) {
	motorClearance = 14;
	idlerX = yTubeRadius;
	idlerTopY = xshaftZ+yTubeRadius+idlerSpacer/2;
	idlerBotY = xshaftZ+yTubeRadius-idlerHeight(yidler)-idlerSpacer/2;
	idlerBackZ = carriageWidth/2-2*yidler[radius]-idlerSpacer/2;
	idlerFrontZ = carriageWidth/2+2*yidler[radius]+idlerSpacer/2;
	idlerBoxX = -yshaft[radius];
	idlerSpaceThick = 2*idlerHeight(yidler)+3*idlerSpacer;
	idlerSpaceWidth = 4*yidler[radius]+2*yidler[flangeRadius]+4*beltBaseThick(belt);
	idlerSpaceDepth = idlerX+yidler[radius]-beltBaseThick(belt)-idlerBoxX; //max(yidler[radius]*3,yTubeRadius-yshaft[radius]+yidler[radius]);
echo(idlerX=idlerX,idlerTopY=idlerTopY,idlerBotY=idlerBotY);
echo(idlerSpaceThick=idlerX,idlerSpaceWidth=idlerSpaceWidth,idlerSpaceDepth=idlerSpaceDepth);
	module idlerBox() {
		difference() {
			ccube(idlerSpaceWidth/2+idlerHolderBotThick,idlerSpaceDepth,idlerSpaceThick+idlerHolderBotThick+idlerHolderTopThick);
			translate([-1,-1,idlerHolderTopThick]) ccube(idlerSpaceWidth/2+1,idlerSpaceDepth+2,idlerSpaceThick);
		}
	}
	module tube() {
		color(color) difference() {
			union() {
				translate([0,yTubeRadius,0]) 
					ccylinder(bevelWidth+chamfer,yTubeRadius+bevelHeight,chamfer,bevelHeight); 
				translate([0,yTubeRadius,bevelWidth+chamfer]) 
					cylinder(h=carriageWidth/2-bevelWidth-chamfer,r=yTubeRadius); 
				translate([0,yTubeRadius,carriageWidth/2])
					rotate([180,0,-180])
						diamantTube(yTubeRadius,360,carriageWidth/2-bevelWidth+chamfer-bevelHeight,zoffset=-diamantLength/2-diamantSpacing);
				ir = yTubeRadius-(yTubeRadius+xshaftZ+xTubeRadius); echo(yTubeRadius=yTubeRadius,xshaftZ=xshaftZ,ir=ir);
				#translate([-yTubeRadius-ir,yTubeRadius,]) rotate([0,0,-90])
					#cpieQuater(bevelWidth+chamfer,ir-bevelHeight,-chamfer,-bevelHeight); 
				*translate([0,yTubeRadius,bevelWidth+chamfer]) 
					cylinder(h=carriageWidth/2-bevelWidth-chamfer,r=yTubeRadius); 
				translate([-xHolderLenght+idlerBoxX+idlerSpaceDepth-motorClearance,xshaftZ+yTubeRadius-xTubeRadius,0])
					cube([xHolderLenght,xTubeRadius*2,carriageSideWidth]);
				translate([idlerBoxX,idlerTopY+idlerHeight(yidler)+idlerSpacer+idlerHolderTopThick,carriageWidth/2]) 
					rotate([90,90,0])
						idlerBox();
				translate([0,yTubeRadius,0]) 
					ccylinder(bevelWidth+chamfer,yTubeRadius+bevelHeight,chamfer,bevelHeight); 
				translate([0,yTubeRadius,bevelWidth+chamfer]) 
					cylinder(h=carriageWidth/2-bevelWidth-chamfer,r=yTubeRadius); 
			}
			translate([0,yTubeRadius,bushingTap]) 
				cylinder(h=carriageWidth/2, r=yshaft[bushingRadius]);
			translate([0,yTubeRadius,-1]) 
				cylinder(h=bushingTap+2, r=yshaft[bushingRadius]-bushingTap);
			translate([yTubeRadius-screwTapMinThick-0.1,xshaftZ+yTubeRadius,xTubeRadius])
				rotate([0,-90,0])
					cylinder(r=xshaft[radius],h=yTubeRadius*2-screwTapMinThick+0.1);
			translate([0,yTubeRadius,0])
				rotate([0,0,35])
					translate([-yTubeRadius*2,-yTubeRadius*1.1,carriageSideWidth])
						cube([yTubeRadius*2,yTubeRadius*2.2,carriageWidth/2]);
			translate([yTubeRadius-yshaft[radius]+carriageScrew[nutHoleWidth],yTubeRadius-yshaft[radius]-carriageScrew[nutHoleWidth],-5]) rotate([0,0,0]) cylinder(r=2,h=90);
			translate([idlerX,-30,idlerBackZ]) rotate([-90,0,0]) cylinder(r=1.5,h=60);
		}
	}
	
	tube();
}

module yCarriageRightFront(color=undef,showScrews=false) {
	yCarriageSide(color=color,showScrews=showScrews);
	translate([0,0,carriageWidth]) mirror([0,0,1]) yCarriageSide(color=color,showScrews=showScrews);

	translate([yIdlerDist,xshaftZ+idlerSpacer/2+yTubeRadius,carriageWidth/2-yidler[radius]*2-beltBaseThick(belt)])
			rotate([-90,0,0])
				thePulley(yidler);
		translate([yIdlerDist,xshaftZ-idlerSpacer/2-idlerHeight(yidler)+yTubeRadius,carriageWidth/2+yidler[radius]*2+beltBaseThick(belt)])
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