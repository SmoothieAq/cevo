
//*******************************************************************
// Definition of basic sizings of the CEVO
//*******************************************************************

include <util/standardDefinitions.scad>
include <otherParts/stepperMotor.scad>
 

/////////////////////////////////////////////////////////////////////
// overall size and properties, review and override as you see fit

frameHeight				= 600;
frameWidth				= 480; // including 2 x extrusion with
frameDepth				= 470; // including 2 x extrusion with

plateThick				= 12;

hotbedWidth 			= 300;
hotbedDepth 			= 300;
printingHeight 			= 300;

carbonXshaft = true;
carbonYshaft = true;


/////////////////////////////////////////////////////////////////////
// additional properties, these have sensible defaults but can be overridden

allExtrusion			= extrusion3030;

xshaftLength			= frameWidth-2*allExtrusion[exmainsq]-10;
xshaft 					= shaft(hotbedWidth > 300 || carbonXshaft ? shaft10 : shaft8,xshaftLength);
xshaftDistance 			= 60;

yshaftLength			= frameDepth-40;
hotendOffset 			= [0,-6,0]; 		// carefull, should go with the carriage dimentions and your hotend mount

yshaft 					= shaft(hotbedDepth > 300 || carbonYshaft ? shaft12 : shaft10,yshaftLength);

belt 					= gt2;
defaultIdler			= F623x2;

beltStepperMotor		= stepperMotor(nema17,40);
beltStepperPulley		= Gt2Timing20;


/////////////////////////////////////////////////////////////////////
// smaller generic elements, most can be tweaked a bit, but be aware they influence most parts

idlerSpacer = 0.8;
printIdlerSpacer = false;

partMountingThick = 5;
partMountingExWidth = allExtrusion[exmainsq]/5*4.2;
partMountingExExWidth = allExtrusion[exmainsq]/5*3.4;
screwDepth = 0.2; // fraction of headHeight
partMountingScrew = m3;
frameMountingScrew = m4;

bushingWall = 3;
bushingTap = 1.5;
screwTapMinThick = 1.4;
screwTapThick = 2.0;
screwTapSolidThick = 4;

bevelHeight = 0.6;
bevelWidth = 2.0;
diamantLength = 5;
diamantWidth = 2.5;
diamantSpacing = 0.2;
chamfer = 1.5;

slack = 0.2;


/////////////////////////////////////////////////////////////////////
// calculated helpers, don't change

extrusionWidth 	= allExtrusion[exmainsq];

yIdlerDist		= yshaft[bushingRadius] + bushingWall; // X-dist relative to yshaft center


/////////////////////////////////////////////////////////////////////
// colors, only used to render nice looking visuals of the parts and assemblies

mainColor 		= [66/256,78/256,78/256,1]; // dark greyish
accentColor 	= [200/256,1/256,1/256,1]; // Red
screwColor 		= [80/256,80/256,80/256,1]; // little less dark grey
frameColor 		= [75/256,78/256,78/256,1]; // less dark greyish
aluColor 		= [220/256,220/256,220/256,1]; // light grey
carbonColor		= [55/256,55/256,55/256,1]; // dark grey
otherPartColor	= [50/256,50/256,50/256,1]; // more dark greyish


/////////////////////////////////////////////////////////////////////
// rendering diamants are real slow, override these when testing

doDiamants 			= true;
doRealDiamants 		= false;


/////////////////////////////////////////////////////////////////////
// probably don't change these

$fs=0.2;
$fa=2;
$fn=undef;


/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/