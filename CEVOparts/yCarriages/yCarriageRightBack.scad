//*******************************************************************
// Right part of xCarriage
//*******************************************************************

use <../imports/Chamfer.scad>;

include <yCarriagesDefinitions.scad>
//use <../util/diamants.scad>
use <../util/util.scad>
use <../xutil/xutil.scad>
use <yCarriageXHolderRightBack.scad>
use <yCarriageBoxBottom.scad>

module yCarriageSide(lg) {
    difference() {
        union() {
            xHalfDiamantTube(ycTubeRadius, ycWidth/2); // the main tube
            intersection() { // plate for meeting the yCarriageXHolderOuter
                translate([0, 0, chamfer]) cylinder(r = ycTubeRadius+bevelHeight-assembleSlack, h = ycSideWidth-ycXHolderWidth);
                tr(ycXHolderPos) yCarriageXHolder();
            }
            tr(ycXHolderPos) yCarriageXHolderInner(); // the inner part of the x holder
            for (p = [ycScrewPs[0]]) // tubes for the large screws
                translate([p.x, p.y, chamfer])
                    cylinder(r = ycScrewTubeRadius, h = ycSideWidth-chamfer);
            tr(ycBoxPos) yCarriageBoxTopHalf(); // top part of the box
        }
        tr(ycXHolderPos) translate([0,0,ycXHolderLenght]) shaftHole(xshaft,ycXHolderLenght); // hole for xshaft
        translate([0, 0, ycBushingTapWidth]) // hole for bushing
            cylinder(h = ycWidth/2, r = yshaft[bushingRadius]);
        translate([0, 0, -1]) // tap for holding bushing
            cylinder(h = ycWidth/2, r = yshaft[bushingRadius]-bushingTap);
        rotate([0, 0, 25]) // cut out to see shaft
            translate([-ycTubeRadius*2, -ycTubeRadius*1.1, ycSideWidth])
                cube([ycTubeRadius*2, ycTubeRadius*2.2, ycWidth/2]);
        tr(ycBoxPos) yCarriageBoxHalfHole(); // hole for box
        tr(ycBoxPos) xnutHole(ycIdlerP,spacing=1.05,twist=30); // nut hole for box
    }
    translate([ycScrewPs[2].x, ycScrewPs[2].y, ycWidth/2-ycBoxWidth/2])
        cylinder(r = ycScrew[radius]+0.3, h = ycBoxWidth/2);
}

module yCarriageRightBack(color) {
    lg = xl(a="Y carriage",sa="Carriage right back");
    xxPartLog(lg,c="printed part",n="yCarriageRightBack",t="PETG",d="Print with support");

    color(color) difference() {
        yCarriageSide(lg=lg);
        xholes(ycScrewPs); // holes for the large assembly screws
    }
    xnut(ycScrewPs[0],lg=lg,plate=0); // nuts for the box side assembly
    tr(ycBoxPos) xnut(ycIdlerP,lg=lg,twist=30); // nut for the box
}

if (false) {
    $doDiamants=true;
    $doRealDiamants=true;
    $showScrews=false;
    yCarriageRightBack();
} else if (true) {
    //$doRealDiamants=true;
    *yCarriageSide();
    *tr(ycXHolderPos) yCarriageXHolderOuter();
    //$showScrews=false;
    yCarriageRightBack();
}

/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/