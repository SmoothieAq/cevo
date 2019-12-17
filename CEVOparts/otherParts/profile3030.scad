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

module extrusion3030( length ) {

    mainsq = 30;
    centersq = 11.64;
    cornersq = (mainsq-16.51)/2;
    flangethick = 2.21;
    flangelen = (mainsq-8.13)/2-cornersq;

     linear_extrude(length) 
        profile(mainsq,centersq,cornersq,flangethick,flangelen);
}

cl = 600;
fl = 420;
sl = 410;

color("grey") {
    
    extrusion3030(cl);
    translate([fl+30,0,0]) extrusion3030(cl);
    translate([0,sl+30,0]) extrusion3030(cl);
    translate([fl+30,sl+30,0]) extrusion3030(cl);

    translate([30,sl+30,cl]) rotate([0,90,0]) extrusion3030(fl);
    translate([30,sl+30,101]) rotate([0,90,0]) extrusion3030(fl);
    translate([30,0,cl-100-30]) rotate([0,90,0]) extrusion3030(fl);
    translate([30,0,101]) rotate([0,90,0]) extrusion3030(fl);

    translate([0,sl+30,cl-30]) rotate([90,0,0]) extrusion3030(sl);
    translate([0,sl+30,cl-100-60]) rotate([90,0,0]) extrusion3030(sl);
    translate([0,sl+30,101-30]) rotate([90,0,0]) extrusion3030(sl);
    translate([fl+30,sl+30,cl-30]) rotate([90,0,0]) extrusion3030(sl);
    translate([fl+30,sl+30,cl-100-60]) rotate([90,0,0]) extrusion3030(sl);
    translate([fl+30,sl+30,101-30]) rotate([90,0,0]) extrusion3030(sl);

    platet = 19;

    difference() {
        translate([3,3,0]) cube([fl+60-6,sl+60-6,platet]);
        translate([3,3,-1]) cube([27.5,27.5,platet+2]);
        translate([fl+30-0.5,3,-1]) cube([27.5,27.5,platet+2]);
        translate([3,sl+30-0.5,-1]) cube([27.5,27.5,platet+2]);
        translate([fl+30-0.5,sl+30-0.5,-1]) cube([27.5,27.5,platet+2]);
    }
}
