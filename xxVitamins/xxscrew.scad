include <../xNopSCADlib/core.scad>

use <NopSCADlib/vitamins/screw.scad>
use <NopSCADlib/vitamins/nut.scad>
use <../xVitamins/xscrew.scad>
use <../xVitamins/xnut.scad>
use <../xUtil/xUtil.scad>


function xxscrew_xscrew(type) 		= type[1];
function xxscrew_translate(type) 	= nnv(type[2], [0,0,0]);
function xxscrew_rotate(type)	 	= nnv(type[3], [0,0,0]);
function xxscrew_washer(type) 		= nnv(type[4], $screw_washer) == true ? screw_washer(type[1]) : type[4];
function xxscrew_depth(type) 		= nnv(type[5], $screw_depth);
function xxscrew_xnut(type) 		= type[6] == true || type[6] == undef ? screw_nut(type[1]) : type[6];
function xxscrew_nut_washer(type) 	= nnv(type[7], $nut_washer) == true ? nut_washer(xxscrew_xnut(type)) : type[7];
function xxscrew_nut_depth(type) 	= type[8];
function xxscrew_twist(type) 		= type[9];
function xxscrew_thick(type)	 	= type[10];
function xxscrew_spacing(type)	 	= type[11];
function xxscrew_nut_spacing(type) 	= type[12];
