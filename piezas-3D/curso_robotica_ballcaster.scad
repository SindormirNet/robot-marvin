$fn=500;


/*[ BATEERY ] */
longuitud_battery = 67;
height_battery = 4.6;
anchura_battery = 35;

/*[ PLACA ]*/
longuitud_placa = 100;
height_placa = 50;
anchura_placa = 2;



module battery(){
	cube([longuitud_battery, height_battery, anchura_battery]);
}


module placa(){
	cube([longuitud_placa, height_placa, anchura_placa]);
}


/*
Futaba S3004 servo
Aaron Ciuffo - aaron dot ciuffo 2 gmail

This library produces a fotuaba S3004 futaba servo or a projection for cutting
a hole in a 2D shape for a laser cutter.  

The scale of the projected hole for the body can be adjusted below

It can be used in other models by calling:

  import <futaba_s3004.scad>
  futaba();

The library can also produce a 2D projection that is useful for making a cutout for
a DXF to be used with a laser cutter:
  futaba(project=true)
 
To produce a projection that includes pilot holes for wood screws use:
  futaba(project, bolt=false);




V1 11 November 2014


*/
/*[Setup]*/
$fn=36; //curve refinement

/*[Body Dimensions]*/
bX=40.1;
bY=19.9;
bZ=36;

/*[Flange Dimensions and position]*/
fX=7.4;
fY=17.8;
fZ=2.55;
//flange distance from Base
flangeFromB=26.4;
fBoltDia=4.5;
fBoltRad=fBoltDia/2;
fScrewDia=2.1;
fScrewRad=fScrewDia/2;
fScrewPilot=fScrewRad*.5;

//position from edges
fScrewY=1.7;
fScrewX=0.9;
fScrewZ=7.0;

/*[Shaft Dimensions and Position]*/
shaftDia=6;
shaftRad=shaftDia/2;
shaftZ=6;
shaftX=7.3+shaftRad;
shaftS1=14.4/2;
shaftS2=11.4/2;
shaftSZ=1.8;

/*[Horn Dimensions]*/
hornZ=2.0; 
hornX=38.9;
hornY=hornX;
hornArmX=8.5;
hornRad=5.5/2;

//horn location
hornZoverB=7.8; //height of horn over top of body
hornZoverShaft=hornZoverB-shaftZ; //horn height over shaft



/*[Wire Gland]*/
wireX=2;
wireY=6.5;
wireZ=5.3;


module horn() {
  union() {
    hull() {
      cube([hornX-2*hornRad, hornArmX, hornZ], center=true);
      translate([hornX/2, 0, 0])
        cylinder(h=hornZ, r=hornRad, center=true);
      translate([-hornX/2, 0, 0])
        cylinder(h=hornZ, r=hornRad, center=true);

    }
    
    hull() {
      cube([hornArmX, hornY-2*hornRad, hornZ], center=true);
       translate([0, hornY/2, 0])
        cylinder(h=hornZ, r=hornRad, center=true);
      translate([0, -hornY/2, 0])
        cylinder(h=hornZ, r=hornRad, center=true);
   }
 }
    
  
}

module flange(project=false, bolt=true) {
  fHoleRad= bolt==true ? fBoltRad : fScrewPilot;
  
  if (project==false) {
    difference() {
      cube([fX, fY, fZ], center=true);
      translate([fX/2-fBoltRad-fScrewX, fY/2-fBoltRad-fScrewY, 0])
        cylinder(h=fZ*2, r=fHoleRad, center=true);
      translate([fX/2-fBoltRad-fScrewX, -fY/2+fBoltRad+fScrewY, 0])
        cylinder(h=fZ*2, r=fHoleRad, center=true);
    }
  }

  //leave the cylinders in place for projecting a bolt hole
  if (project==true) {
    translate([fX/2-fScrewRad-fScrewX, fY/2-fScrewRad-fScrewY, 0])
      cylinder(h=fZ*2, r=fScrewRad, center=true);
    translate([fX/2-fScrewRad-fScrewX, -fY/2+fScrewRad+fScrewY, 0])
      cylinder(h=fZ*2, r=fScrewRad, center=true);
  
  }

}


module body(project=false, bolt=true, scalePct=1.05, horn=false) {
  scalePctLoc= project==true ? scalePct : 1;
  union() {
    color("gray")
      scale(scalePctLoc) cube([bX, bY, bZ], center=true);
    color("red")
      translate([bX/2+fX/2, 0, bZ/2-fZ/2-fScrewZ])
        flange(project, bolt);
    color("red")
      translate([-bX/2-fX/2, 0, bZ/2-fZ/2-fScrewZ]) rotate([0, 0, 180])
        flange(project, bolt);
    translate([-bX/2+shaftX, 0, bZ/2]) color("green")
      cylinder(h=shaftZ, r=shaftRad);
    translate([-bX/2+shaftX, 0, bZ/2]) color("blue")
      cylinder(h=shaftSZ, r1=shaftS1, r2=shaftS2);
    color("purple")
      translate([-bX/2-wireX/2, 0, -bZ/2+wireZ/2])
        cube([wireX, wireY, wireZ], center=true);
    if (horn==true) {
      color("yellow")
        translate([-bX/2+shaftX, 0, bZ/2+shaftZ-hornZ/2+hornZoverShaft])
          horn();
    }
  }

}

module futaba(project=false, bolt=true, scalePct, center="main", horn=false) {
  
  //hrn=horn; //WTF?  why do I need this?
  // move everything down to put the horn at the origin
  hornZoffset= horn==true ? hornZoverShaft : 0;

  if (project==true) {
    projection() body(project, bolt, scalePct);
  } else {
    if (center=="shaft") {
      translate([bX/2-shaftX, 0, -bZ/2-shaftZ-hornZoffset])
        body(project, bolt, horn=horn);
    } else if (center=="flange") {
      translate([0, 0, -bZ/2+(bZ-flangeFromB)])
        body(project, bolt, horn=horn);
      
    } else{
      body(project, bolt, horn=horn);
    }
  }
 
}

/********************************************************************************************** WHEEL **************************************************************************************************/

//-- Wheel parameters
wheel_or_idiam = 50;                   //-- O-ring inner diameter
wheel_or_diam = 3;                     //-- O-ring section diameter
wheel_height = 2*wheel_or_diam+0;     //-- Wheel height: change the 0 for 
                                      //-- other value (0 equals minimun height)
//-- Parameters common to all horns
horn_drill_diam = 1.5;
horn_height = 6;        //-- Total height: shaft + plate
horn_plate_height = 2;  //-- plate height

//-- Futaba 3003 4-arm horn parameters
a4h_end_diam = 5;
a4h_center_diam = 10;
a4h_arm_length = 15;
a4h_drill_distance = 13.3;

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

module horn4_arm(h=5)
{
  translate([0,a4h_arm_length-a4h_end_diam/2,0])
  //-- The arm consist of the perimeter of a cylinder and a cube
  hull() {
    cylinder(r=a4h_end_diam/2, h=h, center=true, $fn=20);
    translate([0,1-a4h_arm_length+a4h_end_diam/2,0])
      cube([a4h_center_diam,2,h],center=true);
  }
}

module horn4(h=5)
{
  union() {
    //-- Center part (is a square)
    cube([a4h_center_diam+0.2,a4h_center_diam+0.2,h],center=true);

    //-- Place the 4 arms in every side of the cube
    for ( i = [0 : 3] ) {
      rotate( [0,0,i*90])
      translate([0, a4h_center_diam/2, 0])
      horn4_arm(h);
    }
  }

}

module Servo_wheel_4_arm_horn()
{
  difference() {
      raw_wheel(or_idiam=wheel_or_idiam, or_diam=wheel_or_diam, h=wheel_height);

      //-- Inner drill
      cylinder(center=true, h=2*wheel_height + 10, r=a4h_center_diam/2,$fn=20);

      //-- substract the 4-arm servo horn
      translate([0,0,horn_height-horn_plate_height])
        horn4(h=wheel_height);

      //-- Horn drills
      horn_drills(d=a4h_drill_distance, n=4, h=wheel_height);

  }
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
/*********************************************************************************************** SERVO RUEDA *******************************************************************************************/
futaba1_x = 20;
futaba1_y = 5;
futaba1_z = 10 +anchura_placa;
futaba2_x = 20;
futaba2_y = 45;
futaba2_z = 10 +anchura_placa;
wheel1_x = 11;
wheel1_y = -22;
wheel1_z = 2 + bY/2;
wheel2_x = 11;
wheel2_y = 71.9;
wheel2_z = 2 + bY/2;

module servo_wheel1(){
translate([futaba1_x, futaba1_y, futaba1_z ]) rotate([90,0,0]) futaba(project=false, bolt=true, center="false", horn=true);

translate([wheel1_x, wheel1_y, wheel1_z ]) rotate([270,0,0]) Servo_wheel_4_arm_horn();

}

module servo_wheel2(){

translate([futaba2_x, futaba2_y, futaba2_z ]) rotate([-90,0,0]) futaba(project=false, bolt=true, center="false", horn=true);

translate([wheel2_x, wheel2_y, wheel2_z ]) rotate([90,0,0]) Servo_wheel_4_arm_horn();
}

/*******************************************************************************************************************************************************************************************************/


battery_x = -27;
battery_y = height_placa/2 - height_battery/2 ;
battery_z = anchura_placa;
ballcaster_x = 90;
ballcaster_y = height_placa/2;
ballcaster_z = 0;

module robot(){
placa();
translate([battery_x, battery_y, battery_z ])battery();

translate([0, -0, 0.5 ])servo_wheel1();
translate([0, 0, 0.5 ])servo_wheel2();

translate([ballcaster_x, ballcaster_y, ballcaster_z ]) rotate([180,0,90]) ballcaster();
}



module estructura(){
	difference(){
		translate([-7.6, -3.5, 2 ]) cube([55, 57, fX + bY -7]);
		translate([-7.8, 3, 2 + 10]) cube([56, 44, fX +6]);
		translate([0, -7, 0 ]) cube([bX, 2*flangeFromB +20, bY +10]);
   		robot();
		translate([-8, -2 , 4.4 ]) cube([8, 3.5, 6.5]);
		translate([-8, -2 , 14.4 ]) cube([8, 3.5, 6.5]);
		translate([-8, 48.5 , 4.4 ]) cube([8, 3.5, 6.5]);
		translate([-8, 48.5 , 14.4 ]) cube([8, 3.5, 6.5]);
		translate([bZ +4, -2 , 4.4 ]) cube([8, 3.5, 6.5]);
		translate([bZ +4, -2 , 14.4 ]) cube([8, 3.5, 6.5]);
		translate([bZ +4, 48.5 , 4.4 ]) cube([8, 3.5, 6.5]);
		translate([bZ +4, 48.5 , 14.4 ]) cube([8, 3.5, 6.5]);
		translate([-4.3, 7 , 7.5 ]) rotate([90,0,0])cylinder(r =3.6/2, h= 12);
		translate([-4.3, 0 , 17.4 ]) rotate([90,0,0])cylinder(r =3.6/2, h= 4);
		translate([-4.3, 55 , 7.5 ]) rotate([90,0,0])cylinder(r =3.6/2, h= 12);
		translate([-4.3, 55 , 17.4 ]) rotate([90,0,0])cylinder(r =3.6/2, h= 4);
		translate([bZ +8.3, 7 , 7.5 ]) rotate([90,0,0])cylinder(r =3.6/2, h= 12);
		translate([bZ +8.3, 0 , 17.4 ]) rotate([90,0,0])cylinder(r =3.6/2, h= 4);
		translate([bZ +8.3, 55 , 7.5 ]) rotate([90,0,0])cylinder(r =3.6/2, h= 12);
		translate([bZ +8.3, 55 , 17.4 ]) rotate([90,0,0])cylinder(r =3.6/2, h= 4);
	translate([-4.3, 10 , 0 ]) cylinder(r =3.6/2, h= 15);
	translate([-4.3, 40 , 0 ]) cylinder(r =3.6/2, h= 15);
	translate([bZ +8, 10 , 0 ]) cylinder(r =3.6/2, h= 15);
	translate([bZ +8, 40 , 0 ]) cylinder(r =3.6/2, h= 15);
	translate([-33, height_placa/2 -8 , 8 ]) cube([40, 16, 10]);
	}

	difference(){
		translate([-31, height_placa/2 -6 , 2 ]) cube([30, 12, 10]);
		translate([-33, height_placa/2 -8 , 8 ]) cube([40, 16, 10]);
		robot();
		}	
}



//estructura();
//robot();
ballcaster();
