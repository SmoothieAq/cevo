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

module myModel() {
	cube([10,14,18]);
}
/*
$camera = camera(fps=2, points= [
	cpoint( cameraAbsolute=[100,100,70], speed=50 ),
	cpoint( openScad=[5,[2,3,4],[5,6,7]]),
	cpoint( cameraUp=40, viewAtLeft=20, time=3 ),
]);

$vpd = $camera[0];
$vpr = $camera[1];
$vpt = $camera[2];

view($camera) myModel();
*/

_cameraAbsolute_ = 0;
_cameraTranslate_ = 1;
_cameraRotate_ = 2;
_viewAtAbsolute_ = 3;
_viewAtTranslate_ = 4;
_viewAtRotate_ = 5;
_zoom_ = 6;
_speed_ = 7;
_time_ = 8;
_pname_ = 9;
function cpoint(cameraAbsolute,cameraTranslate,cameraRotate,viewAtAbsolute,viewAtTranslate,viewAtRotate,zoom,speed,time,pname) =
	[cameraAbsolute,cameraTranslate,cameraRotate,viewAtAbsolute,viewAtTranslate,viewAtRotate,zoom,speed,time,pname];

function camera(points,fps=2,t=$t) = [];

function cameraPoints(points) = [ for (i = 0, p = points[0][_cameraAbsolute_]; i < len(points); i = i+1, p = cameraMove(p,points[i])) p ];

*crLines( cameraPoints(points=[
	cpoint(cameraAbsolute=[110,110,210]),
	cpoint(cameraTranslate=[-50,-50,-175]),
	cpoint(cameraAbsolute=[0,30,-10]),
	cpoint(cameraTranslate=[70,35,140]),
	cpoint(cameraAbsolute=[45,65,95])
]));


p0 = [100,100,200];
p1 = [50,30,25];
p2 = [-10,20,-20];
p3 = [60,55,120];
p4 = [45,65,95];
ps = [p0,p1,p2,p3,p4];

color("blue") myModel();

color("red")
	for (p = ps) translate(p) cube(1,center=true);

color("pink",0.3) for (i = [0:len(ps)-2]) line(ps[i],ps[i+1]);

// Catmull-Rom Spline after http://www.cs.cmu.edu/~jkh/462_s07/08_curves_splines_part2.pdf
s = 0.5;
crBasis = [
	[ -s, 2-s, s-2, s ],
	[ 2*s, s-3, 3-2*s, -s ],
	[ -s, 0, s, 0 ],
	[ 0, 1, 0, 0]
];
function crSplineM(p0,p1,p2,p3) = crBasis*[p0,p1,p2,p3];
function crSplineT(m,u) = [pow(u,3),pow(u,2),u,1]*m;

function crPoints(m,n) = [ for (i = [0:n]) crSplineT(m,i/n) ];
module crLine(crPoints) color("green",0.3) for (i = [0:len(crPoints)-2]) { *echo(i); line(crPoints[i],crPoints[i+1]); }

module crLines(ps) {
	for (i = [0:len(ps)-2])
		if (i == 0) crLine(crPoints(crSplineM(ps[i], ps[i], ps[i+1], ps[i+2]), 20));
		else if (i == len(ps)-2) crLine(crPoints(crSplineM(ps[i-1], ps[i], ps[i+1], ps[i+1]), 20));
		else crLine(crPoints(crSplineM(ps[i-1], ps[i], ps[i+1], ps[i+2]), 20));
}
crLines(ps);

// after http://forum.openscad.org/Rods-between-3D-points-td13104.html
module line(p0,p1) {
	dir = p1-p0;
	h   = norm(dir);
	if(dir[0] == 0 && dir[1] == 0) {
		// no transformation necessary
		cylinder(r=0.2, h=h);
	} else {
		w  = dir / h; *echo(p0=p0,p1=p1,dir=dir,h=h,w=w);
		u0 = cross(w, [0,0,1]);
		u  = u0 / norm(u0);
		v0 = cross(w, u);
		v  = v0 / norm(v0);
		multmatrix(m=[[u[0], v[0], w[0], p0[0]],
		[u[1], v[1], w[1], p0[1]],
		[u[2], v[2], w[2], p0[2]],
		[0,    0,    0,    1]])
			cylinder(r=0.2, h=h);
	}
}

// posFunc: timeInSegment -> pos

// camera segment [startTime,duration,posFunc]
//