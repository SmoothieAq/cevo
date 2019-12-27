
//*******************************************************************
// Definition of Y carriage sizings
//*******************************************************************

include <../util/standardDefinitions.scad>
include <../CEVOdefinitions.scad>
use <../xutil.scad>


/////////////////////////////////////////////////////////////////////
// main properties, these have sensible defaults but can be tweaked

carriageScrew 		= m3;
carriageMountScrew 	= partMountingScrew;

yTubeRadius 		= yshaft[bushingRadius] + bushingWall;
xTubeRadius 		= xshaft[radius] + screwTapMinThick+carriageMountScrew[holeRadius]*2+screwTapThick;
carriageWidth 		= screwMinLength(carriageScrew,xshaftDistance+2*xTubeRadius,depth=1)[length]+carriageScrew[headHeight];

yidler				= defaultIdler;

xHolderLenght		= yshaft[radius]*5;


/////////////////////////////////////////////////////////////////////
// minor properties, probably don't change

idlerHolderTopThick	= 6;
idlerHolderBotThick	= 4;


/////////////////////////////////////////////////////////////////////
// helpers, don't change

bushingTapWidth = max(bushingTap,carriageScrew[headHeight],carriageScrew[nutHeight]);
xshaftZ				= -yTubeRadius-xshaft[radius];

carriageWidthHole	= 4*yidler[radius]+2*yidler[flangeRadius]+4*beltBaseThick(belt);
carriageWidthBox	= carriageWidthHole+idlerHolderBotThick*2;
carriageSideWidth	= (carriageWidth-carriageWidthHole)/2;

pulleyOuterEdgeX	= yIdlerDist+yidler[radius]+beltBaseThick(belt); // relative to yshaft center
pulleyTopOuterEdgeZ	= xshaftZ+idlerSpacer/2+idlerHeight(yidler)-yidler[flangeTopHeight]; // relative to yshaft center, top of tooths

motorClearance = 16;
idlerX = yTubeRadius;
idlerTopY = xshaftZ+yTubeRadius+idlerSpacer/2;
idlerBotY = xshaftZ+yTubeRadius-idlerHeight(yidler)-idlerSpacer/2;
idlerBackZ = carriageWidth/2-2*yidler[radius]-idlerSpacer/2;
idlerFrontZ = carriageWidth/2+2*yidler[radius]+idlerSpacer/2;
idlerBoxX = -yshaft[radius];
idlerSpaceThick = 2*idlerHeight(yidler)+3*idlerSpacer;
idlerSpaceWidth = carriageWidthHole;
idlerSpaceDepth = idlerX+yidler[radius]-beltBaseThick(belt)-idlerBoxX;

yCarriageScrewP1x   = yIdlerDist-yidler[holeRadius]-carriageScrew[radius]-0.5;
yCarriageScrewP1y   = xshaftZ+yTubeRadius+idlerSpacer/2+idlerHeight(yidler)+idlerSpacer+carriageScrew[radius]+0.5;
yCarriageScrewP2y   = xshaftZ+yTubeRadius+xTubeRadius+carriageScrew[radius]+screwTapMinThick;
yCarriageScrewP2x   = sqrt(pow(yTubeRadius,2)-pow(yTubeRadius-yCarriageScrewP2y,2));
yCarriageScrewPs    = [ for(xy = [[yCarriageScrewP1x,yCarriageScrewP1y],[-yCarriageScrewP2x,yCarriageScrewP2y]]) xp([xy.x,xy.y,carriageWidth],[0,0,0],depth=1,nutdepth=1,screw=carriageScrew,thick=carriageWidth) ];
yCarriageScrewPtr   = carriageScrew[headRadius]+1;

yCarriageXScrewLen  = screwMaxLength(carriageMountScrew,carriageSideWidth,1,1)[length];
yCarriageXScrewThick= yCarriageXScrewLen+carriageMountScrew[headHeight];
yCarriageXScrewPs   = let (d = -xshaft[radius], s = xshaft[radius]+screwTapMinThick+carriageMountScrew[holeRadius])
                        [ for (y=[d+s,d-s]) xp([-xHolderLenght/2+idlerBoxX+idlerSpaceDepth-motorClearance,y,carriageSideWidth-yCarriageXScrewThick],[180,0,0],depth=1,nutdepth=1,screw=carriageMountScrew,thick=yCarriageXScrewThick) ];

boxThick            = 2*idlerHeight(yidler)+3*idlerSpacer+idlerHolderTopThick+idlerHolderBotThick;
idlerP              = xp([idlerX, -xshaft[radius]+idlerHeight(yidler)+idlerSpacer/2+idlerHolderTopThick+idlerHolderBotThick, idlerBackZ],[-90, 0, 0],thick=boxThick+idlerHolderBotThick,depth=0,screw=yidler[forScrew]);

/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/