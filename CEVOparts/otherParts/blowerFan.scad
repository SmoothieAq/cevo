
//*******************************************************************
// Blower fan
//*******************************************************************

include <../CEVOdefinitions.scad>;


module blowerFan(width,center,screwCenter,thickness,openeningWidth,color,showScrews,flip=true) {
	wallThickness = thickness/15; holeRadius = 2;
	
	module tab() {
		translate([screwCenter[0],screwCenter[1],0]) {
			color(color) difference() {
				tabr = holeRadius+wallThickness*2;
				union() {
					cylinder(r=tabr,h=thickness);
					rotate([0,0,45])
						translate([0,-tabr,0])
							cube([width/6,2*tabr,thickness]);
				}
				translate([0,0,-1])
					cylinder(r=holeRadius,h=thickness+2);
			}
			if (showScrews)
				color(screwColor) translate([0,0,thickness]) screwHead(m3,0.8);
		}
	}
	
	//translate([0,-width,0]) 
	color(color) difference() {
		union() {
			translate([center[0],center[1],0])
				cylinder(r=center[1],h=thickness);
			difference() {
				translate([width/2,width/2,0])
					cylinder(r=width/2,h=thickness);
				translate([0,0,-1]) 
					cube([width/2,width+1,thickness+2]);
			}
			translate([0,width-openeningWidth,0])
				cube([width/2,openeningWidth,thickness]);
		}
		translate([center[0],center[1],wallThickness])
			cylinder(r=width/10*3,h=thickness);
		translate([-1,width-openeningWidth+wallThickness,wallThickness])
			cube([width/2,openeningWidth-2*wallThickness,thickness-2*wallThickness]);
	}
	tab();
	translate([width,width,0]) 
		mirror([0,1,0]) mirror([1,0,0]) tab();
	color(color) {
		translate([center[0],center[1],0])
			cylinder(r=width/10*3,h=thickness-3*wallThickness);
		translate([center[0],center[1],0])
			cylinder(r=width/4,h=thickness-wallThickness);
	}
}

module blowerFan5015(color,showScrews,flip=true) {
	blowerFan(width=51,center=[24.5,24],screwCenter=[6.5,4],thickness=15,openeningWidth=20,color=color,showScrews=showScrews,flip=flip);
}

blowerFan5015(color=otherPartColor);



/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/