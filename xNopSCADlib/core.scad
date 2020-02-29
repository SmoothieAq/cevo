
include <NopSCADlib/core.scad>
include <global_defs.scad>

function material_name(material) = ["?","Steel","Steel Black","Nylon","Brass","Aluminium","Carbon","?","?"][material];
function material_color(material) = [undef,grey70,black_screw_colour,grey30,brass,grey50,carbon_colour,undef,undef][material];
