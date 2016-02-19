

#define PULSO() digitalWrite (TRIGGER, HIGH); delayMicroseconds(10); digitalWrite(TRIGGER, LOW);
#define ECHO 8
#define TRIGGER 9
#define LED 13

void setup(){
  pinMode( TRIGGER, OUTPUT);
  pinMode(LED, OUTPUT);
  Serial.begin(115200);

}

void loop(){
  unsigned int tiempo, distancia;
  PULSO();
  tiempo = pulseIn(ECHO, HIGH);
  distancia = tiempo/58;
  Serial.println(distancia);
  delay(100);

}
  
  

