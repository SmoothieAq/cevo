
//*******************************************************************
// Definition of belt mount dimensions
//*******************************************************************

include <../CEVOdefinitions.scad>
include <../yCarriages/yCarriagesDefinitions.scad>
use <../xutil/xutil.scad>


/////////////////////////////////////////////////////////////////////
// main properties, these have sensible defaults but can be tweaked


/////////////////////////////////////////////////////////////////////
// minor properties, probably don't change

yshaftDistx		= partMountingThick;
yshaftDistz		= sqrt(pow(ycTubeRadius+2,2)-pow(yshaftDistx+yshaft[radius],2))-yshaft[radius];

yshaftHolderRadius	= yshaft[radius]+screwTapMinThick+partMountingScrew[holeRadius]*2+screwTapThick;


/////////////////////////////////////////////////////////////////////
// helpers, don't change

yshaftDisty		= (frameDepth-yshaftLength)/2;

yshaftFrontMountDepth = extrusionWidth+max(15,beltStepperMotor[width]-(carriageWidth-carriageWidthBox)/2+1,25-extrusionWidth+yshaftDisty); // from edge of extrusion
yshaftMountBaseHeight= extrusionWidth+yshaftDistz; // from edge of extrusion
yshaftMountHeight	= yshaftMountBaseHeight+yshaft[radius]+yshaftHolderRadius+frameMountingScrew[holeRadius]+screwTapThick; // from edge of extrusion

yshaftMountDepthIn	= extrusionWidth-partMountingExWidth;
yshaftMountHeightIn	= min(extrusionWidth-partMountingExWidth,yshaftDisty-screwTapThick);

frameScrew 			= xxaFrameScrew();
frameFrontMounts 	= setzs(
						[[(yshaftFrontMountDepth-extrusionWidth)/2,yshaftMountBaseHeight-extrusionWidth/2],
						 [yshaftFrontMountDepth-extrusionWidth/2,-yshaft[radius]+yshaftHolderRadius],
						 [yshaftFrontMountDepth-extrusionWidth/2,-yshaft[radius]-yshaftHolderRadius]],
						partMountingThick);

yshaftTubeScrew		= xaPartScrew(leng=yshaftDistx+yshaft[radius]+screwTapSolidThick);
yshaftFrontMounts	= let (xd = (yshaftFrontMountDepth-yshaftDisty)/2, yd = screwTapMinThick+yshaftTubeScrew[radius]/*(yshaftHolderRadius-yshaft[radius])/2*/ ) 
						[ for (xy=[[xd,yd],[xd,-yshaft[radius]*2-yd]]) xp([xy.x,xy.y,yshaftTubeScrew[length]],nutdepth=1) ]; //echo(want=yshaftDistx+yshaft[radius]+screwTapSolidThick,act=yshaftTubeScrew[length]);

stepperOuterEdgeX	= extrusionWidth+yshaftDistx+yshaft[radius]-ycIdlerOuterEdge-beltStepperPulley[baseRadius]-beltStepperMotor[width]/2; // ralative to edge of frame
stepperTopOuterEdgeZ= extrusionWidth+yshaftDistz+yshaft[radius]-ycUpperIdlerTop+beltStepperMotor[shaftLength]-beltStepperPulley[flangeTopHeight]; // relative to top of frame
*echo(stepperOuterEdgeX=stepperOuterEdgeX,stepperTopOuterEdgeZ=stepperTopOuterEdgeZ);


/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/