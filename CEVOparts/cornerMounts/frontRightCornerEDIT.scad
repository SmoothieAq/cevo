
//*******************************************************************
// front right corner assembly
//*******************************************************************


include <../CEVOdefinitions.scad>
include <cornerMountsDefinitions.scad>
include <../util/helperEDIT.scad>
include <../frame/frameDefinitions.scad>
include <../otherParts/stepperMotor.scad>
use <frontRightInnerShaftMount.scad>
use <frontRightOuterShaftMount.scad>
use <rightMotorMount.scad>


show 		= 0; 

onlyShow 	= false;
alpha		= 0.2;
showColor 	= undef;
showScrews 	= true;
showExtra	= true;
//showExtraExtra	= true;

module frontRightCornerAssembly() {
	place = [[],
		[0,0,-exLength+extrusionWidth,0,0,0], 											// corner extrusion
		[0,extrusionWidth,extrusionWidth,-90,0,0], 													// top extrusion
		[extrusionWidth-stepperOuterEdgeX-beltStepperMotor[width]/2,beltStepperMotor[width]/2+extrusionWidth+slack,extrusionWidth-stepperTopOuterEdgeZ,0,0,0],	// stepper
		[-yshaft[radius]-yshaftDistx,yshaft[length]/2+yshaftDisty,-yshaft[radius]-yshaftDistz,0,0,90], 	// y shaft 
		[0,yshaftFrontMountDepth,-yshaftMountBaseHeight+extrusionWidth,90,0,-90], 			// frontRightInnerShaftMount
		[0,yshaftMountDepthIn,-yshaftDistz,90,0,180], 			// frontRightOuterShaftMount
		[-beltStepperMotor[width]+extrusionWidth-stepperOuterEdgeX,extrusionWidth,extrusionWidth-stepperTopOuterEdgeZ-0.03,0,0,0],
	[]];
	show(place) { 
		place(place,1,true,true) color(alpha(1,frameColor)) theExtrusion(extrusionH);
		place(place,2,true,true) color(alpha(2,frameColor)) theExtrusion(extrusionW);
		place(place,3,true) theStepperMotor(beltStepperMotor,beltStepperPulley,color=alpha(3,otherPartColor),aluColor=alpha(3,aluColor));
		place(place,4,true) color(alpha(4,carbonYshaft ? carbonColor : aluColor)) theShaft(yshaft);
		place(place,5) frontRightInnerShaftMount(alpha(5,mainColor),showScrews=showScrews);
		place(place,6) frontRightOuterShaftMount(alpha(6,mainColor),showScrews=showScrews);
		place(place,7) rightMotorMount(alpha(7,mainColor),showScrews=showScrews);
	}
}

frontRightCornerAssembly();


/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/