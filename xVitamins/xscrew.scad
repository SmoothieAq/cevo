
include <../xNopSCADlib/core.scad>

use <NopSCADlib/vitamins/screw.scad>
use <../xUtil/xUtil.scad>

function xscrew_screw(type)		= type[1];
function xscrew_material(type)	= type[2];
function xscrew_length(type)	= type[3];
function xscrew_hob_point(type)	= type[4];

function axscrew(screw, l, material = MaterialSteel, hob_point = 0) = [material_name(material), screw, material, l, hob_point];
function axscrew_setlen(type, l) = array_set(type, 3, l);

module xscrew(type, l, depth = 0, washer = false) {
	xl = nnv(l, xscrew_length(type));
	hob_point = xscrew_hob_point(type);
	nylon = xscrew_material(type) == MaterialNylon;
	screw = xscrew_screw(type);

	translate([0, 0, -depth * screw_head_height(screw) + (washer ? washer_thickness(screw_washer(screw)) : 0)])
		colorize(material_color(xscrew_material(type)))
			screw(screw, xl, hob_point, nylon);
}

module xscrew_hole(type, l, depth = 0, spacing, washer = false) {
	xl = nnv(l, xscrew_length(type));
	xspacing = nnv(spacing, min(10, xl *.75));
	screw = xscrew_screw(type);
	xheadr = (washer ? washer_diameter(screw_washer(screw)) : screw_head_radius(screw)) * 1.1;

	translate([0, 0, -depth * screw_head_height(screw)])
		cylinder(r = xheadr, h = screw_head_height(screw) + xspacing);
	translate([0, 0, -xl - 0.1])
		cylinder(r = screw_radius(screw), h = xl + 0.2);
}

module xscrew_plate(type, depth = 0, plate, washer = false) {
	screw = xscrew_screw(type);
	xplate = nnv(plate, screw_head_height(screw) * 2);
	xheadr = (washer ? washer_diameter(screw_washer(screw)) * 1.05 : screw_head_radius(screw) * 1.15);

	translate([0, 0, -depth * screw_head_height(screw) - xplate])
		cylinder(r = xheadr, h = xplate);
}

//include <NopSCADlib/vitamins/screws.scad>
//
//s = axscrew(M3_cap_screw,22,material=MaterialBlackSteel);
//
//xscrew(s,depth=0.5);
//difference() {
//	union() {
//		translate([0, 0, -11]) rotate([15,0,0]) cube(18, center = true);
//		xscrew_plate(s,depth=0.5);
//	}
//	xscrew_hole(s,depth=0.5);
//}