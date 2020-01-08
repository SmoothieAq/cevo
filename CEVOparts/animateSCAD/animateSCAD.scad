/*
camera pos / rel pos; up/down/left/right/front/back/rotatex/rotatey/rotatez/rotateStep
view at object pos / rel pos; up/down/left/right/front/back, distance+vektorzoom
speed/time
accelspline-in / spline-out
fps
start/end
fadein/fadeoutsame as view at object
camera( [  cpoint( cameraAbsolute=[x,y,z], viewAtAbsolute=[x,y,z],zoom=50),  cpoint( name="point2", cameraUp=100, speed=50)] , fps=30) myModel();
move( [  mpoint(visible=false),  mpoint(sync="point2", fadein=true,distance=30),  mpoint(fadeout=true)]) myModel();
 */

rotate([0,0,$t*360])
	cube([10,20,50],center=true);