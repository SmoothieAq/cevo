
//*******************************************************************
// Definition of Y carriage sizings
//*******************************************************************

include <../util/standardDefinitions.scad>
include <../CEVOdefinitions.scad>
use <../xutil/xutil.scad>


/////////////////////////////////////////////////////////////////////
// main properties, these have sensible defaults but can be tweaked

ycScrew 		= m3;
ycMountScrew 	= partMountingScrew;

ycTubeRadius 		= yshaft[bushingRadius] + bushingWall;
ycXTubeRadius 		= xshaft[radius] + screwTapMinThick+ycMountScrew[holeRadius]*2+screwTapThick;
carriageWidth 		= screwMinLength(ycScrew,xshaftDistance+2*ycXTubeRadius,depth=1)[length]+ycScrew[headHeight];

yidler				= defaultIdler;

ycXHolderLenght		= yshaft[radius]*5;


/////////////////////////////////////////////////////////////////////
// minor properties, probably don't change

ycIdlerHolderTopThick	= 6;
ycIdlerHolderBotThick	= 4;


/////////////////////////////////////////////////////////////////////
// helpers, don't change

ycBushingTapWidth = max(bushingTap,ycScrew[headHeight],ycScrew[nutHeight]);
xshaftOffset				= -ycTubeRadius-xshaft[radius];

carriageWidthHole	= 4*yidler[radius]+2*yidler[flangeRadius]+4*beltBaseThick(belt);
carriageWidthBox	= carriageWidthHole+ycIdlerHolderBotThick*2;
carriageSideWidth	= (carriageWidth-carriageWidthHole)/2;

pulleyOuterEdgeX	= yIdlerDist+yidler[radius]+beltBaseThick(belt); // relative to yshaft center
pulleyTopOuterEdgeZ	= xshaftOffset+idlerSpacer/2+idlerHeight(yidler)-yidler[flangeTopHeight]; // relative to yshaft center, top of tooths

motorClearance = 16;
idlerX = ycTubeRadius;
idlerTopY = xshaftOffset+ycTubeRadius+idlerSpacer/2;
idlerBotY = xshaftOffset+ycTubeRadius-idlerHeight(yidler)-idlerSpacer/2;
idlerBackZ = carriageWidth/2-2*yidler[radius]-idlerSpacer/2;
idlerFrontZ = carriageWidth/2+2*yidler[radius]+idlerSpacer/2;
idlerBoxX = -yshaft[radius];
idlerSpaceThick = 2*idlerHeight(yidler)+3*idlerSpacer;
idlerSpaceWidth = carriageWidthHole;
idlerSpaceDepth = idlerX+yidler[radius]-beltBaseThick(belt)-idlerBoxX;

yCarriageScrewP1x   = yIdlerDist-yidler[holeRadius]-ycScrew[radius]-0.5;
yCarriageScrewP1y   = xshaftOffset+ycTubeRadius+idlerSpacer/2+idlerHeight(yidler)+idlerSpacer+ycScrew[radius]+0.5;
yCarriageScrewP2y   = xshaftOffset+ycTubeRadius+ycXTubeRadius+ycScrew[radius]+screwTapMinThick;
yCarriageScrewP2x   = sqrt(pow(ycTubeRadius,2)-pow(ycTubeRadius-yCarriageScrewP2y,2));
yCarriageScrewPs    = [ for(xy = [[yCarriageScrewP1x,yCarriageScrewP1y],[-yCarriageScrewP2x,yCarriageScrewP2y]]) xp([xy.x,xy.y,carriageWidth],[0,0,0],depth=1,nutdepth=1,screw=ycScrew,thick=carriageWidth) ];
yCarriageScrewPtr   = ycScrew[headRadius]+1;

yCarriageXScrewLen  = screwMaxLength(ycMountScrew,carriageSideWidth,1,1)[length];
yCarriageXScrewThick= yCarriageXScrewLen+ycMountScrew[headHeight];
yCarriageXScrewPs   = let (d = -xshaft[radius], s = xshaft[radius]+screwTapMinThick+ycMountScrew[holeRadius])
                        [ for (y=[d+s,d-s]) xp([-ycXHolderLenght/2+idlerBoxX+idlerSpaceDepth-motorClearance,y,carriageSideWidth-yCarriageXScrewThick],[180,0,0],depth=1,nutdepth=1,screw=ycMountScrew,thick=yCarriageXScrewThick) ];

boxThick            = 2*idlerHeight(yidler)+3*idlerSpacer+ycIdlerHolderTopThick+ycIdlerHolderBotThick;
idlerP              = xp([idlerX, -xshaft[radius]+idlerHeight(yidler)+idlerSpacer/2+ycIdlerHolderTopThick+ycIdlerHolderBotThick, idlerBackZ],[-90, 0, 0],thick=boxThick+ycIdlerHolderBotThick,depth=0,screw=yidler[forScrew]);

/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/