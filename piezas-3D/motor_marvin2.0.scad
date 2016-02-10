$fn=500;


module motor(){

	hull(){
		cube([8,18,0.1]);
		translate([0,0,9.9])
			cube([8,18,0.1]);
		translate([3,9,5])
			rotate([90,0,0])
				cylinder(r=5, h= 18, center=true);
		translate([5,9,5])
			rotate([90,0,0])
				cylinder(r=5, h= 18, center=true);
	}
	translate([-2,-9,0])
		cube([12,9,10]);
	translate([4,-14,5])
		rotate([90,0,0])
				cylinder(r=3/2, h= 10, center=true);



}


module motor2(){
	difference(){
		motor();
		translate([4,-14.01,7.4])
			rotate([90,0,0])
				cube([3,3,10], center =true);

	}

}
motor2();