
//*******************************************************************
// modules for EDIT
//*******************************************************************

//use <../imports/e3d_v6_all_metall_hotend.scad>

include <../CEVOdefinitions.scad>



show 		= 0;

onlyShow 	= true;
alpha		= 0.2;
showColor 	= undef;
showScrews 	= false;
showExtra	= true;
showExtraExtra = true;


function alpha(no,color) = no == show ? showColor : [color[0],color[1],color[2],show == 0 ? 1 : alpha];

module place(place,no,extra=false,extraExtra=false) {
	if ((!onlyShow || show == 0 || show == no) && (showExtra || !extra) && (showExtraExtra || !extraExtra)) {
		pVec = place[no];
		translate([pVec[0],pVec[1],pVec[2]]) rotate([pVec[3],pVec[4],pVec[5]]) children();
	}
}
module show(place) {
	if (show == 0) {
		children();
	} else {
		pVecShow = place[show];
		rotate([-pVecShow[3],0,0]) rotate([0,-pVecShow[4],0]) rotate([0,0,-pVecShow[5]])  
			translate([-pVecShow[0],-pVecShow[1],-pVecShow[2]]) 
				children();
	}
}



/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/