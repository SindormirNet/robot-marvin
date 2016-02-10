

/* moveforward() Funtion for move Marvin*/

void move_forward(){
  servo_l.write(1);
  servo_r.write(179);
}

void turn_right(boolean right){
  if (right == HIGH){
    servo_l.write(1);
    servo_r.write(1);
  }else{
    servo_l.write(179);
    servo_r.write(179);
  }
}

int distante(){
  unsigned int time, distance;
  PULSO();	
  time = pulseIn(ECHO, HIGH);
  return distance = time/58;
}


/*crazymove() Funtion for a crazy move for Marvin*/

void crazymove(){
  servo_l.write(random(89));
  servo_r.write(random(90,179));
  delay(20);
}



void dontcrash(){
  static unsigned int millisbefore;
  unsigned int gap;
  if(millis() - millisbefore > 100){
    millisbefore = millis();
    gap = distance();
  };
  if( gap < SAFE_DISTANCE)
    turn_right(random(0,1));
  else
    move_forward();

}


void followlines(){
  

}
void followlights(){
  if(digitalRead(LDR_L) && digitalRead(LDR_R) > 3/4*TOLERANCE_LIGHT)
    move_forward();
  else if (digitalRead(LDR_R) > TOLERANCE_LIGHT)
    turn_right(HIGH);
  else if ( digitalRead(LDR_L) > TOLERANCE_LIGHT)
    turn_right(LOW);
}
