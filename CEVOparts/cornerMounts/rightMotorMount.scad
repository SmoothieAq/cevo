
//*******************************************************************
// The front right inner shaft mount
//*******************************************************************

use <../util/util.scad>
include <cornerMountsDefinitions.scad>
use <../xutil.scad>


module beltMotorMount(color=undef,showScrews=false,lg) {
	
	mw 			= beltStepperMotor[width];
	mwx 		= mw+slack;
	guideX 		= beltStepperMotor[width]+stepperOuterEdgeX-extrusionWidth-partMountingThick;
	guideH 		= stepperTopOuterEdgeZ-yshaftMountHeight;
	guideHH 	= mw/2;
	guideHHH	= guideHH+screwTapSolidThick+frameScrew[radius];
	mountPoints = [[mw/2,partMountingThick,guideHH,-90,0,0],
				   [guideX,-extrusionWidth/2,guideH/2,0,-90,0]];
	sd 			= mwx-beltStepperMotor[champfer]+chamfer-bevelHeight;
	
	module support() {
		translate([partMountingThick,sd,0]) rotate([90,0,-90])
			xDiamantCubex([sd,partMountingThick*2,guideHH,partMountingThick],sides=[1,1,0,1],bevel=[1,1,1,1],diamantHoriz=true);
	}
	
	color(color) {
		difference() {
			union() {
				xMotorMount(beltStepperMotor,allChamfer=true,lg=lg);
				translate([mw-partMountingThick,sd,0]) rotate([90,0,-90]) difference() {
					cubex([sd,partMountingThick*2,guideHH,mw-2*partMountingThick]);
					translate([-1,-1,-1]) cube([sd-partMountingThick+1,guideHH+1,mw]);
				}
				translate([partMountingExExWidth+(mw-partMountingExExWidth)/2,0,0]) rotate([90,0,180])
					xcube([partMountingExExWidth,guideHHH,partMountingThick],[1,1,0,1]);
				support();
				translate([mw,0,0]) mirror([1,0,0]) support();
				translate([guideX+partMountingThick,-partMountingExWidth,0]) rotate([0,-90,0])
					xcube([guideH,partMountingExWidth,partMountingThick],[0,0,1,1]);
				difference() {
					translate([guideX,0,guideH+frameMountingScrew[holeRadius]+screwTapThick*3]) 
						rotate([-55,0,0]) translate([0,0,-partMountingExWidth/3*2])
							cube([partMountingThick,(guideH),partMountingExWidth/3*2]);
					translate([guideX-1,0,-1]) cube([partMountingThick+2,partMountingExWidth,(guideH)*2]);
					translate([guideX-1,-partMountingExWidth+1,guideHH]) cube([partMountingThick+2,partMountingExWidth,partMountingExWidth]);
				}
			}
			xMotorMountScrewHoles(beltStepperMotor,lg=lg);
			for (p=mountPoints) xscrewHole(p,frameScrew);
		}
	}
	xMotorMountScrews(beltStepperMotor,lg=lg,showScrews=showScrews);
	for (p=mountPoints) xFrameScrew(p,frameScrew,lg=xxl(lg,d="frame mount"),showScrews=showScrews);
}

module rightMotorMount(color=undef,showScrews=false) {
	lg = xl(a="Belt path",sa="Front right motor mount",t="PETG");
	xxPartLog(lg,c="printed part",n="rightMotorMount");
	
	beltMotorMount(color,showScrews,lg);
}

rightMotorMount(showScrews=true);


/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/