
//*******************************************************************
// Right part of xCarriage
//*******************************************************************

use <../imports/Chamfer.scad>;

include <yCarriagesDefinitions.scad>
use <../util/diamants.scad>
use <../util/util.scad>



module yCarriageSide(color=undef,showScrews=false) {
	idlerSpaceThick = 2*idlerHeight(yidler)+3*idlerSpacer;
	idlerSpaceY = xshaftZ+yTubeRadius+idlerSpaceThick/2;
	yTubeRadiusX = yIdlerDist+yidler[radius];
	yTubeRadiusXY = 2*yTubeRadius-yTubeRadiusX;
echo(carriageWidth=carriageWidth,yTubeRadius=yTubeRadius);
	module tube() {
		color(color) difference() {
			union() {
				translate([0,yTubeRadius,0]) 
					ccylinder(bevelWidth+chamfer,yTubeRadius+bevelHeight,chamfer,bevelHeight); 
				translate([0,yTubeRadius,bevelWidth+chamfer]) 
					cylinder(h=carriageWidth/2-bevelWidth-chamfer,r=yTubeRadius); 
				difference() {
					union() {
						translate([0,yTubeRadiusXY,0]) 
							ccylinder(bevelWidth+chamfer,yTubeRadiusX+bevelHeight,chamfer,bevelHeight); 
						translate([0,yTubeRadiusXY,bevelWidth+chamfer]) 
							cylinder(h=carriageWidth/2-bevelWidth-chamfer,r=yTubeRadiusX); 
					}
					translate([-yTubeRadius*2,-yTubeRadius,-0.1])
						cube([yTubeRadius*2,yTubeRadius*3,carriageWidth]);
					translate([-0.1,idlerSpaceY-yTubeRadius*2,-0.1])
						cube([yTubeRadiusX-beltBaseThick(belt)+0.1,yTubeRadius*2,carriageWidth]);
				}
				translate([0,yTubeRadiusXY,0]) mirror([0,1,0])
					cube([yTubeRadiusX-beltBaseThick(belt),yTubeRadiusXY-idlerSpaceY+idlerSpaceThick+idlerHolderBotThick,carriageWidth/2]);
				translate([yTubeRadius-5,xshaftZ+yTubeRadius,xTubeRadius])
					rotate([0,-90,0])
						cylinder(r=xTubeRadius,h=yTubeRadius*2+5);
				translate([-yTubeRadius,xshaftZ+yTubeRadius,0])
					cube([yTubeRadius*2,-xshaftZ,2*xTubeRadius]);
				b = bevelWidth+chamfer-bevelHeight; h = carriageWidth/2-b;
				translate([0,yTubeRadius,carriageWidth/2])
					rotate([180,0,-180])
						diamantTube(yTubeRadius,235,h,zoffset=-diamantLength/2-diamantSpacing);
			}
			translate([0,yTubeRadius,bushingTap]) 
				cylinder(h=carriageWidth/2, r=yshaft[bushingRadius]);
			translate([0,yTubeRadius,-1]) 
				cylinder(h=bushingTap+2, r=yshaft[bushingRadius]-bushingTap);
			translate([yTubeRadius-screwTapMinThick-0.1,xshaftZ+yTubeRadius,xTubeRadius])
				rotate([0,-90,0])
					cylinder(r=xshaft[radius],h=yTubeRadius*2-screwTapMinThick+0.1);
			translate([-yTubeRadius*2,-bevelWidth-0.1,carriageSideWidth])
				cube([yTubeRadius*2,yTubeRadius*3,carriageWidth/2]);
			translate([-0.1,idlerSpaceY-idlerSpaceThick,carriageSideWidth])
				cube([yTubeRadiusX*2,idlerSpaceThick,carriageWidth/2]);
		}
		//translate([10,-20,0]) cube([25,40,25]);
		/*
		color(color) difference() {
			translate([carriageTubeRadius,carriageThick-bevelHeight,carriageThick]) 
				cube([carriageMountScrew[nutHoleRadius]*2+carriagePlateNudge,screwTapSolidThick,carriageMountScrew[nutHoleRadius]*2]);
			translate([carriageTubeRadius+carriagePlateScrewX,carriageThick-bevelHeight,carriageThick+carriagePlateScrewY]) 
				rotate([90,0,0]) 
					screwHole(carriageMountScrew,carriageThick);//cylinder(h=carriageThick,r=carriageMountScrew[holeRadius]);
		}
		if (showScrews) color(screwColor) {
			translate([carriageTubeRadius+carriagePlateScrewX,carriageThick-bevelHeight+screwTapSolidThick,carriageThick+carriagePlateScrewY]) 
				rotate([-90,0,0]) 
					nut(carriageScrew);
		}
		*/
	}
	
	module tubeFront() {
		cutAt=(carriageWidth-carriageWidthHole)/2;
		difference() {
			tube();
			color(color) translate([-xTubeRadius*2.5,-xTubeRadius*0.5,cutAt]) 
				cube([xTubeRadius*5,xTubeRadius*3,carriageWidth]);
		}
		color(color) difference() {
			translate([0,xTubeRadius,cutAt-bevelWidth])
				ccylinder(bevelWidth,xTubeRadius+bevelHeight,bevelHeight);
			translate([xTubeRadius-bushingWall*2,-bevelHeight-0.2,cutAt-bevelWidth-0.2])
				rotate([0,0,-10])
					cube([bushingWall*3,xTubeRadius*2,bevelWidth+bevelHeight+0.4]);
			translate([0,xTubeRadius,cutAt-bevelWidth-1]) 
				cylinder(h=bevelWidth+2,r=xshaft[bushingRadius]);
		}
		color(color) translate([0,-bevelHeight,cutAt-bevelWidth]) 
			chamferCube(carriageTubeRadius,bevelHeight,bevelWidth,bevelHeight,[1,0,0,0],[0,0,0,0],[0,0,0,0]);
	}

	module tubeBack() {
		tapx = carriageMountScrew[nutHoleWidth]*4; tapy = xTubeRadius; tapz = carriageMountScrew[nutHoleWidth]*2+tapy;
		module tap() {
			color(color) {
				translate([xshaftDistance,-bevelHeight*1,carriageWidth/2-tapz])
					chamferCube(tapx,tapy,tapz,tapy,[1,0,0,0],[0,0,0,0],[0,0,0,0]);
			}
		}
		module tapHole() {
			color(color) {
				translate([xshaftDistance,xTubeRadius,carriageWidth/2-tapz-1]) 
					cylinder(h=tapz+2,r=xshaft[bushingRadius]);
				translate([xshaftDistance+tapx-carriageMountScrew[nutHoleWidth]*1.5,screwTapMinThick-bevelHeight,carriageWidth/2-carriageMountScrew[nutHoleWidth]/2]) 
					rotate([-90,0,0]) 
						nutHole(carriageMountScrew,0);
				translate([xshaftDistance+tapx-carriageMountScrew[nutHoleWidth]*1.5,-1,carriageWidth/2]) 
					rotate([-90,0,0]) 
						cylinder(h=screwTapMinThick+2,r=carriageMountScrew[holeRadius]);
			}
		}
		
		difference() {
			union() {
				translate([xshaftDistance,0,0]) mirror([1,0,0]) tube();
				tap();
				translate([0,xTubeRadius*2,0]) mirror([0,1,0]) tap();
			}
			tapHole();
			translate([0,xTubeRadius*2,0]) mirror([0,1,0]) tapHole();
		}
	}
	
	/*tubeFront();
	tubeBack();
	color(color) {
		translate([carriageTubeRadius,carriageThick-bevelHeight,0]) 
			chamferCube(carriagePlateDepth,xTubeRadius*2-carriageThick+bevelHeight,carriageThick,chamfer,[0,1,0,0],[0,0,0,0],[0,0,0,0]);
	}*/
	tube();
}

module yCarriageRightFront(color=undef,showScrews=false) {
	yCarriageSide();
	translate([0,0,carriageWidth]) mirror([0,0,1]) yCarriageSide();
/*		cylinder(r=yTubeRadius,h=carriageWidth);
		translate([yTubeRadius,xshaftZ,xTubeRadius])
			rotate([0,-90,0])
				cylinder(r=xTubeRadius,h=yTubeRadius*2);
		translate([-yTubeRadius,xshaftZ,0])
			cube([yTubeRadius*2,-xshaftZ,2*xTubeRadius]);*/
		translate([yIdlerDist,xshaftZ+idlerSpacer/2+yTubeRadius,carriageWidth/2-yidler[radius]*2-beltBaseThick(belt)])
			rotate([-90,0,0])
				theIdler(yidler);
		translate([yIdlerDist,xshaftZ-idlerSpacer/2-idlerHeight(yidler)+yTubeRadius,carriageWidth/2+yidler[radius]*2+beltBaseThick(belt)])
			rotate([-90,0,0])
				theIdler(yidler);
/*
	difference() {
		carriageSide(color,showScrews);
		color(color) {
			translate([carriageScrewX,carriageScrewY,0])
				rotate([180,0,0])
					screwHeadHole(carriageScrew);
			translate([xshaftDistance-carriageScrewX,carriageScrewY,0])
				rotate([180,0,0])
					screwHeadHole(carriageScrew);
		}
	}
	if (showScrews) color(screwColor) {
		translate([carriageScrewX,carriageScrewY,0])
			rotate([180,0,0])
				screwHead(carriageScrew,1);
		translate([xshaftDistance-carriageScrewX,carriageScrewY,0])
			rotate([180,0,0])
				screwHead(carriageScrew,1);
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