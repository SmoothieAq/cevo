
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

cmScrew 		= partMountingScrew;

cmYDistx		= partMountingThick+yshaft[radius]; // center from inner frame
cmYDistz		= sqrt(pow(ycTubeRadius+2,2)-pow(cmYDistx,2)); // center from inner frame

cmYHolderRadius = yshaft[radius]+screwTapMinThick+partMountingScrew[holeRadius]*2+screwTapThick;

//--
yshaftDistx		= partMountingThick; // from frame
yshaftDistz		= sqrt(pow(ycTubeRadius+2,2)-pow(yshaftDistx+yshaft[radius],2))-yshaft[radius]; // from frame

yshaftHolderRadius	= yshaft[radius]+screwTapMinThick+partMountingScrew[holeRadius]*2+screwTapThick;


/////////////////////////////////////////////////////////////////////
// helpers, don't change

cmYDisty		= extrusionWidth-(frameDepth-yshaftLength)/2; //  from inner frame

cmYHolderLenght	= max(15,beltStepperMotor[width]-(ycWidth-ycBoxWidth)/2+1,25-extrusionWidth+cmYDisty)+cmYDisty+2;
cmYHolderPos = [cmYDistx, cmYHolderLenght-cmYDisty, -cmYDistz, 0, 90, -90];

cmScrewPs = let (
		t = xminThick(cmScrew,yshaft[radius]*2+screwTapThick*3,nutdepth=1,depth=0),
		x = t,
		y = -cmYDisty+cmYHolderLenght/2,
		zd = yshaft[radius]+screwTapMinThick+cmScrew[radius],
		z1 = -cmYDistz+zd,
		z2 = -cmYDistz-zd
	) [ for(z = [z1,z2]) xp([x,y,z],[0,90,0],depth=0,nutdepth=1,screw=cmScrew,thick=t) ];

cmPlateCut = cmYHolderRadius+cmScrew[headRadius]*2+screwTapThick;

cmFrameScrewPs = let (
		y1 = (cmYHolderLenght-cmYDisty)/3*2,
		z1 = extrusionWidth/2,
		y2 = -extrusionWidth/2,
		z2 = -cmYDistz-cmYHolderRadius,
		y3 = y2,
		z3 = -cmYDistz+cmYHolderRadius
	) [ for(p = [[y1,z1],[y2,z2],[y3,z3]]) xp([partMountingThick,p[0],p[1]],[0,90,0],screw=frameMountingScrew,thick=partMountingThick) ];

cmUpperStepperTop = -ycUpperIdlerBot+beltStepperMotor[shaftLength]-belt[width]-beltStepperPulley[flangeTopHeight]; // relative to y shaft center
cmStepperCenter = -cmYDistx+ycIdlerOuterEdge+beltBaseThick(belt)+beltStepperPulley[baseRadius]; // relative to inner edge of extrusion
echo("***",cmYDistz=cmYDistz,cmUpperStepperTop=cmUpperStepperTop);

//--
yshaftDisty		= (frameDepth-yshaftLength)/2; // from frame

yshaftFrontMountDepth = extrusionWidth+max(15,beltStepperMotor[width]-(ycWidth-ycBoxWidth)/2+1,25-extrusionWidth+yshaftDisty); // from edge of extrusion
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