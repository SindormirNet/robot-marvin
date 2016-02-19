boolean attached_servos(){
  if( (wheel_r.attached() ==true) || (wheel_l.attached() == true) )
    return true;
  else
    return false;
}

void detach_servos(){
    wheel_r.detach();
    wheel_l.detach();
    delay(1);
    
}

void attach_servos(){
    wheel_r.attach(6);
    wheel_l.attach(7);
    delay(1);
}



//Funcion para girar a la derecha
void right(){
  if( !attached_servos())
    attach_servos();
//  wheel_r.writeMicroseconds(1445);
//  wheel_l.writeMicroseconds(1455);

  wheel_r.writeMicroseconds(1319);
  wheel_l.writeMicroseconds(1455);
  

  //delayMicroseconds(50);
}

//Funcion para girar a la derecha
void right_slow(){
  if( !attached_servos())
    attach_servos();
  wheel_r.writeMicroseconds(1319);
  wheel_l.writeMicroseconds(1405);
  //delayMicroseconds(50);
}




//Funcion para girar a la izquierda
void left(){
  if( !attached_servos())
    attach_servos();
//  wheel_r.writeMicroseconds(1240);
//  wheel_l.writeMicroseconds(1200);

  wheel_r.writeMicroseconds(1240);
  wheel_l.writeMicroseconds(1309);
  

  //delayMicroseconds(50);
}

//Funcion para girar a la izquierda
void left_slow(){
  if( !attached_servos())
    attach_servos();
  wheel_r.writeMicroseconds(1300);
  wheel_l.writeMicroseconds(1309);
  //delayMicroseconds(50);
}





//Funcion para avanzar recto
void straight(){
  if( !attached_servos())
    attach_servos();
  wheel_r.writeMicroseconds(1075);
  wheel_l.writeMicroseconds(1810);
  //delayMicroseconds(50);
}

void straight_slow(){
  if( !attached_servos())
    attach_servos();
  wheel_r.writeMicroseconds(1270);
  wheel_l.writeMicroseconds(1391);
  //delayMicroseconds(50);
}





//Funcion para ir marcha atras
void back(){
  if( !attached_servos())
    attach_servos();
  wheel_r.writeMicroseconds(1378);
  wheel_l.writeMicroseconds(1290);
  //delayMicroseconds(50);
}

//Funcion para permanecer quieto
void motionless(){
  detach_servos();
  //wheel_r.writeMicroseconds(1319);
  //wheel_l.writeMicroseconds(1339);
  //delayMicroseconds(50);
}




int change_velocity(){
  String velocity = "";
  
  while( Serial.available()){
        velocity += (char) Serial.read();
        delay(5);
  }
  
  return velocity.toInt();
  

}
