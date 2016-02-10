#define BUMPER_L 2
#define BUMPER_R 3
#define SWITCH_L 4
#define SWITCH_R 5
#define SERVO_L 6
#define SERVO_R 7
#define ECHO 8
#define TRIGGER 9
#define SPEAKER 10
#define TX 11
#define RX 12
#define LED 13
#define LDR_L A0
#define LDR_R A1
#define CNY70_L_L A2
#define CNY70_C_L A3
#define CNY70_C_R A4
#define CNY70_R_R A5


#define PULSO() digitalWrite (TRIGGER, HIGH); delayMicroseconds(10); digitalWrite(TRIGGER, LOW); 
#define SAFE_DISTANCE 20
#define TOLERANCE_LIGHT 1000

#define VALUE 0


#include <Servo.h>

Servo servo_l, servo_r;


//Prototipos
void move_forward();
int distance();
void turn_right(boolean right);
void crazymove();
void dontcrash();
void followlines();
void followlights();


void setup(){
  pinMode(BUMPER_L, INPUT_PULLUP);
  pinMode(BUMPER_R, INPUT_PULLUP);
  pinMode(SWITCH_L, INPUT_PULLUP);
  pinMode(SWITCH_R, INPUT_PULLUP);
  servo_l.attach(SERVO_L);
  servo_r.attach(SERVO_R);
  pinMode(ECHO, INPUT);
  pinMode(TRIGGER, OUTPUT);
  pinMode(SPEAKER, OUTPUT);
  pinMode(TX, OUTPUT);
  pinMode(RX, INPUT);
  pinMode(LED, OUTPUT);
  pinMode(LDR_L, INPUT);
  pinMode(LDR_R, INPUT);
  pinMode(CNY70_L_L, INPUT);
  pinMode(CNY70_C_L, INPUT);
  pinMode(CNY70_C_R, INPUT);
  pinMode(CNY70_R_R, INPUT);
  
}

void loop(){
  
  switch (VALUE){
    case 1:
      crazymove();
      break;
    case 2:
      dontcrash();
      break;
    case 3:
      followlines();
      break;
    case 4:
      followlights();
      break;
    default:
      digitalWrite(LED, HIGH);
      delay(500);
      digitalWrite(LED, LOW);
      delay(500);
  }
      


}
