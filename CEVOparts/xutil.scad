
//*******************************************************************
// Utility modules and functions dependent on CEVOdefinitions
//*******************************************************************

include <CEVOdefinitions.scad>
use <util/util.scad>
use <util/diamants.scad>
include <otherParts/stepperMotor.scad>

/////////////////////////////////////////////////////////////////////
// some helper modules

// area,subarea,category,name,type,size,count,description
function xl(a,sa,c,n,t,s,cn=1,d) = [a,sa,c,n,t,s,cn,d];
function xxl(lg,a,sa,c,n,t,s,cn=1,d) = 
	let (
		lg1 = nnv(lg,[]),
		lg2 = xl(a,sa,c,n,t,s,cn,d)
	) [ for (i=[0:1:7]) nnv(lg2[i],lg1[i]) ];

module xPartLog(lg) { xLog("+++",lg); }
module xxPartLog(lg,a,sa,c,n,t,s,cn=1,d) { xPartLog(xxl(lg,a,sa,c,n,t,s,cn,d)); }

module xWarningLog(lg) { xLog("???",lg); }
module xErrorLog(lg) { xLog("!!!",lg); }

module xLog(logtype,lg) { echo(logtype,nnv(lg[0],""),nnv(lg[1],""),nnv(lg[2],""),nnv(lg[3],""),nnv(lg[4],""),nnv(lg[5],""),nnv(lg[6],""),nnv(lg[7],"")); }


/////////////////////////////////////////////////////////////////////

function xaScrew(xyz,screw,depth=0.2,leng) = screw[length] > 0 ? screw : screwMinLength(screw,nnv(leng,xyz.z-0.2),depth);
function xaPartScrew(xyz,depth=0.2,leng) = screwMinLength(partMountingScrew,nnv(leng,xyz.z-0.2),depth);
function xaFrameScrew(xyz,depth=0.2,leng) = screwMinLength(frameMountingScrew,nnv(leng,xyz.z-0.2)+exMountScrewDepth(allExtrusion),depth);
function xxaFrameScrew(depth=0.2,thick=partMountingThick) = xaFrameScrew(depth=depth,leng=thick);

module xscrewAllHole(xyz,screw,leng,depth=0.2,spacing=20) { 
	thisScrew = xaScrew(xyz,screw,depth,leng);
	r = len(xyz) > 3 ? [xyz[3],xyz[4],xyz[5]] : [0,0,0];
	translate([xyz.x,xyz.y,xyz.z]) rotate(r) screwAllHole(thisScrew,depth=depth,spacing=spacing); 
}

module xscrew(xyz,screw,showScrews=true,depth=0.2,plate=3,plateColor=mainColor,lg,leng) {
	thisScrew = xaScrew(xyz,screw,depth,leng);
	r = len(xyz) > 3 ? [xyz[3],xyz[4],xyz[5]] : [0,0,0];
	xxPartLog(lg,c="screw",t=thisScrew[screwName],s=thisScrew[length]);
	translate([xyz.x,xyz.y,xyz.z]) rotate(r) {
		if (plate > 0)
			color(plateColor) difference() {
				translate([0,0,-plate-depth*thisScrew[headHeight]]) cylinder(r=thisScrew[headRadius],h=plate);
				translate([0,0,-plate-0.01-depth*thisScrew[headHeight]]) cylinder(r=thisScrew[holeRadius],h=plate+0.02);
			}
		if (showScrews) 
			color(screwColor) theScrew(thisScrew,depth); 
	}
}

module xFrameScrew(xyz,screw,showScrews=true,depth=0.2,plate=3,plateColor=mainColor,lg,leng) {
	xscrew(xyz,screw,showScrews=showScrews,depth=depth,plate=plate,plateColor=plateColor,lg=lg,leng=leng);
	xxPartLog(lg,c="T-mount",t=str(allExtrusion[exname]," ",screw[screwName]));
}
module xNutHole(xyz,screw,showScrews=true,depth=0,z=undef,twist=0,spacing) { 
	r = len(xyz) > 3 ? [xyz[3],xyz[4],xyz[5]] : [0,0,0];
	translate([xyz.x,xyz.y,z != undef ? z : 0]) rotate(r) rotate([180,0,0]) nutHole(screw,1-depth,twist=twist,spacing=spacing); 
}

module xNut(xyz,screw,showScrews=true,depth=0,z=undef,twist=0,plate=3,plateColor=mainColor,lg) { 
	xxPartLog(lg,c="nut",t=screw[screwName]);
	r = len(xyz) > 3 ? [xyz[3],xyz[4],xyz[5]] : [0,0,0];
	translate([xyz.x,xyz.y,z != undef ? z : 0])  {
		if (plate > 0)
			color(plateColor) difference() {
				translate([0,0,(1-depth)*screw[nutHoleHeight]]) rotate([0,0,twist]) {
					difference() {
						hexaprism(screw[nutHoleWidth],plate); 
						translate([0,0,-0.1]) cylinder(r=screw[holeRadius],h=plate+0.2);
					}
				}
			}
		if (showScrews)
			color(screwColor) rotate(r) rotate([180,0,0]) nut(screw,1-depth,twist=twist); 
	}
}


/////////////////////////////////////////////////////////////////////


module xcube(xyz,sides=[1,0,0,0],ch=chamfer) {
	ccube(xyz.x,xyz.y,xyz.z,ch,[0,0,sides[0],sides[2]],[0,sides[3],sides[1],0],[0,0,0,0]);
}
//xcube([30,50,5],[1,1,1,1]);

module xcubeForCut(xyz,ch=chamfer) {
	ccubeForCut(xyz.x,xyz.y,xyz.z,ch);
}

module xcubex(xyyz,sides=[1,0,0,0],ch=chamfer) {
	xDiamantCubex(xyyz,sides,ch,diamants=false);
}

/////////////////////////////////////////////////////////////////////

module xDiamantCubex(xyyz,sides=[1,0,0,0],ch=chamfer,bevel=[0,0,0,0],bevelHeight=bevelHeight,bevelWidth=bevelWidth,diamants=true,diamantHoriz=false,xoffset=0,yoffset=0) {
	x = xyyz[0]; y1 = xyyz[1]; y2 = xyyz[2]; z = xyyz[3];
	mirror = y1 > y2 ? [1,0,0] : [0,0,0];
	translate = y1 > y2 ? [x,0,0] : [0,0,0]; 
	ymin = min(y1,y2); ymax = max(y1,y2);
	
	cv = [ for (i=[0:1:3]) sides[i]==1 ? ch : sides[i]==2 ? bevelHeight : 0 ];
	bv = [ for (i=[0:1:3]) bevel[i]*bevelWidth+cv[i] ];
	bvx = [ for (i=[0:1:3]) bv[i]-bevel[i]*bevelHeight ];
	anyb = [ for (b=bevel) if (b>0) b ];
	cutz = z+(len(anyb) > 0 ? bevelHeight : 0);
	
	translate(translate) mirror(mirror) difference() {
		union() {
			cube([x,ymax,z]);
			if (bevel[0]>0) translate([0,ymin,z]) rotate([0,0,atan((ymax-ymin)/x)]) translate([0,-bv[0],0]) xcube([x*1.5,bv[0],bevelHeight],[0,0,1,],bevelHeight);
			if (bevel[1]>0) translate([x-bv[1],0,z]) xcube([bv[1],ymax,bevelHeight],[0,0,0,1],bevelHeight);
			if (bevel[2]>0) translate([0,0,z]) xcube([x,bv[2],bevelHeight],[1,0,0,0],bevelHeight);
			if (bevel[3]>0) translate([0,0,z]) xcube([bv[3],ymin+bevelWidth,bevelHeight],[0,1,0,0],bevelHeight);
			if (diamants && !diamantHoriz) translate([bvx[3],bvx[2],z]) diamantPlate(x-bvx[1]-bvx[3],ymax,xoffset=xoffset,yoffset=yoffset);
			if (diamants && diamantHoriz) translate([x-bvx[1],bvx[2],z]) rotate([0,0,90]) diamantPlate(ymax,x-bvx[1]-bvx[3],xoffset=xoffset,yoffset=yoffset);
		}
		translate([-0.001,ymin,0]) rotate([0,0,atan((ymax-ymin)/x)]) translate([-bevelWidth,0,0]) xcubeForCut([x*2,ymax,cutz],cv[0]);
		translate([x,ymax*2-1,0]) rotate([0,0,-90]) xcubeForCut([ymax*2,x,cutz],cv[1]);
		translate([x+1,0,0]) rotate([0,0,180]) xcubeForCut([x+2,ymax,cutz],cv[2]);
		translate([0,-1,0]) rotate([0,0,90]) xcubeForCut([ymax+2,x,cutz],cv[3]);
	}
}
//xDiamantCubex([30,10,20,5],sides=[1,2,2,1],bevel=[1,1,1,1],diamantHoriz=true);

module xDiamantCube(xyz,sides=[1,0,0,0],ch=chamfer,bevel=[0,0,0,0],bevelHeight=bevelHeight,bevelWidth=bevelWidth,diamants=true,diamantHoriz=false,xoffset=0,yoffset=0) {
	xDiamantCubex([xyz.x,xyz.y,xyz.y,xyz.z],sides=sides,ch=ch,bevel=bevel,bevelHeight=bevelHeight,bevelWidth=bevelWidth,diamants=diamants,diamantHoriz=diamantHoriz,xoffset=xoffset,yoffset=yoffset);
}

module xHalfDiamantTube(r,h,deg=360) {
	ccylinder(bevelWidth+chamfer,r+bevelHeight,chamfer,bevelHeight); 
	translate([0,0,bevelWidth+chamfer]) cylinder(h=h-bevelWidth-chamfer,r=r); 
	translate([0,0,h]) rotate([180,0,-180])
		diamantTube(r,deg,h-bevelWidth-chamfer,zoffset=-diamantLength/2-diamantSpacing);
}

module xDiamantTube(r,h,deg=360) {
	xHalfDiamantTube(r,h/2,deg);
	translate([0,0,h]) mirror([0,0,1]) xHalfDiamantTube(r,h/2,deg); 
}


/////////////////////////////////////////////////////////////////////

module xMotorMount(stepperMotor,thick=partMountingThick,slack=slack,color=undef,screwDepth=0.2,screwHoles=false,showAllScrews=false,allChamfer=false,lg) {
	xc = allChamfer ? 1 : 0;
	color(color) difference() {
		ccube(stepperMotor[width],stepperMotor[width]+slack,thick,beltStepperMotor[champfer],[0,0,0,0],[0,0,0,0],[xc,xc,1,1]);
		translate([stepperMotor[width]/2,stepperMotor[width]/2+slack,-1]) cylinder(r=stepperMotor[pilotRadius]+0.5,h=thick+2);
		if (screwHoles) xMotorMountScrewHoles(stepperMotor,thick,slack,depth=screwDepth,lg=lg);
	}
	if (showAllScrews) xMotorMountScrews(stepperMotor,thick,slack,depth=screwDepth,showScrews=showAllScrews,lg=lg);
}

function _xMotorMountScrew(stepperMotor,thick,depth) = screwMinLength(stepperMotor[screwType],thick+stepperMotor[screwType][nutHeight]*0.6,depth);
function _xMotorMountScrewPos(stepperMotor) = let (w = stepperMotor[width], d = stepperHoleFromEdge(stepperMotor)) [[d,d],[w-d,d],[d,w-d],[w-d,w-d]];

module xMotorMountScrewHoles(stepperMotor,thick=partMountingThick,slack=slack,depth=0.2,lg) {
	screw = _xMotorMountScrew(stepperMotor,thick,depth);
	translate([0,slack,0]) 
		for (xy = _xMotorMountScrewPos(stepperMotor))
			xscrewAllHole([xy.x,xy.y,thick],screw,spacing=partMountingThick,depth=depth);
}

module xMotorMountScrews(stepperMotor,thick=partMountingThick,slack=slack,showScrews=false,depth=0.2,lg) {
	screw = _xMotorMountScrew(stepperMotor,thick,depth);
	with = beltStepperMotor[width];
	translate([0,slack,0]) 
		for (xy = _xMotorMountScrewPos(stepperMotor))
			xscrew([xy.x,xy.y,thick],screw,showScrews=showScrews,depth=depth,lg=xxl(lg,d="motor mount"));
}
xMotorMount(beltStepperMotor,screwHoles=true,showAllScrews=true);

/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/