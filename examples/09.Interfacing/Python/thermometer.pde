/*
    Pinguino example to read DS18B20 1-wire temperature sensor
    Result is sent on USB bus and can be read with thermometer.py

    author          Régis Blanchot
    first release   14/09/2010
    last update     22/05/2016
    IDE             Pinguino version >= 12

    DS18B20 Connection
    ------------------
    pin 1: GND
    pin 2: DQ (Data in/out) must be connected to the PIC
    pin 3: VDD (+5V)
    NB : 1-wire bus (DQ line) must have 4K7 pull-up resistor (connected to +5V)
*/

#define ONEWIREBUS	0   // 1-wire bus is on pin 31
                        // can be on any other pin 

void setup()
{
    pinMode(USERLED, OUTPUT);
}

void loop()
{
    TEMPERATURE t;

    // Change the LED status
    toggle(USERLED);

    // Read the DS18B20 sensor
    //DS18x20.readFahrenheit(ONEWIREBUS, SKIPROM, &t);
    DS18x20.readCelsius(ONEWIREBUS, SKIPROM, &t);

    // Send 4 bytes on the USB bus
    USB.send(&t, 4);

    // Wait for 1 second
    delay(1000);
}
