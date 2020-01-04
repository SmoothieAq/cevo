//*******************************************************************
// Right part of xCarriage
//*******************************************************************

use <../imports/Chamfer.scad>;

include <yCarriagesDefinitions.scad>
//use <../util/diamants.scad>
use <../util/util.scad>
use <../xutil/xutil.scad>
use <yCarriageRightBack.scad>
use <yCarriageXHolderRightFront.scad>


module yCarriageRightFront(color) {
    lg = xl(a="Y carriage",sa="Carriage right front");
    xxPartLog(lg,c="printed part",n="yCarriageRightFront",t="PETG",d="Print with support");

    mirror([0,0,1]) {
        color(color) difference() {
            yCarriageSide(lg = lg);
            translate([0,0,ycWidth]) mirror([0,0,1]) xholes(ycScrewPs); // holes for the two side assembly screws
        }
        translate([0,0,ycWidth]) mirror([0,0,1]) xscrew(ycScrewPs[0], lg = lg, plate = 0); // screws for the box side assembly
        tr(ycBoxPos) xnut(ycIdlerP, lg = lg,twist=30); // nut for the box
    }
}

if (true) {
    $doDiamants=true;
    $doRealDiamants=true;
    $showScrews=false;
    yCarriageRightFront();
} else if (true) {
    *yCarriageSide();
    *tr(ycXHolderPos) yCarriageXHolderRightFront();
    //$showScrews=false;
    yCarriageRightFront();
}

/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/