$fn=250;
difference(){
	cylinder(r= 13/2 , 3.2);
	translate([0,0,0.8])
	cylinder(r= 6.6/2 , 2.5 ,$fn=6);
}
