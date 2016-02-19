#define LED 13
#define CNY_II A2
#define CNY_I A3
#define CNY_D A4
#define CNY_DD A5
#define SPEAKER 10

void setup(){
  pinMode(LED, OUTPUT);
  pinMode(SPEAKER, OUTPUT);
  pinMode(CNY_II, INPUT);
  pinMode(CNY_I, INPUT);
  pinMode(CNY_D, INPUT);
  pinMode(CNY_DD, INPUT);
}

void loop(){
  analogWrite(LED, analogRead(CNY_DD));
  tone(SPEAKER, analogRead(CNY_D));

}
