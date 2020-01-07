
//*******************************************************************
// Stepper motor
//*******************************************************************

include <../util/standardDefinitions.scad>
use <../util/util.scad>


length=1; width=2; champfer=3; screwType=4; screwHoleDist=5; shaftRadius=6; shaftLength=7; pilotRadius=8; pilotDepth=9; topThick=10; botThick=11; motorName=12;
nema14 = [0,40,35.56,3.50,m4,26.00,2.50,24.00,11.00,2.00,7.50,9.50,"Nema14"];
nema17 = [0,40,43.18,4.00,m3,31.00,2.50,24.00,11.00,2.00,6.50,8.50,"Nema17"];

function stepperMotor(std,length,shaftLength) = [std[0],length,std[2],std[3],std[4],std[5],std[6],nnv(shaftLength,std[7]),std[8],std[9],std[10],std[11],std[12]];
function stepperHoleFromEdge(stepperMotor) = (stepperMotor[width]-stepperMotor[screwHoleDist])/2;


module theStepperMotor(stepperMotor,pulley=Gt2Timing20,pulleyH,color,aluColor) {
	translate([-stepperMotor[width]/2,-stepperMotor[width]/2,-stepperMotor[length]]) {
		color(aluColor)
			ccube(stepperMotor[width],stepperMotor[width],stepperMotor[botThick],stepperMotor[champfer],[0,0,0,0],[0,0,0,0],[1,1,1,1]);
		color(color)
			translate([0,0,stepperMotor[botThick]])
				ccube(stepperMotor[width],stepperMotor[width],stepperMotor[length]-stepperMotor[topThick]-stepperMotor[botThick],stepperMotor[champfer]*1.4,[0,0,0,0],[0,0,0,0],[1,1,1,1]);
		color(aluColor)
			translate([0,0,stepperMotor[length]-stepperMotor[topThick]])
				ccube(stepperMotor[width],stepperMotor[width],stepperMotor[topThick],stepperMotor[champfer],[0,0,0,0],[0,0,0,0],[1,1,1,1]);
	}
	color(aluColor) {
		cylinder(r=stepperMotor[pilotRadius],h=stepperMotor[pilotDepth]);
		cylinder(r=stepperMotor[shaftRadius],h=stepperMotor[shaftLength]);
		if (pulley != undef) translate([0,0,nnv(pulleyH,stepperMotor[shaftLength]-idlerHeight(pulley))]) thePulley(pulley);
	}
}

//theStepperMotor(stepperMotor(nema17,40),color=otherPartColor,aluColor=aluColor);


/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/