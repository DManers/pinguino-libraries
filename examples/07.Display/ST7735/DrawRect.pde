/**
        Author: 	Régis Blanchot (Mar. 2014)
        Tested on:	Pinguino 47J53 & Pinguino 32MX250
        Output:	262K-color graphic TFT-LCD with ST7735 controller

        2 modes available :
        - Hardware SPI
            . default mode
            . SPI operations are handled by the CPU
            . pins have to be the CPU SPI pins
        - Software SPI
            . activated with #define SPISW
            . SPI operations are handled by the ST7735 library
            . pins can be any digital pin
        
        Wiring :
        
        ST7735    PINGUINO
        ---------------------------------------
        LED       VSS (backlight on)
        SCK       SCK
        SDA       SDO
        A0 (DC)   can be connected to any digital pin
        RESET     VSS
        CS        can be connected to any digital pin
        GND       GND
        VSS       VSS (+5V or +3.3V)
**/

//#define SPISW

/**
    Load one or more fonts and active them with ST7735.setFont()
**/

#include <fonts/font6x8.h>
//#include <fonts/font8x8.h>          // wrong direction
//#include <fonts/font10x14.h>        // ???
//#include <fonts/font12x8.h>         // wrong direction
//#include <fonts/font16x8.h>         // wrong direction
//#include <fonts/font16x16.h>        // ???

void setup()
{
    // init. the random number generator    
    int seed;
    seed = millis();
    randomSeed(seed);

    // if SPISW is defined
    // ST7735_init(cs, dc, sda, sck);

    ST7735.init(0, 2); // CS and DC
    ST7735.setFont(font6x8);
    ST7735.setBackgroundColor(ST7735_BLACK);
    ST7735.clearScreen();
}   

void loop()
{
    u16 x1 = random(0, 159);     // coordinate x E [0,159]
    u16 y1 = random(0, 127);     // coordinate y E [0, 127]
    u16 x2 = random(0, 159);     // coordinate x E [0,159]
    u16 y2 = random(0, 127);     // coordinate y E [0, 127]
    u16 c  = random(0, 0xFFFF);  // color c E [0, 65535]
    u8 f   = random(0, 399);       // form c E [0, 399]
        
    // display
    ST7735.setColor(c);
    
    if (f<100)
        ST7735.drawRect(x1, y1, x2, y2);
    else if (f<200)
        ST7735.drawRoundRect(x1, y1, x2, y2);
    else if (f<300)
        ST7735.fillRect(x1, y1, x2, y2);
    else if (f<400)
        ST7735.fillRoundRect(x1, y1, x2, y2);
    
    // delay
    delay(150);
}
