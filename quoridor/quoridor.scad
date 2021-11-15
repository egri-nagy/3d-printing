// Original code: https://github.com/dvoros/3d

// table width
tw=200;
// table height
th=6;
// wall height
wh=24;
// slack
s=0.1;


// number of ditches
dn=6;
// ratio of ditch width to board width
dr=0.15;

// epsilon
e = 0.01;

smoothing=1;

// DITCHES

// width
dw=tw*dr/dn;
echo("ditch width", dw);
// height
dh=th-1;
// distance
fw=tw+dw;
dd=fw/(dn+1);

// WALLS

// width
ww=dw-s;
echo("wall width", ww);
wl=2*dd-dw;

// cell width
cw=dd-dw;
// pawn width
pw=0.8*cw;

//mini_board();
//board();
pawn();
//wall();

module pawn() {
    $fn=60;
    translate([0, 0, th/2])
    union() {
        minkowski(){
            linear_extrude(scale=0.4, height=wh)
        circle(d=pw);
            sphere(smoothing);
        }
        
        translate([0, 0, wh])
        sphere(d=0.8*pw);
    }
}

module wall() {
    minkowski(){
    rotate([0, -90, 0])
    cube(size=[ww-2*smoothing, wl-2*smoothing, wh-2*smoothing]);
    sphere(smoothing);
    }
}

module mini_board() {
    translate([-wl/2 + tw/2, -wl/2 + tw/2, th/2])
    intersection() {
        translate([-tw + wl - e, -tw + wl - e, 0])
        cube(size=tw, center=true);
        
        board();
    }
}

module board() {
    difference() {
        blank_board();
        ditches();
    }
}

module blank_board() {
    minkowski(){
        cube(size=[tw-2*smoothing, tw-2*smoothing, th-2*smoothing], center=true);
        sphere(smoothing);
    }
}

module ditches() {
    sx = -tw/2 -dw/2;
    for (d = [1 : dn]) {
        translate([0, sx + d*dd, dh/2 + e])
        cube(size=[tw+1, dw, th], center=true);
        
        translate([sx + d*dd, 0, dh/2 + e])
        cube(size=[dw, tw+1, th], center=true);
    }
}