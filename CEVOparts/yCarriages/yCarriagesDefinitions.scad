//*******************************************************************
// Definition of Y carriage sizings
//*******************************************************************

include <../util/standardDefinitions.scad>
include <../CEVOdefinitions.scad>
use <../xutil/xutil.scad>


/////////////////////////////////////////////////////////////////////
// main properties, these have sensible defaults but can be tweaked

ycScrew = m3;
ycMountScrew = partMountingScrew;

ycTubeRadius = yshaft[bushingRadius]+bushingWall;
ycXTubeRadius = xshaft[radius]+screwTapMinThick+ycMountScrew[holeRadius]*2+screwTapThick;
ycWidth = xminThick(ycScrew, xshaftDistance+2*ycXTubeRadius); //screwMinLength(ycScrew, xshaftDistance+2*ycXTubeRadius, depth = 1)[length]+ycScrew[headHeight];

yidler = defaultIdler;

ycXHolderLenght = yshaft[radius]*4.5;


/////////////////////////////////////////////////////////////////////
// minor properties, probably don't change

ycIdlerHolderTopThick = partMountingThick+1;
ycIdlerHolderBotThick = partMountingThick-1;


/////////////////////////////////////////////////////////////////////
// helpers, don't change

ycBushingTapWidth = max(bushingTap, ycScrew[headHeight], ycScrew[nutHeight]);
xshaftOffset = -ycTubeRadius-xshaft[radius]; // xshaft center offset from yshaft center

ycWidthHole = beltCarriageDistance+3*belt[thick]+2*yidler[flangeRadius]+2*yidler[radius];
ycBoxWidth = ycWidthHole+ycIdlerHolderBotThick*2;
ycBoxDepth = ycTubeRadius+yidler[radius]-beltBaseThick(belt);
ycBoxHoleHeight = 2*idlerHeight(yidler)+3*idlerSpacer;
ycBoxHeight = ycIdlerHolderBotThick+chamfer+ycBoxHoleHeight+ycIdlerHolderTopThick;
ycBoxEndOffset = yIdlerDist+yidler[radius]-beltBaseThick(belt); // end of box offset from yshaft center
ycBoxTopOffset = -xshaftOffset-idlerSpacer*1.5-idlerHeight(yidler)-ycIdlerHolderTopThick; // top of box offset from yshaft center
ycSideWidth = (ycWidth-ycWidthHole)/2;
ycXHolderWidth = ycSideWidth-ycWidth/2+xshaftDistance/2;
ycXHolderOffset = beltStepperMotor[width]/2-yIdlerDist-yidler[radius]-beltBaseThick(belt)-beltStepperPulley[radius]+1.5; // end of holder offset from yshaft center

ycIdlerP = let (
					l = xminThick(ycMountScrew,ycBoxHeight-chamfer-1,nutdepth=0,depth=0),
					x = beltCarriageDistance/2+belt[thick]/2+yidler[radius],
					y = yidler[radius]-beltBaseThick(belt),
					z = ycBoxHeight-l
				) xp([x, y, z],[180, 0, 0],thick=l,depth=0,nutdepth=0,screw=yidler[forScrew]);
ycIdlerLowerZ = 0; //

ycBoxPos = [ycBoxEndOffset,-ycBoxHeight-ycBoxTopOffset,ycWidthHole/2+ycSideWidth,-90,90,0];

ycXHolderPos = [-ycXHolderOffset-ycXHolderLenght,xshaftOffset,ycSideWidth-ycXHolderWidth,180,-90,0];

ycScrewPs = let (
					x1 = yIdlerDist-yidler[holeRadius]-ycScrew[radius]-0.5,
					y1 = xshaftOffset+idlerSpacer*1.5+idlerHeight(yidler)+ycScrew[radius]+0.5,
					x2 = -ycXHolderOffset-ycXHolderLenght/2-2.5,
					y2 = y1-idlerSpacer-yidler[flangeTopHeight]+0.7,
					x3 = x2,
					y3 = xshaftOffset-(-xshaftOffset+y2)
				) [ for(xy = [[x1,y1],[x2,y2],[x3,y3]]) xp([xy.x,xy.y,ycWidth],depth=1,nutdepth=1,screw=ycScrew,thick=ycWidth) ];
ycScrewTubeRadius = ycScrew[headRadius]+screwTapMinThick;

ycIdlerOuterEdge = yIdlerDist+yidler[radius]; // relative to yshaft center
ycLowerIdlerBot = xshaftOffset-idlerSpacer/2-idlerHeight(yidler)+yidler[flangeBotHeight]; // relative to yshaft center, bottom of tooths
ycUpperIdlerBot = ycLowerIdlerBot+idlerSpacer+idlerHeight(yidler); // relative to yshaft center, bottom of tooths
echo("**",xshaftOffset=xshaftOffset,ycUpperIdlerBot=ycUpperIdlerBot);

ycUpperIdlerTop = xshaftOffset-idlerSpacer/2-idlerHeight(yidler)+yidler[flangeBotHeight]; // TODO remove
/*
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
*/

/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/