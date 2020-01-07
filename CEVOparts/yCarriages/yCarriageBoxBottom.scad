//*******************************************************************
// Right part of xCarriage
//*******************************************************************

use <../imports/Chamfer.scad>;

include <yCarriagesDefinitions.scad>
use <../util/diamants.scad>
use <../util/util.scad>
use <../xutil/xutil.scad>

module yCarriageBoxHalfHole() {
	translate([-1,-1,ycIdlerHolderBotThick+chamfer]) cube([ycWidthHole/2+1,ycBoxDepth*3,ycBoxHoleHeight]);
}

module yCarriageBoxHalf() {
	difference() {
		union() {
			translate([0, 0, chamfer]) cube([ycBoxWidth/2, ycBoxDepth, ycBoxHeight-chamfer]);
			translate([0,ycBoxDepth-assembleSlack,chamfer]) cube([ycBoxWidth/2,-ycScrewPs[2].x+ycBoxEndOffset-ycBoxDepth+assembleSlack,ycIdlerHolderBotThick]);
		}
		yCarriageBoxHalfHole();
		translate([-1,-1,-1]) cube([ycBoxWidth/2+2,ycIdlerP.y*3+1+assembleSlack,ycIdlerHolderBotThick+chamfer+1+assembleSlack]);
		xscrewHole(ycIdlerP);
	}
}

module yCarriageBoxBottomHalf(color,upperIdler,lg,xBeltLeng,yBeltLeng) {
	color(color) difference() {
		translate([0, 0, ycIdlerHolderBotThick+chamfer]) mirror([0, 0, 1]) xcube([ycBoxWidth/2, ycIdlerP.y*3, ycIdlerHolderBotThick+chamfer], sides = [1, 1, 1, 0]);
		xscrewHole(ycIdlerP);
	}
	xscrew(ycIdlerP,lg=lg);
	yidlerLowerDepth = -ycIdlerP.z+ycIdlerHolderBotThick+chamfer+idlerSpacer;
	yidlerUpperDepth = yidlerLowerDepth+idlerHeight(yidler)+idlerSpacer;
	idlerDepth=upperIdler ? yidlerUpperDepth : yidlerLowerDepth;
	beltz = ycIdlerP.z+idlerDepth+yidler[flangeBotHeight];
	xpulley(ycIdlerP,yidler,depth=idlerDepth,lg=lg);
	tr([ycIdlerP.x-yidler[radius],ycIdlerP.y,beltz,0,0,90]) xbelt(leng=xBeltLeng);
	translate([ycIdlerP.x,ycIdlerP.y,beltz]) rotate([0,0,-90]) xbeltPulley(a=90,pulley=yidler);
	tr([ycIdlerP.x+yBeltLeng,ycIdlerP.y-yidler[radius],beltz,0,0,180]) xbelt(leng=yBeltLeng);
}

module yCarriageBoxTopHalf() {
	difference() {
		yCarriageBoxHalf();
	}
}

module yCarriageBoxBottom(color,yBeltFrontLeng=30,yBeltBackLeng=230,xBeltLeng=150) {
	lg = xl(a="Y carriage",sa="Box bottom");
	xxPartLog(lg,c="printed part",n="yCarriageBoxBottom",t="PETG");

	yCarriageBoxBottomHalf(color,false,lg,xBeltLeng,yBeltBackLeng);
	mirror([1,0,0]) yCarriageBoxBottomHalf(color,true,lg,xBeltLeng,yBeltFrontLeng);
}

if (false) {
	$doDiamants=true;
	$doRealDiamants=true;
	$showScrews=true;
	yCarriageBoxBottom();
} else if (true) {
	//$doRealDiamants=true;
	*yCarriageBoxHalf();
	*mirror([1, 0, 0]) yCarriageBoxHalf();
	*yCarriageBoxBottomHalf();

	yCarriageBoxBottom();
	*yCarriageBoxTopHalf();
}


/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/