
//*******************************************************************
// Right part of xCarriage
//*******************************************************************

use <../imports/Chamfer.scad>;

include <yCarriagesDefinitions.scad>
use <../util/diamants.scad>
use <../util/util.scad>



module yCarriageSide(color=undef,showScrews=false) {
	idlerSpaceThick = 2*idlerHeight(yidler)+3*idlerSpacer;
	idlerSpaceY = xshaftOffset+ycTubeRadius+idlerSpaceThick/2;
	yTubeRadiusX = yIdlerDist+yidler[radius];
	yTubeRadiusXY = 2*ycTubeRadius-yTubeRadiusX;
echo(carriageWidth=carriageWidth,ycTubeRadius=ycTubeRadius);
	module tube() {
		color(color) difference() {
			union() {
				translate([0,ycTubeRadius,0])
					ccylinder(bevelWidth+chamfer,ycTubeRadius+bevelHeight,chamfer,bevelHeight);
				translate([0,ycTubeRadius,bevelWidth+chamfer])
					cylinder(h=carriageWidth/2-bevelWidth-chamfer,r=ycTubeRadius);
				difference() {
					union() {
						translate([0,yTubeRadiusXY,0]) 
							ccylinder(bevelWidth+chamfer,yTubeRadiusX+bevelHeight,chamfer,bevelHeight); 
						translate([0,yTubeRadiusXY,bevelWidth+chamfer]) 
							cylinder(h=carriageWidth/2-bevelWidth-chamfer,r=yTubeRadiusX); 
					}
					translate([-ycTubeRadius*2,-ycTubeRadius,-0.1])
						cube([ycTubeRadius*2,ycTubeRadius*3,carriageWidth]);
					translate([-0.1,idlerSpaceY-ycTubeRadius*2,-0.1])
						cube([yTubeRadiusX-beltBaseThick(belt)+0.1,ycTubeRadius*2,carriageWidth]);
				}
				translate([0,yTubeRadiusXY,0]) mirror([0,1,0])
					cube([yTubeRadiusX-beltBaseThick(belt),yTubeRadiusXY-idlerSpaceY+idlerSpaceThick+ycIdlerHolderBotThick,carriageWidth/2]);
				translate([ycTubeRadius-5,xshaftOffset+ycTubeRadius,ycXTubeRadius])
					rotate([0,-90,0])
						cylinder(r=ycXTubeRadius,h=ycTubeRadius*2+5);
				translate([-ycTubeRadius,xshaftOffset+ycTubeRadius,0])
					cube([ycTubeRadius*2,-xshaftOffset,2*ycXTubeRadius]);
				b = bevelWidth+chamfer-bevelHeight; h = carriageWidth/2-b;
				translate([0,ycTubeRadius,carriageWidth/2])
					rotate([180,0,-180])
						diamantTube(ycTubeRadius,235,h,zoffset=-diamantLength/2-diamantSpacing);
			}
			translate([0,ycTubeRadius,bushingTap])
				cylinder(h=carriageWidth/2, r=yshaft[bushingRadius]);
			translate([0,ycTubeRadius,-1])
				cylinder(h=bushingTap+2, r=yshaft[bushingRadius]-bushingTap);
			translate([ycTubeRadius-screwTapMinThick-0.1,xshaftOffset+ycTubeRadius,ycXTubeRadius])
				rotate([0,-90,0])
					cylinder(r=xshaft[radius],h=ycTubeRadius*2-screwTapMinThick+0.1);
			translate([-ycTubeRadius*2,-bevelWidth-0.1,carriageSideWidth])
				cube([ycTubeRadius*2,ycTubeRadius*3,carriageWidth/2]);
			translate([-0.1,idlerSpaceY-idlerSpaceThick,carriageSideWidth])
				cube([yTubeRadiusX*2,idlerSpaceThick,carriageWidth/2]);
		}
		//translate([10,-20,0]) cube([25,40,25]);
		/*
		color(color) difference() {
			translate([carriageTubeRadius,carriageThick-bevelHeight,carriageThick]) 
				cube([ycMountScrew[nutHoleRadius]*2+carriagePlateNudge,screwTapSolidThick,ycMountScrew[nutHoleRadius]*2]);
			translate([carriageTubeRadius+carriagePlateScrewX,carriageThick-bevelHeight,carriageThick+carriagePlateScrewY]) 
				rotate([90,0,0]) 
					screwHole(ycMountScrew,carriageThick);//cylinder(h=carriageThick,r=ycMountScrew[holeRadius]);
		}
		if (showScrews) color(screwColor) {
			translate([carriageTubeRadius+carriagePlateScrewX,carriageThick-bevelHeight+screwTapSolidThick,carriageThick+carriagePlateScrewY]) 
				rotate([-90,0,0]) 
					nut(ycScrew);
		}
		*/
	}
	
	module tubeFront() {
		cutAt=(carriageWidth-carriageWidthHole)/2;
		difference() {
			tube();
			color(color) translate([-ycXTubeRadius*2.5,-ycXTubeRadius*0.5,cutAt])
				cube([ycXTubeRadius*5,ycXTubeRadius*3,carriageWidth]);
		}
		color(color) difference() {
			translate([0,ycXTubeRadius,cutAt-bevelWidth])
				ccylinder(bevelWidth,ycXTubeRadius+bevelHeight,bevelHeight);
			translate([ycXTubeRadius-bushingWall*2,-bevelHeight-0.2,cutAt-bevelWidth-0.2])
				rotate([0,0,-10])
					cube([bushingWall*3,ycXTubeRadius*2,bevelWidth+bevelHeight+0.4]);
			translate([0,ycXTubeRadius,cutAt-bevelWidth-1])
				cylinder(h=bevelWidth+2,r=xshaft[bushingRadius]);
		}
		color(color) translate([0,-bevelHeight,cutAt-bevelWidth]) 
			chamferCube(carriageTubeRadius,bevelHeight,bevelWidth,bevelHeight,[1,0,0,0],[0,0,0,0],[0,0,0,0]);
	}

	module tubeBack() {
		tapx = ycMountScrew[nutHoleWidth]*4; tapy = ycXTubeRadius; tapz = ycMountScrew[nutHoleWidth]*2+tapy;
		module tap() {
			color(color) {
				translate([xshaftDistance,-bevelHeight*1,carriageWidth/2-tapz])
					chamferCube(tapx,tapy,tapz,tapy,[1,0,0,0],[0,0,0,0],[0,0,0,0]);
			}
		}
		module tapHole() {
			color(color) {
				translate([xshaftDistance,ycXTubeRadius,carriageWidth/2-tapz-1])
					cylinder(h=tapz+2,r=xshaft[bushingRadius]);
				translate([xshaftDistance+tapx-ycMountScrew[nutHoleWidth]*1.5,screwTapMinThick-bevelHeight,carriageWidth/2-ycMountScrew[nutHoleWidth]/2])
					rotate([-90,0,0]) 
						nutHole(ycMountScrew,0);
				translate([xshaftDistance+tapx-ycMountScrew[nutHoleWidth]*1.5,-1,carriageWidth/2])
					rotate([-90,0,0]) 
						cylinder(h=screwTapMinThick+2,r=ycMountScrew[holeRadius]);
			}
		}
		
		difference() {
			union() {
				translate([xshaftDistance,0,0]) mirror([1,0,0]) tube();
				tap();
				translate([0,ycXTubeRadius*2,0]) mirror([0,1,0]) tap();
			}
			tapHole();
			translate([0,ycXTubeRadius*2,0]) mirror([0,1,0]) tapHole();
		}
	}
	
	/*tubeFront();
	tubeBack();
	color(color) {
		translate([carriageTubeRadius,carriageThick-bevelHeight,0]) 
			chamferCube(carriagePlateDepth,ycXTubeRadius*2-carriageThick+bevelHeight,carriageThick,chamfer,[0,1,0,0],[0,0,0,0],[0,0,0,0]);
	}*/
	tube();
}

module yCarriageRightFront(color=undef,showScrews=false) {
	yCarriageSide();
	translate([0,0,carriageWidth]) mirror([0,0,1]) yCarriageSide();
/*		cylinder(r=ycTubeRadius,h=carriageWidth);
		translate([ycTubeRadius,xshaftOffset,ycXTubeRadius])
			rotate([0,-90,0])
				cylinder(r=ycXTubeRadius,h=ycTubeRadius*2);
		translate([-ycTubeRadius,xshaftOffset,0])
			cube([ycTubeRadius*2,-xshaftOffset,2*ycXTubeRadius]);*/
		translate([yIdlerDist,xshaftOffset+idlerSpacer/2+ycTubeRadius,carriageWidth/2-yidler[radius]*2-beltBaseThick(belt)])
			rotate([-90,0,0])
				theIdler(yidler);
		translate([yIdlerDist,xshaftOffset-idlerSpacer/2-idlerHeight(yidler)+ycTubeRadius,carriageWidth/2+yidler[radius]*2+beltBaseThick(belt)])
			rotate([-90,0,0])
				theIdler(yidler);
/*
	difference() {
		carriageSide(color,showScrews);
		color(color) {
			translate([carriageScrewX,carriageScrewY,0])
				rotate([180,0,0])
					screwHeadHole(ycScrew);
			translate([xshaftDistance-carriageScrewX,carriageScrewY,0])
				rotate([180,0,0])
					screwHeadHole(ycScrew);
		}
	}
	if (showScrews) color(screwColor) {
		translate([carriageScrewX,carriageScrewY,0])
			rotate([180,0,0])
				screwHead(ycScrew,1);
		translate([xshaftDistance-carriageScrewX,carriageScrewY,0])
			rotate([180,0,0])
				screwHead(ycScrew,1);
	}
*/
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