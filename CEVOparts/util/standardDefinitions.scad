
//*******************************************************************
// standard constant elements and some utillity functions and modules
//*******************************************************************


use <util.scad>

// extrusions
exmainsq=0; length=1; excentersq=2; excornersq=3; exflangethick=4; exflangelen=5; exname=6;
extrusion3030 = [30,-99,11.64,(30-16.51)/2,2.21,(30-8.13)/2-(30-16.51)/2,"3030"];

function extrusion(std,exLength) = [std[exmainsq],exLength,std[excentersq],std[excornersq],std[exflangethick],std[exflangelen],std[exname]];
function exMountScrewDepth(extrusion) = (extrusion[exmainsq]-extrusion[excentersq])/2-3;
module profile( mainsq, centersq, cornersq, flangethick, flangelen ) {
    module corner() {
        square(cornersq);
        translate([cornersq,0,0]) 
            square([flangelen,flangethick]);
        translate([0,cornersq,0]) 
            square([flangethick,flangelen]);
        rotate([0,0,45]) translate([cornersq/2,-flangethick/2,0])
            square([mainsq/2-flangelen,flangethick]);
    }
    translate([mainsq/2,mainsq/2,0]) {
        for( v = [0:90:360] ) 
            rotate([0,0,v]) translate([-mainsq/2,-mainsq/2,0])
                corner();
        square(centersq,center=true);
    }
}
module theExtrusion(extrusion,leng) { linear_extrude(nnv(leng,extrusion[length])) profile(extrusion[exmainsq],extrusion[excentersq],extrusion[excornersq],extrusion[exflangethick],extrusion[exflangelen]); }

// shafts: 
radius=0; length=1; bushingRadius=2; bushingStdLength=3;
shaft8  = [4,-99, 8.0,25];
shaft10 = [5,-99, 9.5,29];
shaft12 = [6,-99,11.0,32];

function shaft(std,shaftLength) = [std[0],shaftLength,std[2],std[3]];
module theShaft(shaft,leng) { len = leng > 0 ? leng : shaft[length]; translate([-len/2,0,0]) rotate([0,90,0]) cylinder(r=shaft[radius],h=len); }


// screws:
radius=0; length=1; holeRadius=2; headRadius=3; headHoleRadius=4; headHeight=5; 
nutWidth=6; nutHoleWidth=7; nutHoleRadius=8;  nutHeight=9; nutHoleHeight=10; screwLengths=11; screwName=12;
m2 = [1.00,-99,1.05,1.50,1.60,2.00,2.00,2.05,2.21,1.60,1.80,[3,4,5,6,8,10,12,16,20,25,30],"m2"];
m3 = [1.50,-99,1.55,2.50,2.60,3.00,2.75,2.80,3.10,2.40,2.60,[3,4,5,6,8,10,12,16,20,25,30,35,40,45,50,55,60],"m3"];
m4 = [2.00,-99,2.05,3.00,3.10,4.00,3.50,3.55,3.89,3.20,3.40,[3,4,5,6,8,10,12,16,20,25,30,35,40,45,50,60,70,80,90],"m4"];
m5 = [2.50,-99,2.55,4.00,4.10,5.00,4.00,4.05,4.49,4.70,4.90,[5,10,12,16,20,25,30,35,40,50,60,70,80,90],"m5"];

function screwMinLength(screw,minLength,depth) = 
	let ( ml = minLength-nnv(depth,0)*screw[headHeight] )
		screw(screw,[ for ( l=screw[screwLengths] ) if ( l >= minLength ) l ][0]);
function screw(std,screwLength) = [std[0],screwLength,std[2],std[3],std[4],std[5],std[6],std[7],std[8],std[9],std[10],std[11],std[12]];
module hexaprism(r,h) { rotate([0,0,30]) cylinder(r=r*2/sqrt(3),h=h,$fn=6); }
module nut(screw,depth=0,twist=0) { 
	translate([0,0,-depth*screw[nutHoleHeight]]) rotate([0,0,twist]) {
		difference() {
			hexaprism(screw[nutWidth],screw[nutHeight]); 
			translate([0,0,screw[nutHeight]/2+0.1]) cylinder(r=screw[radius],h=screw[nutHeight]/2);
		}
	}
}
module nutHole(screw,depth=1,twist=0,spacing=undef) { 
	spc = spacing != undef ? spacing : screw[nutHoleHeight];
	translate([0,0,-depth*screw[nutHoleHeight]]) rotate([0,0,twist])
		hexaprism(screw[nutHoleWidth],screw[nutHoleHeight]+spc); 
}
module screwHole(screw,leng) { 
	len = nnv(leng,screw[length]); 
	translate([0,0,-len-0.1]) cylinder(r=screw[holeRadius],h=len+0.2); 
}
module screwHead(screw,depth=0) { 
	translate([0,0,-depth*screw[headHeight]]) 
		difference() {
			ccylinder(r=screw[headRadius],h=screw[headHeight],c1h=screw[headRadius]/8,c2h=screw[headRadius]/8); 
			translate([0,0,screw[headHeight]/2+0.1]) hexaprism(r=screw[headRadius]/3,h=screw[headHeight]/2);
		}
}
module theScrew(screw,depth=0,leng) {
	len = nnv(leng,screw[length]); 
	screwHead(screw,depth=depth);
	translate([0,0,-depth*screw[headHeight]-len]) cylinder(r=screw[radius],h=len);
}
module screwHeadHole(screw,depth=1,spacing=20) { 
	translate([0,0,-depth*screw[headHeight]]) 
		cylinder(r=screw[headHoleRadius],h=screw[headHeight]+spacing); 
}
module screwAllHole(screw,leng,depth=1,spacing=20) { 
	screwHole(screw,leng); 
	screwHeadHole(screw,depth,spacing); 
}


// timing belt
width=2; thick=3; toothHeight=4; toothSpacing=5; beltName=6;
gt2 = [0,0,6,1.38,0.75,2,"gt"];

function beltBaseThick(belt) = belt[thick]-belt[toothHeight];


// belt idler/timing pullys:
radius=0; forBelt=1; holeRadius=2; toothed=3; baseRadius=4; flangeTopHeight=5; flangeBotHeight=6; flangeRadius=7; pullyName=8;
F623x2 		= [5.00,gt2,1.5,false,5.00,1.0,1.0,6.0,"F623 x 2"]; // two F633 against each other, use f633zz
Gt2Timing20 = [5.95,gt2,2.5,true, 5.00,1.1,7.5,8.0,"Gt2 timing 20"]; 
Gt2Idler20 	= [5.95,gt2,2.5,true, 5.00,1.1,1.1,8.0,"Gt2 idler w/teeth 20"]; 
Gt2Idler20nt= [6.00,gt2,2.5,false,6.00,1.1,1.1,8.0,"Gt2 idler wo/teeth 20"]; 

function idlerWidth(pulley) = pulley[forBelt][width];
function idlerHeight(pulley) = idlerWidth(pulley)+pulley[flangeBotHeight]+pulley[flangeTopHeight];
module thePulley(pulley) {
	difference() {
		union() {
			cylinder(r=pulley[baseRadius],h=idlerWidth(pulley)+pulley[flangeBotHeight]);
			cylinder(r=pulley[flangeRadius],h=pulley[flangeBotHeight]);
			translate([0,0,idlerWidth(pulley)+pulley[flangeBotHeight]]) cylinder(r=pulley[flangeRadius],h=pulley[flangeTopHeight]);
		}
		translate([0,0,-0.1]) cylinder(r=pulley[holeRadius],h=idlerHeight(pulley)+0.2);
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