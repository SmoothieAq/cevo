use <ta.scad>
use <tstandardDefinitions.scad>

tamodule(); // code completion does not work

t2var = "t2var";

module t2module(t2arg1,t2arg2) {
    echo(t2arg1); // code completions doe not work
    echo(t2var); // code completion does work
    tamodule(); // code completion does not work
    tamodule();tamodule();ccylinder2(); exMountScrewDepth(); profile(); echo(exmainsq);ccube();
}

t2module("a1","a2"); // code completion does work