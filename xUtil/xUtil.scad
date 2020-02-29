
function array_set(v, idx, val) = [ for (i = [0:len(v)-1]) i == idx ? val : v[i] ];

function nnv(v, d) = v ? v : d;

module colorize(colour, onlyIf=true) {
	if (onlyIf && colour)
		color(colour) children();
	else
		children();
}