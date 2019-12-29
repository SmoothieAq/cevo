
//*******************************************************************
// frame assembly
//*******************************************************************


include <../CEVOdefinitions.scad>
include <frameDefinitions.scad>
include <../util/helperEDIT.scad>
use <frame.scad>
use <bottomPlate.scad>



module frameAssembly() {
	place = [[],
		[0,0,0,0,0,0], 													// frame
		[0,0,plateSpacing,0,0,0], 													// bottom
	[]];
	show(place) { 
		place(place,1) frame(color=alpha(1,frameColor));
		place(place,2) bottomPlate(color=alpha(2,carbonColor));
	}
}

frameAssembly();


/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/