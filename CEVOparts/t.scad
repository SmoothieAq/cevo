
include <util/standardDefinitions.scad>
include <CEVOdefinitions.scad>
use <xutil/xutil.scad>

ps = [
    xp([10,10,10]),
    xp([20,10,10], nutdepth=1),
    xp([30,10,10], depth=1, nutdepth=-0.3),
    xp([40,10,10], depth=0.5, nutdepth=0.5),
    xp([40,20,10], nutdepth=1.4),
    xp([40,30,10], depth=-0.2, nutdepth=1),
    xp([10,20,0], [180,0,0], thick=10, depth=0, nutdepth=0),
    xp([70,0,10], [90,0,0], thick=10),
    xp([70,10,20], [-90,0,0], thick=10)];
s = xaPartScrew(ps[0]);

difference() {
    union() {
        color([0, 0.7, 0, 0.2]) cube([50, 40, 10]);
        color([0, 0.7, 0, 0.2]) translate([60, 0, 0]) cube([30, 10, 30]);
    }
    for (p=ps) {
        xscrewHole(p, xaPartScrew(p));
        xnutHole(p, xaPartScrew(p));
    }
    #xscrewHole([10,30,10], screw(partMountingScrew,10));
    #xscrewHole([20,30,10], screw(partMountingScrew,10), depth=1);
}
for (p=ps) {
    xscrew(p, xaPartScrew(p));
    xnut(p, xaPartScrew(p));
}
