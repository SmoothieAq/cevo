
//*******************************************************************
// Top plate for xCarriage
//*******************************************************************

use <../imports/Chamfer.scad>;

include <xCarriageDefinitions.scad>
use <../util/diamants.scad>
use <../util/util.scad>


module xCarriagePlate(color=undef,showScrews=false) {
	module mountHole(x,y) { color(color) translate([x,y,carriageThick]) screwHole(ycMountScrew,carriageThick); }
	module mountHeadHole(x,y) { color(color) translate([x,y,carriageThick]) screwHeadHole(ycMountScrew); }
	module mountAllHole(x,y) { mountHole(x,y); mountHeadHole(x,y); }
	module mountScrewHead(x,y) { if (showScrews) color(screwColor) translate([x,y,carriageThick]) screwHead(ycMountScrew,1); }
	
	thick = carriageThick-bevelHeight;
	
	module quater() {
		color(color) {
			cube([carriageWidth/2-chamfer,carriagePlateDepth/2,thick]);
			b = bevelWidth+chamfer-bevelHeight; h = carriageWidth/2-b;
			endbev = bevelWidth+chamfer+(chamfer-bevelHeight);
			translate([carriageWidth/2-endbev,0,0]) 
				chamferCube(endbev,carriagePlateDepth/2,carriageThick,chamfer,[0,0,0,0],[0,1,1,0],[0,0,0,0]);
			translate([0,carriagePlateDepth/2-bevelWidth,thick]) 
				chamferCube(carriageWidth/2-bevelWidth,bevelWidth,bevelHeight,bevelHeight,[0,0,0,1],[0,0,0,0],[0,0,0,0]);
			translate([h,0,thick]) //translate([0,carriagePlateDepth/2,thick]) 
				rotate([0,0,90]) 
					diamantPlate(carriagePlateDepth/2,h,yoffset=h%(diamantLength+diamantSpacing)-diamantLength-diamantSpacing/2);
		}
	}
	module quaterHoles() {
		mountAllHole(carriageWidth/2-carriagePlateScrewY-carriageThick,carriagePlateDepth/2-carriagePlateScrewX);
	}
	module quaterScrews() {
		mountScrewHead(carriageWidth/2-carriagePlateScrewY-carriageThick,carriagePlateDepth/2-carriagePlateScrewX);
	}
	
	module toHalf() { children(); mirror([0,1,0]) children(); } 
	module toFull() { toHalf() children(); mirror([1,0,0]) toHalf() children(); } 
	
	module half() {
		quater();
		mirror([0,1,0]) quater();
	}
	module halfHoles() {
		quaterHoles();
		mirror([0,1,0]) quaterHoles();
	}

	module full() {
		half();
		mirror([1,0,0]) half();
	}
	module fullHoles() {
		halfHoles();
		mirror([1,0,0]) halfHoles();
	}

	module nimbleFooter() {
		color(color) {
			translate([0,0,thick])
				ccylinder(bevelHeight,22/2+bevelHeight,0,bevelHeight);
			translate([14,-2,thick])
				ccylinder(bevelHeight,7/2+bevelHeight,0,bevelHeight);
			translate([-2,15,thick])
				ccylinder(bevelHeight,7/2+bevelHeight,0,bevelHeight);
			translate([7.5,20,thick])
				ccylinder(bevelHeight,17/2+bevelHeight,0,bevelHeight);
		}
	}
	
	module nimbleHoles() {
		mountHole(14,-2);
		mountHole(-2,15);
	}
	
	dx = 9; dy = 9;
	module e3dHoles() {
		mountAllHole(dx,dy);
		mountAllHole(dx,-dy);
		mountAllHole(-dx,dy);
		mountAllHole(-dx,-dy);
	}
	module e3dScrews() {
		mountScrewHead(dx,dy);
		mountScrewHead(dx,-dy);
		mountScrewHead(-dx,dy);
		mountScrewHead(-dx,-dy);
	}

	difference() {
		union() {
			toFull() quater();
			translate(hotendOffset) nimbleFooter();
		}
		toFull() quaterHoles();
		translate(hotendOffset) {
			e3dHoles();
			nimbleHoles();
		}
		color(color) {
			translate([-carriageWidth/2-1,-carriagePlateDepth,-1]) 
				cube([carriageWidth+2,carriagePlateDepth/2,carriageThick+2]);
			translate([-carriageWidth/2-1,carriagePlateDepth/2,-1]) 
				cube([carriageWidth+2,carriagePlateDepth/2,carriageThick+2]);
		}
	}
	toFull() quaterScrews();
	translate(hotendOffset) {
		e3dScrews();
	}
}
xCarriagePlate(color=mainColor,showScrews=true);



/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/