
//*******************************************************************
// Definition of carriage sizings
//*******************************************************************

include <../CEVOdefinitions.scad>


/////////////////////////////////////////////////////////////////////
// main properties, these have sensible defaults but can be tweaked

carriageScrew 		= screw(partMountingScrew,60); 		// screw length defines width of carriage
carriageMountScrew 	= screw(partMountingScrew,-9); 		// screw length not used, this size is used for all mounting on carriage
carriageWidthHole 	= 32;								// a e3d fan is 30, make room for it
carriageThick		= 6;


/////////////////////////////////////////////////////////////////////
// minor properties, probably don't change

carriagePlateNudge 	= xshaft[radius] > 4 ? 1 : 0;

/////////////////////////////////////////////////////////////////////
// helpers, don't change

xTubeRadius 		= xshaft[bushingRadius] + bushingWall;
carriageWidth 		= carriageScrew[length] + carriageScrew[headHeight];
carriagePlateDepth 	= xshaftDistance - (xTubeRadius-carriagePlateNudge)*2;
carriageTubeRadius 	= (xshaftDistance-carriagePlateDepth)/2;

carriageScrewX		= carriageTubeRadius-carriageScrew[nutHoleWidth]-0.2;
carriageScrewY		= carriageScrew[nutHoleRadius]+0.2;
carriagePlateScrewX	= carriageMountScrew[nutHoleRadius]+carriagePlateNudge;
carriagePlateScrewY	= carriageMountScrew[nutHoleRadius];

carriageFrontScale = 0.7;
carriageFrontRadius = xshaft[bushingRadius]*carriageFrontScale;



/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/