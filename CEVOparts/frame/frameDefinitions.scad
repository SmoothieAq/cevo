
//*******************************************************************
// Definition of frame sizings
//*******************************************************************

include <../CEVOdefinitions.scad>


/////////////////////////////////////////////////////////////////////
// main properties, these have sensible defaults but can be tweaked

topBrace 		= frameHeight-100;
botBrace 		= 150;
plateSpacing	= 10;


/////////////////////////////////////////////////////////////////////
// helpers, don't change

// we have three different lenghts of extrusion
exLength 		= frameHeight;
exWidth 		= frameWidth-2*extrusionWidth;
exDepth 		= frameDepth-2*extrusionWidth;
	
// these are the three kinds of extrusions
extrusionH 		= extrusion(allExtrusion,exLength);
extrusionW 		= extrusion(allExtrusion,exWidth);
extrusionD 		= extrusion(allExtrusion,exDepth);


/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/