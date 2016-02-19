#define STATE_STRAIGHT 0
#define STATE_RIGHT 1
#define STATE_LEFT  2
#define DARK 700
#define TIME_ECHO 100
#define TIME_CRASH 150
#define DISTANCE_SECURITY 10


//Funcion para transformar una array boolean a un su equivalente entero.
unsigned int change_int(){
  unsigned int value = 0;
  for(int i=0; i<4;i++){
    if(load_bit[i] == HIGH)
      value += pow(2,i);
  }
  return value;
}


//void beeps(int number){
//  for( int i=0; i < number +1; i++){
//    digitalWrite(SPEAKER, HIGH);
//    delay(200);
//    digitalWrite(SPEAKER, LOW);
//    delay(200);
//  }
//}



//// Funcion para hacer parpadear el LED sin parar de ejecutar procesos
//void blinky(unsigned int time){
//  static boolean blinky = LOW;
//  static unsigned long time_blinky = 0; 
//  
//  if(millis() - time_blinky >= time && blinky == LOW){
//    digitalWrite(LED,HIGH);
//    blinky = HIGH;
//    time_blinky = millis();
//  }
//  if(millis() - time_blinky >= time && blinky == HIGH){
//    digitalWrite(LED,LOW);
//    blinky = LOW;
//    time_blinky = millis();
//  }
//}


//Funcion para que sigan lineas.
void follow_lines(){
  int margin = 120;
  static byte last_state = STATE_STRAIGHT;
  
  unsigned int read_cny_l = analogRead(CNY_L), read_cny_r = analogRead(CNY_R);
  
  
  // Aqui comprobamos los sensores sigue lineas y actuamos en consecuencia.
  // Si estamos en blanco avanzamos hasta encontrar negro
  if( (read_cny_l < black[1] - margin  ) && (read_cny_r <= black[2] - margin)){
    switch (last_state){
    case 0:
      straight();
      break;
    case 1:
      right();
      break;
    case 2:
      left();
      break;
//    default:
//      back();
//      delay(200);
    }

    //Serial.println("BLANCO");
  }

  // Avanzamos recto si estamos en negro 
  else if( (read_cny_l >= black[1] - margin) && (read_cny_r >= black[2] - margin)){
    straight();
    last_state = STATE_STRAIGHT;
    //Serial.println("NEGRO");
  }

  // Giramos a la derecha para no salirnos del negro
  else if( (read_cny_l < black[1] - margin) && (read_cny_r >= black[2] - margin) ){
    right();
    last_state = STATE_RIGHT;
    //Serial.println("DERECHA");
  }

  // Giramos a la izquierda para no salirnos del negro
  else if( (read_cny_l >= black[1] - margin) && (read_cny_r < black[2]) - margin){
    left();
    last_state = STATE_LEFT;
    //Serial.println("IZQUIERDA");
  }
  
//    if (millis() - time >= 2000){
//    Serial.print("CNY_LL: ");
//    Serial.println(analogRead(CNY_LL));
//    Serial.print("CNY_L: ");
//    Serial.println(analogRead(CNY_L));
//    Serial.print("CNY_R: ");
//    Serial.println(analogRead(CNY_R));
//    Serial.print("CNY_RR: ");
//    Serial.println(analogRead(CNY_RR));
//    Serial.println("");
//    time = millis();

  
}




//Fucion para seguir luces en la oscuridad
void follow_lights(){
  unsigned int read_ldr_l = analogRead(LDR_L), read_ldr_r = analogRead(LDR_R);

  if(read_ldr_l >= DARK && read_ldr_r >= DARK)          straight();
  else if (read_ldr_l < DARK && read_ldr_r >= DARK)     right();
  else if (read_ldr_l >= DARK && read_ldr_r < DARK)     left();
  else                                                  motionless();

}


void dont_crash(long distance){
    static unsigned long time_distance = millis();
    static boolean turn = false;
   
    if(millis() - time_distance > TIME_CRASH){
      time_distance = millis();
      if( turn == false){
      
        if( distance > DISTANCE_SECURITY)
          straight();
        else if( distance <= DISTANCE_SECURITY){
          turn = true;
          back();
          delay(200);
          //motionless();
        }
      }else if( turn == true){ 
        right();
        delay(1400);
        turn = false;
        //motionless();
      }
    }
}


long distances(){
  static unsigned long time_echo = millis();
  static unsigned int time, distance;

  if (millis() - time_echo > TIME_ECHO){
    time_echo = millis();
 
    PULSE();
    time = pulseIn(ECHO, HIGH);
    distance = time/58;
 
  }
  return distance;
}





