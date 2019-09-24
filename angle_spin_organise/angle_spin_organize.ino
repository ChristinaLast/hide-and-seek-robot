// Example on how to read from the gyrometer
// built into the Pololu Zumo 32U4 Arduino-based robot.

#include <Zumo32U4.h>
#include "TurnSensor.h"
#include <Wire.h>

L3G gyro;
Zumo32U4LCD lcd;

Zumo32U4Motors motors;
Zumo32U4ButtonA buttonA;
Zumo32U4ButtonA buttonB;

// --- Helper functions
int32_t getAngle() {
  // turnAngle is a variable defined in TurnSensor.cpp
  // This fancy math converts the number into degrees turned since the
  // last sensor reset.
  return (((int32_t)turnAngle >> 16) * 360) >> 16;
}

int steps;
int value;
int value2;

// --- Setup Method
void setup() {
  buttonA.waitForButton();
  steps = 0;
  Serial.begin(9600);
  turnSensorSetup();
  delay(500);
  turnSensorReset();
  lcd.clear();
  
}


// --- Main program loop
void loop() {
    if(steps == 0){
      turnSensorUpdate();
      int32_t angle = getAngle();
      lcd.gotoXY(0,0);
      lcd.print(angle);
      lcd.print(" ");
      if(angle % 30  == 0){
        //lcd.print("here");
        motors.setRightSpeed(0);
        Serial.write('1');
        delay(2000);
        motors.setRightSpeed(75);
        delay(20);
      }
      else{
        motors.setRightSpeed(75);
      }
      if(angle < -1 && angle > -3){
        steps++;
        motors.setRightSpeed(0);
        for(int i=0; i<5; i++){
          Serial.write('2');
        }
        delay(4000);
      }
    }
    
    if(steps == 1){ 
        if(Serial.available() > 0){
          value = int(Serial.read())-48;
          //value2 = int(char(value));
          lcd.gotoXY(0, 0);
          lcd.print(value);
          lcd.print(" ");
          
          steps++;
        }
    }
    
    if(steps == 2){
      turnSensorUpdate();
      int32_t angle = getAngle();
      if(value < 7){
        if(angle < (value*30) && angle > -5){
            motors.setRightSpeed(75);
            lcd.gotoXY(0, 1);
            lcd.print(angle);
            lcd.print(" ");
            lcd.print(value);
         }
         else {
           motors.setRightSpeed(0);
            lcd.gotoXY(0,2);
            lcd.print("here");
            lcd.print(" ");
           delay(1000);
           steps++;
         }
      }
      else{
        if(angle < 0 && angle > ((value-6)*30*-1)){
          motors.setLeftSpeed(75);
          lcd.gotoXY(0, 1);
          lcd.print(angle);
          lcd.print(" ");
          lcd.print(value);
        }
        else {
           motors.setLeftSpeed(0);
            lcd.gotoXY(0,2);
            lcd.print("here");
            lcd.print(" ");
           delay(1000);
           steps++;
         }
      }
    }
    if(steps == 3){
      for (int speed = 0; speed <= 200; speed++)
      {
        motors.setLeftSpeed(speed);
        motors.setRightSpeed(speed);
        delay(2);
      }
      for(int speed = 200; speed >=0; speed--){
       motors.setLeftSpeed(speed);
       motors.setRightSpeed(speed);
       delay(2);
      }
      ledGreen(1);
      for(int i=0; i<5; i++){
        Serial.write('4');
      }
      delay(4000);
      steps++;
    }
    if(steps == 4){
      ledRed(1);
      buttonB.waitForButton();
      delay(200);
      steps = 0;
      ledRed(0);
      ledGreen(1);
      turnSensorReset();
    }
}

