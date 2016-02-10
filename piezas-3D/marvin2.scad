$fn=500;

/********************************** MOTOR ************************************************/



module caja_motor(){
	hull(){
		translate([-2.3,0,0])
			cube([12.6,20,0.1]);
		translate([-0.3,0,10.3])
			cube([8.6,20,0.1]);
		translate([2.75,10,5.3])
			rotate([90,0,0])
				cylinder(r=5.1, h= 20, center=true);
		translate([5.25,10,5.3])
			rotate([90,0,0])
				cylinder(r=5.1, h= 20, center=true);
	}
	translate([-2.3,-9,0])
		cube([12.6,9,10.4]);
	translate([4,-14,5])
		rotate([90,0,0])
				cylinder(r=3/2, h= 10, center=true);
}


module motor(){
	difference(){
		caja_motor();
		translate([4,-14.01,7.4])
			rotate([90,0,0])
				cube([3,3,10], center =true);
	}

}

//motor();

/********************************* PORTAPILAS *****************************/

module pilas(){
		translate([0,9,-19.5])
			cube([57.5,32,16.5]);
	
}

module estructura_pilas(){
	difference(){
		translate([-7,0,-3])
			cube([71.5,50,3]);
		translate([12,12.5,-3.1])
			cube([22.5,10,3.2]);
		translate([12,27.5,-3.1])
			cube([22.5,10,3.2]);
		translate([1.5,10.5,-3.1])
			cube([9.5,29,3.2]);
		translate([1.5,1.5,-3.1])
			cube([6.5,47,3.2]);
		translate([38.5,1.5,-3.1])
			cube([13.5,47,3.2]);
		translate([56,1.5,-3.1])
			cube([4.5,47,3.2]);

		translate([12,d_tornilloY,-3.1])	
			rotate([0,0,30])
				cylinder(r =3.6/2, h= 8);
		translate([34,d_tornilloY,-3.1])	
			rotate([0,0,30])
				cylinder(r =3.6/2, h= 8);
		translate([12,height_placa-d_tornilloY,-3.1])
			cylinder(r =3.6/2, h= 8);
		translate([34,height_placa-d_tornilloY,-3.1])
			cylinder(r =3.6/2, h= 8);

		translate([28.75,25,-1.5])
			cylinder(r =3/2, h= 5, center= true);
		translate([21.75,25,-1.5])
			cylinder(r =3/2, h= 5, center= true);
		translate([35.75,25,-1.5])
			cylinder(r =3/2, h= 5, center= true);
	

}


}

/************************************ RUEDA ***********************************************/

//-- Wheel parameters
wheel_or_idiam = 51;                   //-- O-ring inner diameter
wheel_or_diam = 3;                     //-- O-ring section diameter
wheel_height = 2*wheel_or_diam+0;     //-- Wheel height: change the 0 for 
                                      //-- other value (0 equals minimun height)
//-- Parameters common to all horns
horn_drill_diam = 0;
horn_height = 15;        //-- Total height: shaft + plate
horn_plate_height =2;  //-- plate height

module raw_wheel(or_idiam=50, or_diam=3, h=6)
{
   //-- Wheel parameters
   r = or_idiam/2 + or_diam;   //-- Radius

  //-- Temporal points
  l = or_diam*sqrt(2)/2;

  difference() {
    //-- Body of the wheel
    cylinder (r=r, h=h, $fn=100,center=true);

    //--  wheel's inner section
    rotate_extrude($fn=100)
      translate([r-or_diam/2,0,0])
      polygon( [ [0,0],[l,l],[l,-l] ] , [ [0,1,2] ]);
  }
}

module rueda(){
	difference(){
		translate([0,-12.5,0])
			rotate([90,0,0])
				raw_wheel();
		translate([-4,0,-5])
			motor();
	}
}


/********************************** PLACA *************************************************/


/*[ PLACA ]*/
longuitud_placa = 99.06;
height_placa = 50;
anchura_placa = 2;

module placa(){
	cube([longuitud_placa, height_placa, anchura_placa]);
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

/******************************************************************************************* BALL CASTER ***********************************************************************************************/
ballcaster_x = longuitud_placa -10;
ballcaster_y = height_placa/2;
ballcaster_z = 0;

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

/******************************** ESTRUCTURA ***********************************/

d_tornilloY = 6;

module base_estructura(){
	translate([8,0,anchura_placa])	
		cube([30,12,12.4]);
 	
	translate([8,height_placa-12,anchura_placa])	
		cube([30,12,12.4]);

}

module estructura(){
	difference(){
		base_estructura();
		translate([18.8,0,anchura_placa])	
			motor();
		translate([18.8,height_placa,anchura_placa])
			mirror([0,1,0])
				motor();
		translate([12,d_tornilloY,anchura_placa-0.1])	
			rotate([0,0,30])
				cylinder(r= 6.55/2 , 2.5 ,$fn=6);
		translate([34,d_tornilloY,anchura_placa-0.1])	
			rotate([0,0,30])
				cylinder(r= 6.55/2 , 2.5 ,$fn=6);
		translate([12,height_placa-d_tornilloY,anchura_placa-0.1])
			rotate([0,0,30])
				cylinder(r= 6.55/2 , 2.5 ,$fn=6);
		translate([34,height_placa-d_tornilloY,anchura_placa-0.1])
			rotate([0,0,30])
				cylinder(r= 6.55/2 , 2.5 ,$fn=6);

		translate([12,d_tornilloY,anchura_placa-0.1])	
			rotate([0,0,30])
				cylinder(r =3.6/2, h= 8);
		translate([34,d_tornilloY,anchura_placa-0.1])	
			rotate([0,0,30])
				cylinder(r =3.6/2, h= 8);
		translate([12,height_placa-d_tornilloY,anchura_placa-0.1])
			cylinder(r =3.6/2, h= 8);
		translate([34,height_placa-d_tornilloY,anchura_placa-0.1])
			cylinder(r =3.6/2, h= 8);


	}

}





/******************************** UNION *********************************************/

module marvin(){
		cube([longuitud_placa, height_placa, anchura_placa]);
	placa();
	//rotate([180,0,0])
		//color([0,0.6,0])
			//ballcaster3();
	translate([19,0,anchura_placa])	
		//color([0,0.6,0])
			motor();
	translate([19,height_placa,anchura_placa])
		mirror([0,1,0])
			//color([0,0.6,0])
				motor();
	translate([23,0,anchura_placa+5])	
			rueda();
	translate([23,height_placa+25,anchura_placa+5])
			rueda();
	sensor();
	sensor2();

}

marvin();
//rotate([180,0,0])
estructura();
%pilas();
color([0,1,0,1])
estructura_pilas();
