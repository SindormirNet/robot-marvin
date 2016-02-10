$fn=500;



/*[ PLACA ]*/
longuitud_placa = 99.06;
height_placa = 50;
anchura_placa = 2;






module placa(){
	cube([longuitud_placa, height_placa, anchura_placa]);
}



/********************************************************************************************** SENSOR *************************************************************************************************/

longuitud_sensor = 20;
height_sensor = 44;
anchura_sensor = 1;
sensor_x = longuitud_placa +3;
sensor_y = height_placa/4;
sensor_z = 0;

module sensor(){
	translate([sensor_x, sensor_y -10, sensor_z ]) rotate([0,-90,0]) cube([longuitud_sensor, height_sensor,anchura_sensor]);
	translate([sensor_x, sensor_y , sensor_z +10 ]) rotate([0,90,0]) cylinder(r=14/2, h=12);
	translate([sensor_x, sensor_y + 24, sensor_z +10 ]) rotate([0,90,0]) cylinder(r=14/2, h=12);
	translate([sensor_x -5, (sensor_y -10) + height_sensor/2 + 3*2.54/2 , sensor_z ]) cube([0.5, 0.5, 8]);
	translate([sensor_x -5, (sensor_y -10) + height_sensor/2 + 2.54/2, sensor_z ]) cube([0.5, 0.5, 8]);
	translate([sensor_x -5, (sensor_y -10) + height_sensor/2 - 2.54/2, sensor_z ]) cube([0.5, 0.5, 8]);
	translate([sensor_x -5, (sensor_y -10) + height_sensor/2 - 3*2.54/2,  sensor_z ]) cube([0.5, 0.5, 8]);

	
}

/********************************************************************************************* SENSOR2 *************************************************************************************************/

longuitud_sensor2 = 16;
height_sensor2 = 40;
anchura_sensor2 = 1;

module sensor2(){
	translate([ballcaster_x + 10, ballcaster_y/2 +1.5 ,-3.5]) rotate([90,0,0]) cube([7, 6, 13]);
translate([ballcaster_x +7, ballcaster_y/2 -0.5 -4.5 , -1]) rotate([90,0,0])cube([3, 1, 1]);
translate([ballcaster_x +7, ballcaster_y/2 -0.5 +1.6 , -1]) rotate([90,0,0])cube([3, 1, 1]);
translate([ballcaster_x +7, ballcaster_y/2 -0.5 -9.6 , -1]) rotate([90,0,0])cube([3, 1, 1]);

	translate([ballcaster_x + 10, ballcaster_y/2 + 36.5 ,-3.5]) rotate([90,0,0]) cube([7, 6, 13]);
translate([ballcaster_x +7, ballcaster_y/2 + 36.5 -5.9 , -1]) rotate([90,0,0])cube([3, 1, 1]);
translate([ballcaster_x +7, ballcaster_y/2 + 36.5 -0.4 , -1]) rotate([90,0,0])cube([3, 1, 1]);
translate([ballcaster_x +7, ballcaster_y/2 + 36.5 -11.6 , -1]) rotate([90,0,0])cube([3, 1, 1]);

	
}
/*********************************************************************************************** LDR ***************************************************************************************************/



module LDR(){
intersection(){
	translate([0,-2.5,0])
		rotate([-90,0,0])
				cylinder(r=5/2,h=2.7);
	translate([-5/2,-2.5,-4.5/2])
				cube([5,2.7,4.5]);
}


	translate([0,-2.5,0])
		rotate([-90,0,0])		
			translate([1.8,0,-5.9])
				cylinder(d=0.8,h=6);
	translate([0,-2.5,0])
		rotate([-90,0,0])
			translate([-1.8,0,-5.9])
				cylinder(d=0.8,h=6);

}


/******************************************************************************************* BALL CASTER ***********************************************************************************************/

WallThickness = 2;
//BallSize = 13; te ruim
//BallSize = 12.7; bijna
//BallSize = 12.4;goed
BallSize = 16;
Airgap = .5;
Mount = 3;
TotalHeight = 19; 		//this includes the ball
MountScrewRad = 2;  	//3mm screw
BallProtrude = .30; 	//percentage of ball radius sticking out 
ScrewSpacing = 25;		//spaceing of the mountholes center to center
MountMiddle = false; 	//mount int the center
MountBase = true;		//use mount base 2 holes


cylrad = (BallSize/2) + WallThickness + Airgap;
echo (cylrad);

module ballcaster(){
difference()
{
	union()
	{
		ball_mount ();
		if(MountBase)
		{		
			base();
		}
	}
	if(MountMiddle)
	{
		cylinder(r1 = MountScrewRad, r2 = MountScrewRad, h= TotalHeight,center=true, $fn=30);
		translate([0,0,(TotalHeight-BallSize)/2]) 
		{
			cylinder(r1 = MountScrewRad*2, r2 = MountScrewRad*2, h= TotalHeight, $fn=30);
		}
	}
}
}

module ball_mount ()
{
	difference () 
	{
		cylinder(r1 = cylrad , r2 = cylrad,  TotalHeight - (BallSize*BallProtrude));
	
		translate([0,0,TotalHeight - BallSize/2]) 
		{
			cube(size = [cylrad*2+5, cylrad/2, BallSize*1.25], center = true );
			rotate([0,0,90]) cube(size = [cylrad*2+5, cylrad/2, BallSize*1.25], center = true );
		}
	
		translate([0,0,TotalHeight - (BallSize/2)]) 
		{
			sphere (BallSize/2+Airgap, $fa=5, $fs=0.1);
		}
	}
}
module base()
{
	difference (){
		linear_extrude(height=Mount)
		hull() {
			translate([ScrewSpacing/2,0,0]) {
				circle(  MountScrewRad*3);
			}
			translate([0-ScrewSpacing/2,0,0]) {
				circle( MountScrewRad*3);
			}
			circle( cylrad);
		}
	
		translate([ScrewSpacing/2,0,-1]) {
			#cylinder(r1 = MountScrewRad, r2 = MountScrewRad, h= Mount+2,$fn=30);
		}
		translate([0-ScrewSpacing/2,0,-1]) {
			#cylinder(r1 = MountScrewRad, r2 = MountScrewRad, h= Mount+2,$fn=30);
			
		}
	}
}


/*******************************************************************************************************************************************************************************************************/


battery_x = -27;
battery_y = height_placa/2 - height_battery/2 ;
battery_z = anchura_placa;
ballcaster_x = longuitud_placa -10;
ballcaster_y = height_placa/2;
ballcaster_z = 0;

module robot(){
placa();


}




module baseballcaster(){
	translate([ballcaster_x -13, ballcaster_y, ballcaster_z -1]) rotate([180,0,90]) ballcaster();
	translate([ballcaster_x -13, ballcaster_y, ballcaster_z]) rotate([180,0,90])base();
}

module ballcaster2(){
	
	translate([ballcaster_x -2, ballcaster_y +37/2, ballcaster_z - 15]) cube([12, 6.5, 15]);
	translate([ballcaster_x -2, ballcaster_y -37/2 - 6.5, ballcaster_z - 15]) cube([12, 6.5, 15]);
	translate([76, 12.5, -4 ]) cylinder(r=8/2, h=4);
	translate([76, 37.5, -4 ]) cylinder(r=8/2, h=4);
	
	difference(){	
		translate([85.5, ballcaster_y - 37/2 , -17 ]) cube([13.5,37,17]);
		translate([89.5, ballcaster_y - 37/2 + 1, -23 ])cube([7.8,7.8,24]);
		translate([87.5, ballcaster_y - 37/4  +1, -23 ])cube([7.8,7.8,24]);
		translate([87.5, ballcaster_y + 37/4 -8.5 , -23 ])cube([7.8,7.8,24]);
		translate([89.5, ballcaster_y + 37/2 - 8.5  , -23 ])cube([7.8,7.8,24]);
		translate([sensor_x -7.5, (sensor_y -10) + height_sensor/2 - 12/2 , sensor_z -3]) cube([2.5, 12, 4]);
		translate([ballcaster_x +7, ballcaster_y/2 -0.5 -5.5 , -1]) rotate([90,0,0])cube([5, 5, 5]);
	}

	color("red")difference(){
		translate([78.5, 6.5, -4 ]) cube([7,37,4]);
		translate([78, 8.5, -2 ]) cube([7,33,2.1]);
		
	}
	
	difference(){
		baseballcaster();
		translate([76, 8.5, -2 ]) cube([10,33,2.1]);
		translate([72, 12.5, -2 ]) cube([10,25,2.1]);
	}

}

module ballcaster3(){
	translate([ballcaster_x +7 , ballcaster_y +37/2 +1.5, ballcaster_z -3]) cube([3, 2.8, 3]);
	translate([ballcaster_x +7 , ballcaster_y -37/2 -4.2, ballcaster_z -3]) cube([3, 2.8, 3]);
	translate([ballcaster_x +7.74 , ballcaster_y +37/2 -4, ballcaster_z -3]) cube([2.26, 3, 3]);
	translate([ballcaster_x +7.74 , ballcaster_y -37/2 +1, ballcaster_z -3]) cube([2.26, 3, 3]);
	difference(){
		ballcaster2();
translate([76, 12.5, -8 ]) cylinder(r=4/2, h=8.1);
translate([76, 37.5, -8 ]) cylinder(r=4/2, h=8.1);
		translate([76, 12.5, -4.01 ]) rotate([0,0,90]) cylinder(r= 6.55/2 , 2.5 ,$fn=6);
		translate([76, 37.5, -4.01 ]) rotate([0,0,90]) cylinder(r= 6.55/2 , 2.5 ,$fn=6);
		translate([ballcaster_x +0.5, ballcaster_y +37/2 -6.5, ballcaster_z - 2.1]) cube([10, 12, 3.5]);
		translate([ballcaster_x  +0.5, ballcaster_y -37/2 -5.5, ballcaster_z - 2.1]) cube([10, 12, 3.5]);
translate([ballcaster_x +6, ballcaster_y +37/2 +4.5, ballcaster_z - 2.1]) cube([5, 3, 3.5]);
translate([ballcaster_x +6 , ballcaster_y -37/2 -6.5, ballcaster_z - 2.1]) cube([5, 3, 3.5]);
		translate([ballcaster_x +10 , ballcaster_y -37/2 - 3, ballcaster_z - 11]) rotate([0,0,-90])LDR();
		translate([ballcaster_x +2 , ballcaster_y -37/2 - 5.5, ballcaster_z - 12]) cube([5,5,12]);
		translate([ballcaster_x +10 , ballcaster_y +37/2 + 3, ballcaster_z - 11]) rotate([0,0,-90])LDR();
		translate([ballcaster_x +2 , ballcaster_y +37/2 + 0.5, ballcaster_z - 12]) cube([5,5,12]);
	}
}


%robot();
rotate([180,0,0])ballcaster3();

%sensor();
%sensor2();


