
// adapted from https://www.thingiverse.com/thing:2537701


module spiralVaseLinearBearing(
		outerD=15.0, // outer diameter in mm
		innerD=8.0, // inner diameter in mm
		H=23.8, // height in mm
		filament_margin = 0.92, // this is used to trim the inner diameter (mm)
		no_spikes = 10, // number of spikes
		spike_angle = 30, // spike angle
		blade_twist = 30, // twist of blades in deg
		drill = false // drill for pics
	) {

	module spike() {
		difference() {
			rotate ([0,0,0]) translate ([outerD/2-2,0,0]) rotate ([0,0,spike_angle]) 
				cube([7,1.1,H+2], center = true);
			cylinder (r = (innerD+ filament_margin)/2, h = H+2, center = true); 
		}
	}

	module cone() {
		difference (){
			cylinder( d = outerD+5, h = 5, center = true);
			cylinder( d1 = outerD+4,d2=outerD-1,  h = 5, center = true);
		}
	}

	module incone() {
			cylinder( d1 = innerD+ filament_margin+1,d2=innerD+ filament_margin-0.1,  h = 1, center = true);
	}

	difference() {
		union() {
			difference() {
				linear_extrude(height = H, center = true, convexity = 10, twist = blade_twist, slices = 100)
				projection() difference() {
					cylinder (d = outerD, h = H, center = true);
					for ( i = [0 : 360/no_spikes : 360] ) {
					   rotate ([0,0,i]) spike();
					}
				}
				translate([0,0,H/2 -2]) cone();
				translate([0,0,-H/2 +2]) rotate ([180,0,0]) cone();
			}
			translate([0,0,-H/2 +0.5]) incone();
			translate([0,0,H/2 -0.5]) rotate ([180,0,0]) incone();
		}
		if ( drill ) { translate([0,0,-(H/2)-1]) cylinder(H+2,innerD/2,innerD/2); }
	}
}


spiralVaseLinearBearing();

