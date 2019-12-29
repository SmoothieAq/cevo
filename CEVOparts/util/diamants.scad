
//*******************************************************************
// Make diamant patterns
//*******************************************************************

include <../CEVOdefinitions.scad>


/////////////////////////////////////////////////////////////////////
// helpers, don't change

diamantL = diamantLength/2;
diamantW = diamantWidth/2;
diamantA1 = atan(diamantW/diamantL);
diamantH = (diamantW*diamantL)/sqrt(pow(diamantW,2)*pow(diamantL,2));
diamantA2 = atan(bevelHeight/diamantH);


/////////////////////////////////////////////////////////////////////
// main modules

module diamant() {
	if ($doRealDiamants) {
		difference() {
			translate([-diamantWidth/2,-diamantLength/2,-bevelHeight])
				cube([diamantWidth*2,diamantLength*2,bevelHeight*2]);
			rotate([0,-diamantA2,diamantA1]) 
				translate([-diamantWidth,-diamantLength,-bevelHeight])
					cube([diamantWidth*3,diamantLength*3,bevelHeight*5]);
			translate([diamantWidth,0,0])
				rotate([0,diamantA2,-diamantA1]) 
					translate([-diamantWidth,-diamantLength,-bevelHeight])
						cube([diamantWidth*3,diamantLength*3,bevelHeight*5]);
			translate([0,diamantLength,0])
				rotate([0,-diamantA2,-diamantA1]) 
					translate([-diamantWidth,-diamantLength,-bevelHeight])
						cube([diamantWidth*3,diamantLength*3,bevelHeight*5]);
			translate([diamantWidth,diamantLength,0])
				rotate([0,diamantA2,diamantA1]) 
					translate([-diamantWidth,-diamantLength,-bevelHeight])
						cube([diamantWidth*3,diamantLength*3,bevelHeight*5]);
		}
	} else {
		translate([diamantW/2,diamantL/2,0])
			cube([diamantW,diamantL,bevelHeight*0.8]);
	}
}

module diamantPlate(width,length,xoffset=0,yoffset=0,xfull=0,yfull=0) {
	if (nnv($doDiamants,true)) difference() {
		union() {
			for(x=[xoffset : diamantWidth+diamantSpacing : width-xfull*diamantWidth]) 
				for(y=[yoffset : diamantLength+diamantSpacing : length-yfull*diamantLength]) 
					translate([x,y,0]) diamant();
			for(x=[xoffset-diamantWidth/2-diamantSpacing/2 : diamantWidth+diamantSpacing : width-xfull*diamantWidth]) 
				for(y=[yoffset-diamantLength/2-diamantSpacing/2 : diamantLength+diamantSpacing : length-yfull*diamantLength]) 
					translate([x,y,0]) diamant();
		}
		translate([-diamantWidth*2,-0.1,-bevelHeight-0.2]) cube([diamantWidth*2,length+diamantLength*2,bevelHeight*2+0.5]);
		translate([-0.1,length,-bevelHeight-0.12]) cube([width+diamantWidth*2,diamantLength*2,bevelHeight*2+0.5]);
		translate([width,-diamantLength*2+0.1,-bevelHeight-0.2]) cube([diamantWidth*2,length+diamantLength*2,bevelHeight*2+0.5]);
		translate([-diamantWidth*2,-diamantLength*2,-bevelHeight-0.2]) cube([width+diamantWidth*2+0.1,diamantLength*2,bevelHeight*2+0.5]);
	}
}

module diamantTube(radius,deg,height,xoffset=0,zoffset=0,xfull=0,yfull=0) {
	circ = 3.14*2*radius;
	width = circ*deg/360;
	if (nnv($doDiamants,true)) difference() {
		union() {
			for(x=[xoffset : diamantWidth+diamantSpacing : width-xfull*diamantWidth]) {
				v = x/circ*360; tx=sin(v)*radius; ty=-cos(v)*radius; 
				for(z=[zoffset : diamantLength+diamantSpacing : height-yfull*diamantLength]) 
					translate([tx,ty,z]) rotate([90,0,v]) translate([-diamantWidth/2,0,0]) diamant();
			}
			for(x=[xoffset-diamantWidth/2-diamantSpacing/2 : diamantWidth+diamantSpacing : width-xfull*diamantWidth]) {
				v = x/circ*360; tx=sin(v)*radius; ty=-cos(v)*radius; 
				for(z=[zoffset-diamantLength/2-diamantSpacing/2 : diamantLength+diamantSpacing : height-yfull*diamantLength]) 
					translate([tx,ty,z]) rotate([90,0,v]) translate([-diamantWidth/2,0,0]) diamant();
			}
		}
		translate([0,0,-diamantLength*2]) cylinder(h=diamantLength*2,r=radius+bevelHeight+0.5);
		translate([0,0,height]) cylinder(h=diamantLength*2,r=radius+bevelHeight+0.5);
		tx=sin(deg)*radius; ty=-cos(deg)*radius; 
		translate([tx,ty,0]) rotate([0,0,deg]) translate([0,-diamantWidth,0]) cube([diamantWidth*2,diamantWidth*2,height+0.5]);
		translate([-diamantWidth*2,-radius-diamantWidth,-0.2]) cube([diamantWidth*2,diamantWidth*2,height+0.5]);
	}
}


//diamant(2);

//color("blue") translate([-30,0,0]) diamantPlate(11,12);
//color("red") translate([-31,-1,-1]) cube([13,14,1]);

//color("blue") translate([-30,0,0]) diamantTube(10,225,10);
//color("red") translate([-30,0,0]) cylinder(h=10,r=10);


/*
This design and software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/