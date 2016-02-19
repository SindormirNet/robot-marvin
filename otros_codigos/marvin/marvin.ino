#define BUMPER_L 2
#define BUMPER_R 3
#define SWITCH_L 4
#define SWITCH_R 5

#define ECHO 8
#define TRIGGER 9

#define SPEAKER 10
#define LED 13

#define LDR_L A0
#define LDR_R A1

#define CNY_LL A2
#define CNY_L A3
#define CNY_R A4
#define CNY_RR A5

//Times
#define TIME_BLINKY 1000
#define TIME_CALIBRATE 10000


#define PULSE() digitalWrite (TRIGGER, HIGH); delayMicroseconds(10); digitalWrite(TRIGGER, LOW);

//Libraris
#include <Servo.h>
#include <EEPROM.h>

//Global variables
unsigned int black[4], white[4];
unsigned long time = 0;
static boolean load_bit[]={LOW, LOW, LOW, LOW};
//static unsigned int switch_case = 0;
static unsigned int velocity_r = 1335, velocity_l = 1710;

Servo wheel_l, wheel_r;


void setup(){

  // Activamos todos los pins de Marvin
  pinMode(BUMPER_L, INPUT);
  pinMode(BUMPER_R, INPUT);
  pinMode(SWITCH_L, INPUT);
  pinMode(SWITCH_R, INPUT);
  //
  pinMode( TRIGGER, OUTPUT);

  pinMode(LED, OUTPUT);
  pinMode(SPEAKER, OUTPUT);
  //  
  pinMode(LDR_L, INPUT_PULLUP);
  pinMode(LDR_R, INPUT_PULLUP);
  pinMode(CNY_LL, INPUT);
  pinMode(CNY_L, INPUT);
  pinMode(CNY_R, INPUT);
  pinMode(CNY_RR, INPUT);

  //Activamos los motores
//  wheel_r.attach(6);
//  wheel_l.attach(7);
//  motionless();
  if( digitalRead(SWITCH_R) == HIGH){
    set_cny();
  }
  for(int i=0; i<4; i++){
    int j = i*2;
    white[i] = ( (EEPROM.read(j) << 8) & 0xFFFF) + ((EEPROM.read(j+1) << 0) & 0xFF);
    black[i] = ( (EEPROM.read(j + 8) << 8) & 0xFFFF) + ((EEPROM.read(j+9) << 0) & 0xFF);
  }

  Serial.begin(115200);
  Serial.println("");
  Serial.println("Initial valors");
  Serial.print("Balck: ");
  for( int i=0; i<4;i++){
    Serial.println(", ");
    Serial.print(black[i]);
  }
  Serial.print("White: ");
  for( int i=0; i<4;i++){
    Serial.println(", ");
    Serial.print(white[i]);
  }
  digitalWrite(LED, HIGH);
  delay(1000);
  digitalWrite(LED, LOW);
}

void loop(){
  static unsigned int switch_case = 16;
  
  
//  if( digitalRead(BUMPER_L) == LOW && digitalRead(BUMPER_R) == LOW){
//    motionless();
//    velocity_r = velocity_r - 20;
//    velocity_l = velocity_l + 20;
//    digitalWrite(LED, HIGH);
//    delay(5000);
//    calibrate();
//    digitalWrite(LED, LOW);
//    motionless();
//  }

// follow_lines();

//    if( Serial.available() > 0){
//      char dato = Serial.read();
//      if( dato == 'r'){
//        delay(5);
//        velocity_r = change_velocity();
//      }else if( dato == 'l'){
//        delay(5);
//        velocity_l = change_velocity();
//      }
//    
//    }
    
    
    
  if( digitalRead(BUMPER_L) == LOW && digitalRead(BUMPER_R) == LOW){
  //if( digitalRead(SWITCH_L) == HIGH && digitalRead(SWITCH_R) == HIGH){
    motionless();
    for (int i=0; i < 25; i++){
      digitalWrite(LED, HIGH);
      delay(200);
      digitalWrite(LED, LOW);
    }
    digitalWrite(LED, HIGH);
    load_program();
    switch_case = change_int();
    digitalWrite(LED, LOW);
  }
  
  if( digitalRead(SWITCH_L) == HIGH && digitalRead(SWITCH_R) == HIGH){
    switch_case = 17;
  }
  
  
  
  
  switch ( switch_case) {
    case 0:
      read_bluetooth();
//      if( !attached_servos())
//        attach_servos();
//      wheel_r.writeMicroseconds(velocity_r);
//      wheel_l.writeMicroseconds(velocity_l);
      break;
      
      
    case 1:
      //motionless();
      follow_lights();      
      break;
      
      
    case 2:
      dont_crash(distances());
      break;
      
      
    case 3:
      follow_lines();       
      break;
      
      
    default:
      motionless();

      
      
//    default:
//      if (switch_case != same_switch_case){
//        same_switch_case = switch_case;
//            digitalWrite(SPEAKER, HIGH);
//            delay(1000);
//            digitalWrite(SPEAKER, LOW);
//            delay(1000);
//      }  
  }
      




  if (millis() - time >= 2000){
//    Serial.print("Velocity_r: ");
//    Serial.println(velocity_r);
//    Serial.print("Velocity_l: ");
//    Serial.println(velocity_l);
    
    
     Serial.print("Switch: ");
     Serial.println(switch_case);   
    
      Serial.print("Distancia: ");
      Serial.println(distances());    
    
//    Serial.print("LDR_L: ");
//    Serial.println(analogRead(LDR_L));
//    Serial.print("LDR_R: ");
//    Serial.println(analogRead(LDR_R));
    
//    Serial.print("Swicth_case: ");
//    Serial.println(same_switch_case);
//    Serial.print("CNY_LL: ");
//    Serial.println(analogRead(CNY_LL));
//    Serial.print("CNY_L: ");
//    Serial.println(analogRead(CNY_L));
//    Serial.print("CNY_R: ");
//    Serial.println(analogRead(CNY_R));
//    Serial.print("CNY_RR: ");
//    Serial.println(analogRead(CNY_RR));
//    Serial.println("");
    time = millis();

  }



}









