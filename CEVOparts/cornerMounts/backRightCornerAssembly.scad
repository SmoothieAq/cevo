
//*******************************************************************
// front right corner assembly
//*******************************************************************


include <../CEVOdefinitions.scad>
include <cornerMountsDefinitions.scad>
include <../util/helperEDIT.scad>
include <../frame/frameDefinitions.scad>
include <../otherParts/stepperMotor.scad>
use <backRightInnerShaftMount.scad>
use <backRightOuterShaftMount.scad>


module backRightCornerAssembly() {
	place = [[],
		[-extrusionWidth,-extrusionWidth,-exLength+extrusionWidth,0,0,0], 											// corner extrusion
		[0,-extrusionWidth,0,90,0,90], 													// top side extrusion
		[-extrusionWidth,0,extrusionWidth,-90,0,0], 													// top back extrusion
		[cmYDistx,-cmYDisty+yshaft[length]/2,-cmYDistz,0,0,90], 	// y shaft
		[0,0,0,0,0,0], 			// backRightInnerShaftMount
		[0,0,0,0,0,0], 			// backRightOuterShaftMount
		[-beltStepperMotor[width]+extrusionWidth-stepperOuterEdgeX,extrusionWidth,extrusionWidth-stepperTopOuterEdgeZ-0.03,0,0,0],
	[]];
	show(place) { 
		place(place,1,true,true) color(alpha(1,frameColor)) theExtrusion(extrusionH);
		place(place,2,true,true) color(alpha(2,frameColor)) theExtrusion(extrusionD);
		place(place,3,true,true) color(alpha(2,frameColor)) theExtrusion(extrusionW);
		place(place,4,true,true) color(alpha(4,carbonYshaft ? carbonColor : aluColor)) theShaft(yshaft);
		place(place,5) backRightInnerShaftMount(alpha(5,mainColor));
		place(place,6) backRightOuterShaftMount(alpha(6,mainColor));
		//place(place,7) rightMotorMount(alpha(7,mainColor));
	}
}

backRightCornerAssembly();


/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/