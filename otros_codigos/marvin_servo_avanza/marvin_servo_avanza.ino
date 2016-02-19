#include <Servo.h>

Servo rueda_izq, rueda_der;

void setup(){
  rueda_izq.attach(7);
  rueda_der.attach(6);
}

void loop(){
  for( int vel= 0; vel <90; vel+=1){
    rueda_izq.write(90 - vel);
    rueda_der.write(90 + vel);
    delay(15);
  }
}
