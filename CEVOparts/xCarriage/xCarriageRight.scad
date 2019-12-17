
//*******************************************************************
// Right part of xCarriage
//*******************************************************************

use <../imports/Chamfer.scad>;

include <xCarriageDefinitions.scad>
use <../util/diamants.scad>
use <../util/util.scad>



module carriageSide(color=undef,showScrews=false) {

	module tube(cutAt=0) {
		color(color) difference() {
			union() {
				translate([0,xTubeRadius,0]) 
					ccylinder(bevelWidth+chamfer,xTubeRadius+bevelHeight,chamfer,bevelHeight); 
				translate([0,xTubeRadius,bevelWidth+chamfer]) 
					cylinder(h=carriageWidth/2-bevelWidth-chamfer,r=xTubeRadius); 
				translate([0,-bevelHeight,0]) 
					chamferCube(carriageTubeRadius,xTubeRadius*2+bevelHeight,bevelWidth+chamfer+(chamfer-bevelHeight),chamfer,[1,1,0,1],[0,0,0,0],[0,0,0,0]);
				translate([0,0,bevelWidth+chamfer]) 
					cube([carriageTubeRadius,xTubeRadius*2,carriageThick-bevelWidth-chamfer]);
				translate([0,0,carriageThick]) 
					cube([carriageTubeRadius,carriageTubeRadius,carriageWidth/2-carriageThick]);
				b = bevelWidth+chamfer-bevelHeight; h = carriageWidth/2-b;
				translate([0,0,b]) 
					rotate([90,0,0]) 
						diamantPlate(carriageTubeRadius,h,yoffset=h%(diamantLength+diamantSpacing)-diamantLength-diamantSpacing/2);
				translate([0,xTubeRadius,carriageWidth/2])
					rotate([180,0,-180])
						diamantTube(xTubeRadius,235,h,zoffset=-diamantLength/2-diamantSpacing);
				translate([carriageTubeRadius-bevelHeight,-bevelHeight,b]) 
					chamferCube(bevelHeight,bevelHeight,h,bevelHeight,[0,0,0,0],[0,0,0,0],[1,0,0,0]);
			}
			translate([0,xTubeRadius,bushingTap]) 
				cylinder(h=carriageWidth/2, r=xshaft[bushingRadius]);
			translate([0,xTubeRadius,-1]) 
				cylinder(h=bushingTap+2, r=xshaft[bushingRadius]-bushingTap);
			translate([carriageScrewX,carriageScrewY,carriageWidth/2])
				screwHole(carriageScrew,carriageWidth/2);
		}
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
	
	tubeFront();
	tubeBack();
	color(color) {
		translate([carriageTubeRadius,carriageThick-bevelHeight,0]) 
			chamferCube(carriagePlateDepth,xTubeRadius*2-carriageThick+bevelHeight,carriageThick,chamfer,[0,1,0,0],[0,0,0,0],[0,0,0,0]);
	}
}

module xCarriageRight(color=undef,showScrews=false) {
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
}

xCarriageRight();



/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/