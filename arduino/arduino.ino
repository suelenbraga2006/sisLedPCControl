#include <Adafruit_NeoPixel.h>
#define PIN 6
#define NUM_LEDS 53
#define LUMIEFE 100

Adafruit_NeoPixel strip = Adafruit_NeoPixel(NUM_LEDS, PIN, NEO_GRB + NEO_KHZ800);

String readString;
int efeito = 0;
int R=0,G=0,B=255,L=100;
uint16_t color;
uint16_t troca;
uint16_t troca2;

void setup() {
  Serial.begin(9600);
  strip.begin();
  strip.show(); // Initialize all pixels to 'off'
}

// *** REPLACE FROM HERE ***
void loop() { 
 chamaEfeito(efeito);
}

void serialEvent(){
  if (Serial.available()){
    char c = Serial.read();  //gets one byte from serial buffer
    if (c == '!') {
      if(readString.length() == 1){
        efeito = readString.toInt();
        Serial.println("Efeito ativado!");
        chamaEfeito(efeito);
      }else{
        efeito = 0;
        int commaIndex = readString.indexOf(',');
        //  Search for the next comma just after the first
        int secondCommaIndex = readString.indexOf(',', commaIndex+1);
        int thirdCommaIndex = readString.indexOf(',', secondCommaIndex+1);

        String firstValue = readString.substring(0, commaIndex);
        String secondValue = readString.substring(commaIndex+1, secondCommaIndex);
        String thirdValue = readString.substring(secondCommaIndex+1, thirdCommaIndex);
        String fourthValue = readString.substring(thirdCommaIndex+1); // To the end of the string

        R = firstValue.toInt();
        G = secondValue.toInt();
        B = thirdValue.toInt();
        L = fourthValue.toInt();

        Serial.println("Efeito ativado!");
        
        chamaEfeito(efeito);
      }
      readString=""; //clears variable for new input     
     } 
    else {     
      readString += c; //makes the string readString
    }
  }
}

void chamaEfeito(int efe){
  switch (efe) {
          case 0:
            singleColor(R,G,B,L);
            break;
          case 1:
          if(color>=256)color=0;
            rainbowCycle(20);
            break;
          case 2:
            theaterChase(0,128,255,50);
            break;
          case 3:
            Twinkle(0, 0, 0xff, 8, 100, false);
            break;
          case 4:
            TwinkleRandom(8, 100, false);
            break;
          case 5:
            if(troca2 < 3){
              if(color>=255)troca=1;
              if(color<=0){troca=0; troca2=troca2+1;}
              RGBLoop();
            }else{
              troca2=0;  
            }
            break;
          case 6:
            if(color>255)troca=1;
            if(color<10)troca=0;
            FadeInOut(0x00, 0x00, 0xff);
            break;
          }  
}

void singleColor(int red, int green, int blue, int lumi){
  for(int d = 0; d < NUM_LEDS; d++) { 
    strip.setPixelColor(d,red,green,blue);
    strip.setBrightness(lumi);
    strip.show();
  }  
}

void FadeInOut(byte red, byte green, byte blue){
  float r, g, b;
      
  //for(int k = 0; k < 256; k=k+1) {
  if(color < 256){ 
    r = (color/256.0)*red;
    g = (color/256.0)*green;
    b = (color/256.0)*blue;
    setAll(r,g,b);
    showStrip();
    color=color+1;
  }
     
  //for(int k = 255; k >= 0; k=k-2) {
  if(troca == 1){
    r = (color/256.0)*red;
    g = (color/256.0)*green;
    b = (color/256.0)*blue;
    setAll(r,g,b);
    showStrip();
    color=color-2;
  }
}

void RGBLoop(){
  //for(int j = 0; j < 3; j++ ) { 
    // Fade IN
    //for(int k = 0; k < 256; k++) { 
    if((color < 256)&&(troca==0)){
      switch(troca2) { 
        case 0: setAll(color,0,0); break;
        case 1: setAll(0,color,0); break;
        case 2: setAll(0,0,color); break;
      }
      showStrip();
      delay(3);
      color=color+1;
    }
    // Fade OUT
    //for(int k = 255; k >= 0; k--) { 
    if(troca==1){
      switch(troca2) { 
        case 0: setAll(color,0,0); break;
        case 1: setAll(0,color,0); break;
        case 2: setAll(0,0,color); break;
      }
      showStrip();
      delay(3);
      color=color-1;
    }
  //}
}

void TwinkleRandom(int Count, int SpeedDelay, boolean OnlyOne) {
  setAll(0,0,0);
  
  for (int i=0; i<Count; i++) {
     setPixel(random(NUM_LEDS),random(0,255),random(0,255),random(0,255));
     showStrip();
     delay(SpeedDelay);
     if(OnlyOne) { 
       setAll(0,0,0); 
     }
   }
  
  delay(SpeedDelay);
}

void Twinkle(byte red, byte green, byte blue, int Count, int SpeedDelay, boolean OnlyOne) {
  setAll(0,0,0);
  
  for (int i=0; i<Count; i++) {
     setPixel(random(NUM_LEDS),red,green,blue);
     showStrip();
     delay(SpeedDelay);
     if(OnlyOne) { 
       setAll(0,0,0); 
     }
   }
  
  delay(SpeedDelay);
}

void theaterChase(byte red, byte green, byte blue, int SpeedDelay) {
  for (int j=0; j<10; j++) {  //do 10 cycles of chasing
    for (int q=0; q < 3; q++) {
      for (int i=0; i < NUM_LEDS; i=i+3) {
        setPixel(i+q, red, green, blue);    //turn every third pixel on
      }
      showStrip();
     
      delay(SpeedDelay);
     
      for (int i=0; i < NUM_LEDS; i=i+3) {
        setPixel(i+q, 0,0,0);        //turn every third pixel off
      }
    }
  }
}

void rainbowCycle(int SpeedDelay) {
  byte *c;
  uint16_t i, j;

  //for(j=0; j<256*5; j++) { // 5 cycles of all colors on wheel
  if(color < 256){
    for(i=0; i< NUM_LEDS; i++) {
      c=Wheel(((i * 256 / NUM_LEDS) + color) & 255);
      setPixel(i, *c, *(c+1), *(c+2));
    }
    showStrip();
    delay(SpeedDelay);
    color=color+1;
  }
}

byte * Wheel(byte WheelPos) {
  static byte c[3];
  
  if(WheelPos < 85) {
   c[0]=WheelPos * 3;
   c[1]=255 - WheelPos * 3;
   c[2]=0;
  } else if(WheelPos < 170) {
   WheelPos -= 85;
   c[0]=255 - WheelPos * 3;
   c[1]=0;
   c[2]=WheelPos * 3;
  } else {
   WheelPos -= 170;
   c[0]=0;
   c[1]=WheelPos * 3;
   c[2]=255 - WheelPos * 3;
  }

  return c;
}

void showStrip() {
 #ifdef ADAFRUIT_NEOPIXEL_H 
   // NeoPixel
   strip.setBrightness(LUMIEFE);
   strip.show();
 #endif
 #ifndef ADAFRUIT_NEOPIXEL_H
   // FastLED
   FastLED.show();
 #endif
}

void setPixel(int Pixel, byte red, byte green, byte blue) {
 #ifdef ADAFRUIT_NEOPIXEL_H 
   // NeoPixel
   strip.setPixelColor(Pixel, strip.Color(red, green, blue));
 #endif
 #ifndef ADAFRUIT_NEOPIXEL_H 
   // FastLED
   leds[Pixel].r = red;
   leds[Pixel].g = green;
   leds[Pixel].b = blue;
 #endif
}

void setAll(byte red, byte green, byte blue) {
  for(int i = 0; i < NUM_LEDS; i++ ) {
    setPixel(i, red, green, blue); 
  }
  showStrip();
}
