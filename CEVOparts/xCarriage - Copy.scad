include <util/standardDefinitions.scad>
use <imports/Chamfer.scad>;
use <imports/spiral_vase-linear_bearing.scad>
use <imports/e3d_v6_all_metall_hotend.scad>;

$fs=0.2;
$fa=2;


//////// smaller generic elements

bushingWall = 3;
bushingTap = 1.5;
screwTapMinThick = 1.4;
screwTapThick = 2.0;
screwTapSolidThick = 4;

bevelHeight = 0.6;
bevelWidth = 2.0;
diamantLength = 5;
diamantWidth = 2.5;
diamantSpacing = 0.2;
chamfer = 1.5;

slack = 0.2;

doDiamants = true;
doRealDiamants = true;

// helpers, dont change
diamantL = diamantLength/2;
diamantW = diamantWidth/2;
diamantA1 = atan(diamantW/diamantL);
diamantH = (diamantW*diamantL)/sqrt(pow(diamantW,2)*pow(diamantL,2));
diamantA2 = atan(bevelHeight/diamantH);

module diamant(v=1) {
	if (doRealDiamants) {
		if (v==1) {
			polyhedron(
				[[diamantWidth/2,-diamantLength/2,-bevelHeight],[-diamantWidth/2,diamantLength/2,-bevelHeight],
				 [diamantWidth/2,diamantLength*1.5,-bevelHeight],[diamantWidth*1.5,diamantLength/2,-bevelHeight],
				 [diamantWidth/2,diamantLength/2,bevelHeight]],
				[[0,1,4],[1,2,4],[2,3,4],[3,0,4],[1,3,0],[1,3,2]], convexity=4
			);
		} else {
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
		}
	} else {
		translate([diamantW/2,diamantL/2,0])
			cube([diamantW,diamantL,bevelHeight]);
	}
}
module diamantPlate(width,length,xoffset=0,yoffset=0,xfull=0,yfull=0,v=2) {
	if (doDiamants) difference() {
		union() {
			for(x=[xoffset : diamantWidth+diamantSpacing : width-xfull*diamantWidth]) 
				for(y=[yoffset : diamantLength+diamantSpacing : length-yfull*diamantLength]) 
					translate([x,y,0]) diamant(v);
			for(x=[xoffset-diamantWidth/2-diamantSpacing/2 : diamantWidth+diamantSpacing : width-xfull*diamantWidth]) 
				for(y=[yoffset-diamantLength/2-diamantSpacing/2 : diamantLength+diamantSpacing : length-yfull*diamantLength]) 
					translate([x,y,0]) diamant(v);
		}
		translate([-diamantWidth*2,-0.1,-bevelHeight-0.2]) cube([diamantWidth*2,length+diamantLength*2,bevelHeight*2+0.5]);
		translate([-0.1,length,-bevelHeight-0.12]) cube([width+diamantWidth*2,diamantLength*2,bevelHeight*2+0.5]);
		translate([width,-diamantLength*2+0.1,-bevelHeight-0.2]) cube([diamantWidth*2,length+diamantLength*2,bevelHeight*2+0.5]);
		translate([-diamantWidth*2,-diamantLength*2,-bevelHeight-0.2]) cube([width+diamantWidth*2+0.1,diamantLength*2,bevelHeight*2+0.5]);
	}
}
module diamantTube(radius,deg,height,xoffset=0,zoffset=0,xfull=0,yfull=0,v=2) {
	circ = 3.14*2*radius;
	width = circ*deg/360;
	if (doDiamants) difference() {
		union() {
			for(x=[xoffset : diamantWidth+diamantSpacing : width-xfull*diamantWidth]) {
				v = x/circ*360; tx=sin(v)*radius; ty=-cos(v)*radius; 
				for(z=[zoffset : diamantLength+diamantSpacing : height-yfull*diamantLength]) 
					translate([tx,ty,z]) rotate([90,0,v]) translate([-diamantWidth/2,0,0]) diamant(v);
			}
			for(x=[xoffset-diamantWidth/2-diamantSpacing/2 : diamantWidth+diamantSpacing : width-xfull*diamantWidth]) {
				v = x/circ*360; tx=sin(v)*radius; ty=-cos(v)*radius; 
				for(z=[zoffset-diamantLength/2-diamantSpacing/2 : diamantLength+diamantSpacing : height-yfull*diamantLength]) 
					translate([tx,ty,z]) rotate([90,0,v]) translate([-diamantWidth/2,0,0]) diamant(v);
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
/*
color("blue") translate([-30,0,0]) diamantPlate(11,12);
color("red") translate([-31,-1,-1]) cube([13,14,1]);
color("blue") translate([-10,0,0]) diamantPlate(11,12,v=2);
color("red") translate([-11,-1,-1]) cube([13,14,1]);
*/
//color("blue") translate([-30,0,0]) diamantTube(10,225,10);
//color("red") translate([-30,0,0]) cylinder(h=10,r=10);


//////// overall configuration

xshaft = shaft10;
xshaftDistance = 60;

hotendOffset = [0,-6,0];

//////// carriage element

carriageScrew = screw(m3,60); 		// screw length defines width of carriage
carriageMountScrew = screw(m3,-9); 	// screw length not used, this size is used for all mounting on carriage
carriageWidthHole = 32;				// a e3d fan is 30, make room for it
carriageThick = 6;
carriagePlateNudge = 1;

// helpers, dont change
xTubeRadius = xshaft[bushingRadius] + bushingWall;
carriageWidth = carriageScrew[length] + carriageScrew[headHeight];
carriagePlateDepth = xshaftDistance - (xTubeRadius-carriagePlateNudge)*2;
carriageTubeRadius = (xshaftDistance-carriagePlateDepth)/2;



module carriageSide() {

	module tube(cutAt=0) {
		difference() {
			union() {
				translate([0,xTubeRadius,0]) 
					ccylinder(bevelWidth+chamfer,xTubeRadius+bevelHeight,chamfer,bevelHeight); 
				translate([0,xTubeRadius,bevelWidth+chamfer]) 
					cylinder(h=carriageWidth/2-bevelWidth-chamfer,r=xTubeRadius); 
				translate([0,-bevelHeight,0]) 
					chamferCube(carriageTubeRadius,xTubeRadius*2+bevelHeight,bevelWidth+chamfer+(chamfer-bevelHeight),chamfer,[1,1,0,1],[0,0,0,0],[0,0,0,0]);
				translate([0,0,bevelWidth+chamfer]) 
					cube([carriageTubeRadius,xTubeRadius*2,carriageThick-bevelWidth-chamfer]);
				translate([0,0,carriageThick]) 
					cube([carriageTubeRadius,carriageTubeRadius,carriageWidth/2-carriageThick]);
				b = bevelWidth+chamfer-bevelHeight; h = carriageWidth/2-b;
				translate([0,0,b]) 
					rotate([90,0,0]) 
						diamantPlate(carriageTubeRadius,h,yoffset=h%(diamantLength+diamantSpacing)-diamantLength-diamantSpacing/2);
				translate([0,xTubeRadius,carriageWidth/2])
					rotate([180,0,-180])
						diamantTube(xTubeRadius,235,h,zoffset=-diamantLength/2-diamantSpacing);
				translate([carriageTubeRadius-bevelHeight,-bevelHeight,b]) 
					chamferCube(bevelHeight,bevelHeight,h,bevelHeight,[0,0,0,0],[0,0,0,0],[1,0,0,0]);
			}
			translate([0,xTubeRadius,bushingTap]) 
				cylinder(h=carriageWidth/2, r=xshaft[bushingRadius]);
			translate([0,xTubeRadius,-1]) 
				cylinder(h=bushingTap+2, r=xshaft[bushingRadius]-bushingTap);
			translate([xshaft[bushingRadius]-carriageScrew[holeRadius]*0.5,screwTapThick-bevelHeight+carriageScrew[holeRadius],carriageWidth/2])  //translate([xshaft[bushingRadius], xshaft[bushingRadius]/2,-1]) 
				screwHole(carriageScrew,carriageWidth/2); //cylinder(h=carriageWidth,r=carriageScrew[holeRadius]);
			translate([xshaft[bushingRadius]-carriageScrew[holeRadius]*0.5,screwTapThick-bevelHeight+carriageScrew[holeRadius],0])  //translate([xshaft[bushingRadius], xshaft[bushingRadius]/2,-1]) 
				rotate([180,0,0]) screwHeadHole(carriageScrew); //cylinder(h=carriageWidth,r=carriageScrew[holeRadius]);
		}
		difference() {
			translate([carriageTubeRadius,carriageThick-bevelHeight,carriageThick]) 
				cube([carriageMountScrew[nutHoleRadius]*2+carriagePlateNudge,screwTapSolidThick,carriageMountScrew[nutHoleRadius]*2]);
			translate([carriageTubeRadius+carriageMountScrew[nutHoleRadius]+carriagePlateNudge,carriageThick-1,carriageThick+carriageMountScrew[nutHoleRadius]]) 
				rotate([-90,0,0]) 
					cylinder(h=carriageThick,r=carriageMountScrew[holeRadius]);
		}
	}
	
	module tubeFront() {
		cutAt=(carriageWidth-carriageWidthHole)/2;
		difference() {
			tube();
			translate([-xTubeRadius*2.5,-xTubeRadius*0.5,cutAt]) 
				cube([xTubeRadius*5,xTubeRadius*3,carriageWidth]);
		}
		difference() {
			translate([0,xTubeRadius,cutAt-bevelWidth])
				ccylinder(bevelWidth,xTubeRadius+bevelHeight,bevelHeight);
			translate([xTubeRadius-bushingWall*2,-bevelHeight-0.2,cutAt-bevelWidth-0.2])
				rotate([0,0,-10])
					cube([bushingWall*3,xTubeRadius*2,bevelWidth+bevelHeight+0.4]);
			translate([0,xTubeRadius,cutAt-bevelWidth-1]) 
				cylinder(h=bevelWidth+2,r=xshaft[bushingRadius]);
		}
		translate([0,-bevelHeight,cutAt-bevelWidth]) 
			chamferCube(carriageTubeRadius,bevelHeight,bevelWidth,bevelHeight,[1,0,0,0],[0,0,0,0],[0,0,0,0]);
	}

	module tubeBack() {
	
		tapx = carriageMountScrew[nutHoleWidth]*4; tapy = xTubeRadius; tapz = carriageMountScrew[nutHoleWidth]*2+tapy;
		module tap() {
			translate([xshaftDistance,-bevelHeight*1,carriageWidth/2-tapz])
				chamferCube(tapx,tapy,tapz,tapy,[1,0,0,0],[0,0,0,0],[0,0,0,0]);
		}
		module tapHole() {
			translate([xshaftDistance,xTubeRadius,carriageWidth/2-tapz-1]) 
				cylinder(h=tapz+2,r=xshaft[bushingRadius]);
			translate([xshaftDistance+tapx-carriageMountScrew[nutHoleWidth]*1.5,screwTapMinThick-bevelHeight,carriageWidth/2-carriageMountScrew[nutHoleWidth]/2]) 
				rotate([-90,0,0]) 
					nutHole(carriageMountScrew);
			translate([xshaftDistance+tapx-carriageMountScrew[nutHoleWidth]*1.5,-1,carriageWidth/2]) 
				rotate([-90,0,0]) 
					cylinder(h=screwTapMinThick+2,r=carriageMountScrew[holeRadius]);
		}
		
		difference() {
			union() {
				translate([xshaftDistance,0,0]) mirror([1,0,0]) tube();
				tap();
				translate([0,xTubeRadius*2,0]) mirror([0,1,0]) tap();
			}
			tapHole();
			translate([0,xTubeRadius*2,0]) mirror([0,1,0]) tapHole();
		}
	}
	
	tubeFront();
	tubeBack();
	translate([carriageTubeRadius,carriageThick-bevelHeight,0]) 
		chamferCube(carriagePlateDepth,xTubeRadius*2-carriageThick+bevelHeight,carriageThick,chamfer,[0,1,0,0],[0,0,0,0],[0,0,0,0]);
}

module x_carriage_right() {
	carriageSide();
}

module x_carriage_left() {
	carriageSide();
}

carriageFrontScale = 0.7;
carriageFrontRadius = xshaft[bushingRadius]*carriageFrontScale;
module x_carriage_front() {
	difference() {
		cylinder(h=carriageWidthHole,r=carriageFrontRadius);
		translate([xshaft[bushingRadius]-carriageTubeRadius,xshaft[bushingRadius]/2-carriageFrontRadius+bevelHeight,-1]) 
			cylinder(carriageWidth,carriageScrew[holeRadius],carriageScrew[holeRadius]);
		translate([0,-xshaft[bushingRadius]-1,-1]) 
			cube([xshaft[bushingRadius]*2,xshaft[bushingRadius]*2,carriageWidthHole+2]);
		translate([-xshaft[bushingRadius],carriageThick*carriageFrontScale,-1]) 
			cube([xshaft[bushingRadius]*2,xshaft[bushingRadius]*2,carriageWidthHole+2]);
	}
	translate([-xshaft[bushingRadius]/2+bevelHeight,-xshaft[bushingRadius]/2+bevelHeight,carriageWidthHole/2])
		rotate([135,90,0])
			linear_extrude(1)
				text("CEVO",font="Arial:style=Bold", size=5, valign="center", halign="center");
}

module x_carriage_top() {
	module mountHole(x,y) { translate([x,y,carriageThick]) screwHole(carriageMountScrew,carriageThick); }
	module mountHeadHole(x,y) { translate([x,y,carriageThick]) screwHeadHole(carriageMountScrew); }
	module mountAllHole(x,y) { mountHole(x,y); mountHeadHole(x,y);; }
	
	thick = carriageThick-bevelHeight;
	
	module quater() {
		cube([carriageWidth/2-chamfer,carriagePlateDepth/2,thick]);
		b = bevelWidth+chamfer-bevelHeight; h = carriageWidth/2-b;
		endbev = bevelWidth+chamfer+(chamfer-bevelHeight);
		translate([carriageWidth/2-endbev,0,0]) 
			chamferCube(endbev,carriagePlateDepth/2,carriageThick,chamfer,[0,0,0,0],[0,1,1,0],[0,0,0,0]);
		translate([0,carriagePlateDepth/2-bevelWidth,thick]) 
			chamferCube(carriageWidth/2-bevelWidth,bevelWidth,bevelHeight,bevelHeight,[0,0,0,1],[0,0,0,0],[0,0,0,0]);
		translate([h,0,thick]) //translate([0,carriagePlateDepth/2,thick]) 
			rotate([0,0,90]) 
				diamantPlate(carriagePlateDepth/2,h,yoffset=h%(diamantLength+diamantSpacing)-diamantLength-diamantSpacing/2);
	}
	module quaterHoles() {
		mountAllHole(carriageWidth/2-carriageMountScrew[nutHoleRadius]-carriageThick,carriagePlateDepth/2-carriageMountScrew[nutHoleRadius]-carriagePlateNudge);
	}
	
	module half() {
		quater();
		mirror([0,1,0]) quater();
	}
	module halfHoles() {
		quaterHoles();
		mirror([0,1,0]) quaterHoles();
	}

	module full() {
		half();
		mirror([1,0,0]) half();
	}
	module fullHoles() {
		halfHoles();
		mirror([1,0,0]) halfHoles();
	}

	module nimbleFooter() {
		translate([0,0,thick])
			ccylinder(bevelHeight,22/2+bevelHeight,0,bevelHeight);
		translate([14,-2,thick])
			ccylinder(bevelHeight,7/2+bevelHeight,0,bevelHeight);
		translate([-2,15,thick])
			ccylinder(bevelHeight,7/2+bevelHeight,0,bevelHeight);
		translate([7.5,20,thick])
			ccylinder(bevelHeight,17/2+bevelHeight,0,bevelHeight);
	}
	
	module nimbleHoles() {
		mountHole(14,-2);
		mountHole(-2,15);
	}
	
	module e3dHoles() {
		dx = 9; dy = 9;
		mountAllHole(dx,dy);
		mountAllHole(dx,-dy);
		mountAllHole(-dx,dy);
		mountAllHole(-dx,-dy);
	}

	difference() {
		union() {
			full();
			translate(hotendOffset) nimbleFooter();
		}
		fullHoles();
		translate(hotendOffset) {
			e3dHoles();
			nimbleHoles();
		}
		translate([-carriageWidth/2-1,-carriagePlateDepth,-1]) 
			cube([carriageWidth+2,carriagePlateDepth/2,carriageThick+2]);
		translate([-carriageWidth/2-1,carriagePlateDepth/2,-1]) 
			cube([carriageWidth+2,carriagePlateDepth/2,carriageThick+2]);
	}
}
//color("grey") x_carriage_top();


module shaft() {
	translate([0,xTubeRadius,-100]) cylinder(h=200,r=xshaft[radius]);
}

black = "DarkSlateGray";

module x_carriage(a=0.3,b=true) {
	color(black) x_carriage_right();
	color(black,a) translate([0,0,carriageWidth]) mirror([0,0,1]) x_carriage_left();

	color("red",a) translate([carriageTubeRadius, xshaft[bushingRadius]*0.7-bevelHeight,(carriageWidth-carriageWidthHole)/2])
		x_carriage_front();

	color(black,a) translate([carriagePlateDepth/2+carriageTubeRadius,carriageThick-bevelHeight,carriageWidth/2]) rotate([90,90,0]) x_carriage_top();

	color("gray",a) shaft();
	color("gray",a) translate([xshaftDistance,0,0]) shaft();
	
	if (b) {
		blf = (carriageWidth-carriageWidthHole)/2-1;
		color("red",a) translate([0,xTubeRadius,blf/2+1]) bushing(xshaft[bushingRadius]*2,xshaft[radius]*2,blf,drill=true);
		color("red",a) translate([0,xTubeRadius,carriageWidth-blf/2-1]) bushing(xshaft[bushingRadius]*2,xshaft[radius]*2,blf,drill=true);
		blb = carriageWidth-2;
		color("red",a) translate([xshaftDistance,xTubeRadius,blb/2+1]) bushing(xshaft[bushingRadius]*2,xshaft[radius]*2,blb,drill=true);
	}
}

doRealDiamants=false;
//color("grey") x_carriage_right();
//x_carriage(b=false,a=0.6);
module view(b=true,a=1) {
	translate([carriageWidth/2,-xshaftDistance/2,0]) rotate([-90,0,90]) 
		x_carriage(b=b,a=a);

	color("silver") translate(hotendOffset) rotate([180,0,90]) e3d();
	color(black) translate([-15,-11.15-14,-20-30]) translate(hotendOffset) cube([30,14,30]);
}
view(b=false);

module ccylinder(h,xTubeRadius,c1h=0,c2h=0) {
	//chamferCylinder(h, xTubeRadius, xTubeRadius, chamferHeight = c1h, chamferHeight2 = c2h);

	if (c1h != 0) cylinder(c1h,xTubeRadius-c1h,xTubeRadius);
	translate([0,0,c1h]) cylinder(h-c1h-c2h,xTubeRadius,xTubeRadius);
	if (c2h != 0) translate([0,0,h-c2h]) cylinder(c2h,xTubeRadius,xTubeRadius-c2h);
}

/*
This software is copyrighted, but is free for private, non-commercial use.

All copyrights for this software belongs to Jesper Lauritsen, Denmark, smoothieAq@gmail.com.
If you are a non-profit company, or use the software for personal use, you may enjoy the software
for free under a Creative Commons (CC) Attribution-NonCommercial licence 
	https://creativecommons.org/licenses/by-nc/3.0/
Please contact Jesper, if you need any other kind of license.
*/