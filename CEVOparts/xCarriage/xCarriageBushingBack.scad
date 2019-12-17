
//*******************************************************************
// back bushings for x carriage
//*******************************************************************
// print PLA in vase mode
//*******************************************************************

use <../genericParts/bushing.scad>
include <xCarriageDefinitions.scad>

module xCarriageBushingBack(color=undef,showScrews=false,drill=false) {
	color(color) bushing(xshaft,carriageWidth-2*bushingTap,drill=drill);
}

xCarriageBushingBack(color=accentColor);

/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/