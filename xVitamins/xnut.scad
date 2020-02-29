
include <../xNopSCADlib/core.scad>

use <NopSCADlib/vitamins/nut.scad>
use <../xUtil/xUtil.scad>

function xnut_nut(type)			= type[1];
function xnut_material(type)	= type[2];
function xnut_nyloc(type)		= type[3];

function axnut(nut, material = MaterialSteel, l, nyloc = false) = [material_name(material), nut, material, nyloc];

module xnut(type, depth = 0, washer = false, twist = 0) {
	nut = xnut_nut(type);

	colorize(material_color(xnut_material(type)))
		translate([0, 0, -depth * nut_thickness(nut, xnut_nyloc(type)) + (washer ? washer_thickness(nut_washer(nut)) : 0)])
			rotate([0, 0, twist])
				nut(nut, xnut_nyloc(type), xnut_material(type) == MaterialBrass, xnut_material(type) == MaterialNylon);
}

module xnut_hole(type, depth = 0, spacing, washer = false, twist = 0) {
	nut = xnut_nut(type);
	thick = nut_thickness(nut, xnut_nyloc(type));
	xspacing = nnv(spacing, thick * 1.2);

	translate([0, 0, -depth * thick])
		if (washer)
			cylinder(r = washer_diameter(nut_washer(nut)), thick);
		else
			rotate([0, 0, twist])
				linear_extrude(height = thickness)
					circle(nut_radius(nut) * 1.05, $fn = 6);
}

module xnut_plate(type, depth = 0, plate, washer = false) {
	nut = xnut_nut(type);
	thick = nut_thickness(nut, xnut_nyloc(type));
	xplate = nnv(plate, thick * 2);
	xheadr = (washer ? washer_diameter(nut_washer(nut)) * 1.05 : nut_radius(nut) * 1.15);

	translate([0, 0, -depth * thick - xplate])
		cylinder(r = xheadr, h = xplate);
}

//include <NopSCADlib/vitamins/nuts.scad>
//
//n = axnut(M3_nut,material=MaterialBlackSteel);
//
//xnut(n,depth=0.7,twist=30);
//difference() {
//	union() {
//		translate([0, 0, -11]) rotate([15,0,0]) cube(18, center = true);
//		xnut_plate(n,depth=0.7);
//	}
//	xnut_hole(n,depth=0.7,twist=30);
//}