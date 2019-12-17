
//*******************************************************************
// Definition of Y carriage sizings
//*******************************************************************

include <../CEVOdefinitions.scad>


/////////////////////////////////////////////////////////////////////
// main properties, these have sensible defaults but can be tweaked

carriageScrew 		= screw(m4,80); 					// screw length must be slightly less than carriageWidth
carriageMountScrew 	= screw(partMountingScrew,-9); 		// screw length not used, this size is used for all mounting on carriage

yidler				= defaultIdler;

xHolderLenght		= yshaft[radius]*5;


/////////////////////////////////////////////////////////////////////
// minor properties, probably don't change

idlerHolderTopThick	= 6;
idlerHolderBotThick	= 4;
//carriagePlateNudge 	= xshaft[radius] > 4 ? 1 : 0;


/////////////////////////////////////////////////////////////////////
// helpers, don't change

yTubeRadius 		= yshaft[bushingRadius] + bushingWall;
xTubeRadius 		= xshaft[radius] + carriageMountScrew[radius]+carriageMountScrew[nutHoleWidth]+4*slack;
carriageWidth 		= carriageScrew[length]+carriageScrew[headHeight];// xshaftDistance+2*xTubeRadius; 
xshaftZ				= -yTubeRadius-xshaft[radius];

carriageWidthHole	= 4*yidler[radius]+2*yidler[flangeRadius]+4*beltBaseThick(belt);
carriageSideWidth	= (carriageWidth-carriageWidthHole)/2;

echo(yTubeRadius=yTubeRadius,xTubeRadius=xTubeRadius,carriageWidth=carriageWidth,xshaftZ=xshaftZ,carriageWidthHole=carriageWidthHole,carriageSideWidth=carriageSideWidth);


/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/