#define LED 13
#define PIN 5

// the setup routine runs once when you press reset:
void setup() {                
  // initialize the digital pin as an output.
  pinMode(LED, OUTPUT);
  pinMode(PIN, INPUT);  
  
}

// the loop routine runs over and over again forever:
void loop() {
  if (digitalRead(PIN) == HIGH){
    digitalWrite(LED, HIGH);   // turn the LED on (HIGH is the voltage level)
    delay(1000);               // wait for a second
    digitalWrite(LED, LOW);    // turn the LED off by making the voltage LOW
    delay(1000);              // wait for a second
  } else digitalWrite(LED, HIGH);
}
