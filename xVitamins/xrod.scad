
include <../xNopSCADlib/core.scad>

use <NopSCADlib/vitamins/rod.scad>
use <../xNopSCADlib/vitamins/carbon_tube.scad>
use <../xUtil/xUtil.scad>

function xrod_material(type)	= type[1];
function xrod_diameter(type)	= type[2];
function xrod_inner_diameter(type) = type[3];
function xrod_length(type)		= type[4];

function xrod_material_name(material) = material == RodSteel ? "Rod Steel" : material == RodCarbonTube ? "Carbon tube" : "?";

function axrod(material, d, id, l) = [xrod_material_name(material), material, d, id, l];
function axSteelRod(d, l) = axrod(RodSteel, d=d, l=l);
function axCarbonTube(od, id, l) = axrod(RodCarbonTube, d=od, id=nnv(id,od-1), l=l);
function axrod_setlen(type, l) = array_set(type, 4, l);

module xrod(type, l) {
	length = nnv(l, xrod_length(type));
	if (xrod_material(type) == RodCarbonTube)
		carbon_tube(xrod_diameter(type), xrod_inner_diameter(type), length);
	else
		rod(xrod_diameter(type), length);
}

