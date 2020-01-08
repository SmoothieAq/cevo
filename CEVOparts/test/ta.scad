
use <tutil.scad>

module tamodule() {
    cube([5, 5, 5]);
}

module cctest() {
    cube([1,1,1]);
}

module ccylinder2(h, r, c1h = 0, c2h = 0, a = 360) {
    //chamferCylinder(h, r, r, chamferHeight = c1h, chamferHeight2 = c2h);
    module cc() {
        if (c1h != 0) cylinder(abs(c1h)+0.001, r-c1h, r);
        translate([0, 0, abs(c1h)]) cylinder(h-abs(c1h)-abs(c2h), r, r);
        if (c2h != 0) translate([0, 0, h-abs(c2h)-0.001]) cylinder(abs(c2h)+0.001, r, r-c2h);
    }
    if (a >= 360 || a <= 0) {
        cc();
    } else {
        difference() {
            cc();
            translate([-r-1, -r-1, -1]) cube([r+1, r*2+2, h+2]);
            rotate([0, 0, -180+min(a, 180)]) translate([-r-1, -r-1, -1]) cube([r+1, r*2+2, h+2]);
        }
        if (a > 180) difference() {
            cc();
            translate([0, -r-1, -1]) cube([r+1, r*2+2, h+2]);
            rotate([0, 0, -360+a]) translate([0, -r-1, -1]) cube([r+1, r*2+2, h+2]);
        }
    }
}
