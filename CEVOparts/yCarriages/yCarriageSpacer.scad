//*******************************************************************
// Right part of xCarriage
//*******************************************************************

use <../imports/Chamfer.scad>;

include <yCarriagesDefinitions.scad>
use <../util/util.scad>
use <../xutil/xutil.scad>
use <yCarriageBoxBottom.scad>
use <yCarriageRightBack.scad>


module yCarriageSpacer(color) {
    lg = xl(a="Y carriage",sa="Carriage spacer");
    xxPartLog(lg,c="printed part",n="yCarriageSpacer",t="PLA");

    r = sqrt(pow(-ycScrewPs[1].y,2)+pow(-ycScrewPs[1].x,2));
    v = asin(-ycScrewPs[1].y/r);
    module c() {
        d = (r-ycTubeRadius)+bushingWall+bushingTap*1.5;
        translate([-ycScrewTubeRadius, 0, 0]) difference() {
            cube([ycScrewTubeRadius*2, d, ycWidthHole]);
            translate([0.299,d/2.5,ycWidthHole/2])
                rotate([0,-90,0])
                    linear_extrude(0.3)
                        text("CEVO",font="Arial:style=Bold", size=4, valign="center", halign="center");
        }
    }

    color(color) difference() {
        rotate([0, 0, -90+v])
            translate([0, -r, 0]) {
                difference() {
                    union() {
                        c();
                        cylinder(r = ycScrewTubeRadius, h = ycWidthHole);
                        translate([0, 0, ycWidthHole]) intersection() {
                            c();
                            translate([0, r, 0]) cylinder(r = yshaft[bushingRadius]-slack, h = bushingTap);
                        }
                    }
                    translate([0, 0, -1]) cylinder(r = ycScrew[radius], h = ycWidthHole+2);
                }
            }
        translate([-r*2,ycScrewPs[1].y-ycScrew[radius]-0.3-r,-1]) cube([r*2,r,ycWidthHole+2]);
    }
}

if (false) {
    $doDiamants=true;
    $doRealDiamants=true;
    $showScrews=false;
    yCarriageSpacer();
} else if (true) {
    $doDiamants=true;
    $doRealDiamants=true;
    $showScrews=false;
    *yCarriageRightBack();
    yCarriageSpacer(color=accentColor);
}

/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/