

void read_bluetooth(){
    String lectura = "";
    
    if(Serial.available() >0){
      
      while(Serial.available()){
        lectura += Serial.read();
        delay(2);
      }
        
      Serial.println(lectura);
      
      lectura=lectura.substring(0,4);
      Serial.println(lectura);
        
      if( lectura == "4848")
        back();
      else if ( lectura == "4849")
        right();
      else if ( lectura == "4948")
        left();
      else if ( lectura == "4949")
        straight();
      else
        motionless();
    }
    

}
