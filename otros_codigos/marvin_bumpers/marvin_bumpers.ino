#define LED 13
#define BUMPER_I 2
#define BUMPER_D 3
#define SWITCH_I 4
#define SWITCH_D 5
#define SPEAKER 10
#define LDR_I A0
#define LDR_D A1

// the setup routine runs once when you press reset:
void setup() {                
  // initialize the digital pin as an output.
  pinMode(LED, OUTPUT);
  pinMode(SPEAKER, OUTPUT);
  pinMode(BUMPER_I, INPUT);
  //pinMode(BUMPER_D, INPUT_PULLUP);
//  pinMode(SWITCH_I, INPUT);
//  pinMode(SWITCH_D, INPUT);
//  pinMode( LDR_I, INPUT);
//  pinMode( LDR_D, INPUT);
}

// the loop routine runs over and over again forever:
void loop() {
//  analogWrite(LED, analogRead(LDR_I));
//  tone(SPEAKER, analogRead(LDR_D), 500);
  if( digitalRead(BUMPER_I) == LOW){
      digitalWrite(LED, HIGH);   // turn the LED on (HIGH is the voltage level)
    delay(1000);               // wait for a second
    digitalWrite(LED, LOW);    // turn the LED off by making the voltage LOW
    delay(1000);               // wait for a second
  }
//  
//  if( digitalRead(BUMPER_D) == LOW){
//    digitalWrite(LED, HIGH);   // turn the LED on (HIGH is the voltage level)
//    delay(200);               // wait for a second
//    digitalWrite(LED, LOW);    // turn the LED off by making the voltage LOW
//    delay(200);   
//  }
//  if( digitalRead(SWITCH_I) == HIGH){
//    tone(SPEAKER, 350, 500);
//  }
//  
//  if( digitalRead(SWITCH_D) == HIGH){
//    tone(SPEAKER, 550, 500);
//  }
   
}
