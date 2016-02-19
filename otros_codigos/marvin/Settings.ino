

// Funcion que sirve para cargar el programa que queramos de la
// lista de seleccionados.
void load_program(){
  static boolean clock = LOW;
  unsigned int load_position = 0;
  static unsigned long wait = millis();
  unsigned int time_wait = 500, time_signal =50;
  
  
  while( load_position < 4){
    unsigned int margin = 120;
    
    straight_slow();
    
    if( (analogRead(CNY_LL) >= black[0] - margin) && clock == LOW) {
      //if(millis() - wait > time_signal){
        //wait = millis();
        clock = HIGH;
        delay(100);
      
        if( analogRead(CNY_RR) >= black[3] - margin){
          tone(SPEAKER, 1000,300);
          load_bit[load_position] =  HIGH;
          Serial.print("HIGH en: ");
          Serial.println(load_position);
        
        
        }else if( analogRead(CNY_RR) <= black[3] - margin) {
          tone(SPEAKER, 1000,100);
          load_bit[load_position] =  LOW;
          Serial.print("LOW en: ");
          Serial.println(load_position);
        }
        
      //}
    
      
    }else if ( (analogRead(CNY_LL) < black[0] - margin) && clock == HIGH){
      //if(millis() - wait > time_wait){
        //wait=millis();
        clock = LOW;
        load_position++;
        delay(100);
      //}
    }

  }
  motionless();
  delay(200);
  
  for(int i=0; i<4; i++){
    if(load_bit[i] == HIGH){
      tone(SPEAKER, 1000,300);
      delay(300);
    }else{
      tone(SPEAKER, 1000,100);
      delay(100);
    }
  }
  delay(200);

}





//Funcion para grabar en la EEPROM los valores del blanco y el negro para cada sensor CNY_70
void set_cny(){
  unsigned int black_temp[4], white_temp[4];
  for( int i = 0 ; i < 5; i++){
    digitalWrite(LED,HIGH);
    delay(200);
    digitalWrite(LED,LOW);
    delay(200);
  }
  white_temp[0] = analogRead(CNY_LL);
  white_temp[1] = analogRead(CNY_L);
  white_temp[2] = analogRead(CNY_R);
  white_temp[3] = analogRead(CNY_RR);
  
  for(int i=0; i<4 ; i++){
    int j=i*2;
  EEPROM.write(j, highByte (white_temp[i]) );
  EEPROM.write(j+1, lowByte (white_temp[i]) );
  
  }

  straight();
  delay(3000);
  motionless();

  for( int i= 0 ; i < 5; i++){
    digitalWrite(LED,HIGH);
    delay(200);
    digitalWrite(LED,LOW);
    delay(200);
  }
  
  black_temp[0] = analogRead(CNY_LL);
  black_temp[1] = analogRead(CNY_L);
  black_temp[2] = analogRead(CNY_R);
  black_temp[3] = analogRead(CNY_RR);

for(int i=0; i<4 ; i++){
    int j=i*2 + 8;
  EEPROM.write(j , highByte (black_temp[i]) );
  EEPROM.write(j+1, lowByte (black_temp[i]) );
  
  }
}



void calibrate(){
  int margin = 120;
  //static byte last_state = STATE_STRAIGHT;
  //static unsigned int velocity_r = 1135, velocity_l = 1710;
  boolean calibrate = false;
  byte counter_r = 0, counter_l = 0;
  unsigned int read_cny_ll, read_cny_l, read_cny_r, read_cny_rr;

  
  
  while( calibrate == false){
    
    read_cny_ll = analogRead(CNY_LL);
    read_cny_l = analogRead(CNY_L);
    read_cny_r = analogRead(CNY_R);
    read_cny_rr = analogRead(CNY_RR);
    
    delay(20);
  
    if( (read_cny_ll >= black[0] - margin) && (read_cny_l >= black[1] - margin) && (read_cny_r >= black[2] - margin) && (read_cny_rr >= black[3] - margin)){
      calibrate = true;
    }
    
  

    // Avanzamos recto si estamos en negro 
    else if( (read_cny_l >= black[1] - margin) && (read_cny_r >= black[2] - margin)){
      if( !attached_servos())
        attach_servos();
      wheel_r.writeMicroseconds(velocity_r);
      wheel_l.writeMicroseconds(velocity_l);
    //last_state = STATE_STRAIGHT;
    //Serial.println("NEGRO");
    }

    // Giramos a la derecha para no salirnos del negro
    else if( (read_cny_l < black[1] - margin) && (read_cny_r >= black[2] - margin) ){
      right_slow();
      velocity_l= velocity_l + 5;
      counter_r++;
      if(counter_r == 2){
        velocity_l--;
        velocity_r++;
        counter_r = 0;
      }
    //last_state = STATE_RIGHT;
    //Serial.println("DERECHA");
    }

    // Giramos a la izquierda para no salirnos del negro
    else if( (read_cny_l >= black[1] - margin) && (read_cny_r < black[2]) - margin){
      left_slow();
      velocity_r = velocity_r -5;
      counter_l++;
      if(counter_r == 2){
        velocity_l++;
        velocity_r--;
        counter_l = 0;
      }
    //last_state = STATE_LEFT;
    //Serial.println("IZQUIERDA");
    }
  }
  
}

