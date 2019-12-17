
//*******************************************************************
// standard constant elements and some utillity functions and modules
//*******************************************************************

use <util.scad>;


// shafts: 
radius=0; length=1; bushingRadius=2; bushingStdLength=3;
shaft8  = [4,-99, 8.0,25];
shaft10 = [5,-99, 9.5,29];
shaft12 = [6,-99,11.0,32];

function shaft(std,shaftLength) = [std[0],shaftLength,std[2],std[3]];
module theShaft(shaft,leng) { len = leng > 0 ? leng : shaft[length]; translate([-len/2,0,0]) rotate([0,90,0]) cylinder(r=shaft[radius],h=len); }


// screws:
radius=0; length=1; holeRadius=2; headRadius=3; headHoleRadius=4; headHeight=5; 
nutWidth=6; nutHoleWidth=7; nutHoleRadius=8;  nutHeight=9; nutHoleHeight=10;
m2 = [1.00,-99,1.05,1.50,1.60,2.00,2.00,2.05,2.21,1.60,1.80];
m3 = [1.50,-99,1.55,2.50,2.60,3.00,2.75,2.80,3.10,2.40,2.60];
m4 = [2.00,-99,2.05,3.00,3.10,4.00,3.50,3.55,3.89,3.20,3.40];
m5 = [2.50,-99,2.55,4.00,4.10,5.00,4.00,4.05,4.49,4.70,4.90];

function screw(std,screwLength) = [std[0],screwLength,std[2],std[3],std[4],std[5],std[6],std[7],std[8],std[9],std[10]];
module hexaprism(r,h) { rotate([0,0,30]) cylinder(r=r*2/sqrt(3),h=h,$fn=6); }
module nut(screw,depth=0) { 
	translate([0,0,-depth*screw[nutHoleHeight]]) {
		difference() {
			hexaprism(screw[nutWidth],screw[nutHeight]); 
			translate([0,0,screw[nutHeight]/2+0.1]) cylinder(r=screw[holeRadius],h=screw[nutHeight]/2);
		}
		cylinder(r=screw[radius],screw[nutHeight]); 
	}
}
module nutHole(screw,depth=1) { translate([0,0,-depth*screw[nutHoleHeight]+0.1]) hexaprism(screw[nutHoleWidth],screw[nutHoleHeight]+0.1); }
module screwHole(screw,leng=0) { len = leng > 0 ? leng : screw[length]; translate([0,0,-len-0.1]) cylinder(r=screw[holeRadius],h=len+0.2); }
module screwHead(screw,depth=0) { 
	translate([0,0,-depth*screw[headHeight]]) 
		difference() {
			ccylinder(r=screw[headRadius],h=screw[headHeight],c1h=screw[headRadius]/8,c2h=screw[headRadius]/8); 
			translate([0,0,screw[headHeight]/2+0.1]) hexaprism(r=screw[headRadius]/3,h=screw[headHeight]/2);
		}
}
module screwHeadHole(screw,depth=1) { translate([0,0,-depth*screw[headHeight]+0.2]) cylinder(r=screw[headHoleRadius],h=screw[headHeight]+0.2); }


// timing belt
width=2; thick=3; toothHeight=4; toothSpacing=5;
gt2 = [0,0,6,1.38,0.75,2];

function beltBaseThick(belt) = belt[thick]-belt[toothHeight];


// belt idler/timing pullys:
radius=0; forBelt=1; holeRadius=2; toothed=3; baseRadius=4; flangeTopHeight=5; flangeBotHeight=6; flangeRadius=7; 
F623x2 		= [5.00,gt2,1.5,false,5.00,1.0,1.0,6.0]; // two F633 against each other, use f633zz
Gt2Timing20 = [5.95,gt2,2.5,true, 5.00,1.1,7.5,8.0]; 
Gt2Idler20 	= [5.95,gt2,2.5,true, 5.00,1.1,1.1,8.0]; 
Gt2Idler20nt= [6.00,gt2,2.5,false,6.00,1.1,1.1,8.0]; 

function idlerWidth(pulley) = pulley[forBelt][width];
function idlerHeight(pulley) = idlerWidth(pulley)+pulley[flangeBotHeight]+pulley[flangeTopHeight];
module thePulley(pulley) {
	difference() {
		union() {
			cylinder(r=pulley[radius],h=idlerWidth(pulley)+pulley[flangeBotHeight]);
			cylinder(r=pulley[flangeRadius],h=pulley[flangeBotHeight]);
			translate([0,0,idlerWidth(pulley)+pulley[flangeBotHeight]]) cylinder(r=pulley[flangeRadius],h=pulley[flangeTopHeight]);
		}
		translate([0,0,-0.1]) cylinder(r=pulley[holeRadius],h=idlerHeight(pulley)+0.2);
	}
			
}

/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/