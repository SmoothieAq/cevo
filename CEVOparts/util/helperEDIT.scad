
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

function alpha(no,color) = no == $show ? $showColor : [color[0],color[1],color[2],$show == 0 ? 1 : $alpha];

module place(place,no,extra=false,extraExtra=false) {
	if ((!$onlyShow || $show == 0 || $show == no) && ($showExtra || !extra) && ($showExtraExtra || !extraExtra))
		tr(place[no]) children();
}
module show(place) {
	if ($show == 0)
		children();
	else
		rt(place[$show]) children();
}



/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/