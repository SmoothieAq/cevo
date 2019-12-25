
//*******************************************************************
// The front right inner shaft mount
//*******************************************************************

include <cornerMountsDefinitions.scad>
use <../util/diamants.scad>
use <../util/util.scad>
use <../xutil.scad>

// the whole mount - inner and outer cut their own parts
module yshaftMount(color=undef,showScrews=false,lg) {

	difference() {
		union() {
			xd1 = yshaftFrontMountDepth-extrusionWidth;
			// base plate
			translate([0,yshaftMountBaseHeight-yshaftMountHeight,0]) {
				difference() {
					xcube([yshaftFrontMountDepth-yshaftMountDepthIn,yshaftMountHeight-yshaftMountHeightIn,partMountingThick],[1,1,0,0]);
					translate([-1,-1,-1])
						cube([xd1+1,yshaftMountHeight-extrusionWidth-yshaftHolderRadius+1,partMountingThick+2]);
					translate([xd1,frameScrew[holeRadius]+screwTapThick*3,-1]) 
						rotate([0,0,-125]) 
							cube([yshaftFrontMountDepth,yshaftMountHeight,partMountingThick+2]);
					translate([xd1,yshaftMountHeight,0]) 
						rotate([0,0,-45]) 
							xcubeForCut([100,extrusionWidth,partMountingThick]);
				}
			}
			// tube
			difference() {
				translate([0,-yshaft[radius],yshaftDistx+yshaft[radius]]) 
					rotate([0,90,0])
						xDiamantTube(yshaftHolderRadius,yshaftFrontMountDepth-yshaftDisty+2);
				translate([xd1,-50,-50])
					cube([100,100,50]);
			}
			// guide plate
			difference() {
				translate([0,yshaftDistz-partMountingThick,-extrusionWidth/3])
					cube([xd1,partMountingThick,extrusionWidth/3]);
				translate([(yshaftFrontMountDepth-yshaftDisty)/2-yshaftTubeScrew[nutHoleRadius],-0.1,-yshaftTubeScrew[nutHeight]*1.5])
					cube([yshaftTubeScrew[nutHoleRadius]*2,partMountingThick+0.2,yshaftTubeScrew[nutHeight]*1.5]);
			}
		}
		// shaft drill
		translate([-2*slack,-yshaft[radius],yshaftDistx+yshaft[radius]]) 
			rotate([0,90,0]) 
				cylinder(r=yshaft[radius]-slack/4,h=yshaftFrontMountDepth-yshaftMountDepthIn);
		for (p=frameFrontMounts) xscrewAllHole(p,frameScrew);
		for (p=yshaftFrontMounts) {
			xscrewAllHole(p,yshaftTubeScrew,depth=0);
			xNutHole(p,yshaftTubeScrew,z=0,twist=30);
		}
	}
}

module frontRightInnerShaftMount(color=undef,showScrews=false) {
	lg = xl(a="Y gantry",sa="Front right shaft mount");
	xxPartLog(lg,c="printed part",n="frontRightInnerShaftMount",t="PETG");
	color(color) {
		difference() {
			yshaftMount(color,showScrews,lg=lg);
			translate([-1,-50,yshaftDistx+yshaft[radius]]) cube([100,100,50]);	
		}
	}
	for (p=frameFrontMounts) xFrameScrew(p,frameScrew,showScrews=showScrews,lg=xxl(lg,d="frame mount"));
	for (p=yshaftFrontMounts) xNut(p,yshaftTubeScrew,showScrews=showScrews,twist=30,lg=xxl(lg,d="tube assembly"));
}

frontRightInnerShaftMount(showScrews=false);

/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/