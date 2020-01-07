
//*******************************************************************
// modules for EDIT
//*******************************************************************

//use <../imports/e3d_v6_all_metall_hotend.scad>

include <../CEVOdefinitions.scad>
use <util.scad>

/*
$show 		= 0;
$onlyShow 	= true;
$alpha		= 0.2;
$showColor 	= undef;
$showScrews 	= false;
$showExtra	= true;
$showExtraExtra = true;
*/

function alpha(no,color) = no == nnv($show,0) ? $showColor : [color[0],color[1],color[2],nnv($show,0) == 0 ? 1 : nnv($alpha,0.2)];

module place(place,no,extra=false,extraExtra=false) {
	if ((!nnv($onlyShow,true) || nnv($show,0) == 0 || nnv($show,0) == no) && (nnv($showExtra,true) || !extra) && (nnv($showExtraExtra,true) || !extraExtra))
		tr(place[no]) children();
}
module show(place) {
	if (nnv($show,0) == 0)
		children();
	else
		rt(place[nnv($show,0)]) children();
}



/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/