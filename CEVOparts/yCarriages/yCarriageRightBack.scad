//*******************************************************************
// Right part of xCarriage
//*******************************************************************

use <../imports/Chamfer.scad>;

include <yCarriagesDefinitions.scad>
//use <../util/diamants.scad>
use <../util/util.scad>
use <../xutil/xutil.scad>
use <yCarriageXHolderLeftSide.scad>
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
            for (p = ycScrewPs) // tubes for the large screws
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
        tr(ycBoxPos) xnutHole(ycIdlerP,spacing=1.05); // nut hole for box
    }
}

module yCarriageRightBack(color) {
    lg = xl(a="Y carriage",sa="Carriage right back");
    xxPartLog(lg,c="printed part",n="yCarriageRightBack",t="PETG",d="Print with support");

    color(color) difference() {
        yCarriageSide(lg=lg);
        xholes(ycScrewPs); // holes for the two side assembly screws
    }
    tr(ycXHolderPos) xnuts(ycXHolderPs,lg=lg); // nuts for the x holder
    xnuts(ycScrewPs,lg=lg,plate=0); // nuts for the two side assembly
    tr(ycBoxPos) xnut(ycIdlerP,lg=lg); // nut for the box
}

*yCarriageSide();
*tr(ycXHolderPos) yCarriageXHolderOuter();
yCarriageRightBack();


/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/