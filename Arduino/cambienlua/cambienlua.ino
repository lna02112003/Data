#include <Wire.h>
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x27, 16, 2);  // Địa chỉ I2C và kích thước màn hình

int sensorFire = 2;
int sensorGas = A0;
int coi = 13;
int giatrigas;

void setup() {
  lcd.init();
  lcd.backlight();
  lcd.begin(16, 2);
  pinMode(sensorFire, INPUT);
  pinMode(sensorGas, INPUT);
  pinMode(coi, OUTPUT);
}





void loop() {
  int fireStatus = digitalRead(sensorFire);
  giatrigas = analogRead(sensorGas);

  lcd.clear();
  lcd.setCursor(0, 0);

  if (fireStatus == LOW) {
    digitalWrite(coi, HIGH);
    lcd.print("Fire Detected!");
  }else if (giatrigas > 600) {
    digitalWrite(coi, HIGH);
    lcd.print("Gas Leak Detected!");
  } else {
    digitalWrite(coi, LOW);
    lcd.print("No Fire or Gas");
  }

  delay(1000);
}
