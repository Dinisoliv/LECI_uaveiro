#include <detpic32.h>
#define N 4

void send2displays(unsigned char value);
unsigned char toBcd(unsigned char value);
void configureAll();
void setPWM(unsigned int dutyCycle);


volatile int voltage = 0; // Global variable

int main(void){

    configureAll(); // Function to configure all (digital I/O, analog
                    // input, A/D module, timers T1 and T3, interrupts)
    // Reset AD1IF, T1IF and T3IF flags 
    IFS1bits.AD1IF = 0;
    IFS0bits.T1IF = 0; // Reset timer T1 interrupt flag
    IFS0bits.T3IF = 0; // Reset timer T3 interrupt flag

    int dutyCycle; 

    EnableInterrupts(); // Global Interrupt Enable

    while (1)
    {
        // Read RB1, RB0 to the variable "portVal"
        int portVal = LATB & 0x0003;
        switch(portVal)
        {
            case 0: // Measure input voltage
                // Enable T1 interrupts
                IEC0bits.T1IE = 1;
                setPWM(0);
            break;
            case 1: // Freeze
                // Disable T1 interrupts
                IEC0bits.T1IE = 0;
                setPWM(100);
            break;
            default:
                // Enable T1 interrupts
                IEC0bits.T1IE = 1;
                dutyCycle = voltage * 3;
                setPWM(dutyCycle);
            break;
        }
    }

    return 0;
}

void _int_(4) isr_T1(void)
{
    // Start A/D conversion
    AD1CON1bits.ASAM = 1;
    // Reset T1IF flag
    IFS0bits.T1IF = 0;
} 

void _int_(12) isr_T3(void)
{
    // Send the value of the global variable "voltage" to the displays
    // using BCD (decimal) format
    int voltageBCD = toBcd(voltage);
    send2displays(voltageBCD);
    // Reset T3IF flag
    IFS0bits.T3IF = 0;

} 

void _int_(27) isr_adc(void)
{
    // Calculate buffer average (8 samples)
    // Calculate voltage amplitude and copy it to "voltage"
    int *p = (int *)(&ADC1BUF0);
    int sum = 0;
    for(; p <= (int *)(&ADC1BUFF); p+=4 ) {
        sum += *p;
    }
        
    int avg = sum / N;
    voltage = (avg *33 + 511) / 1023;

    printInt(voltage, 10 | 4 << 16); // Print voltage value
    putChar('V');
    putChar('\n');    
    
    IFS1bits.AD1IF = 0; // Reset AD1IF flag
} 

void setPWM(unsigned int dutyCycle)
{
    // duty_cycle must be in the range [0, 100]
    if (dutyCycle>0 && dutyCycle<100)
        OC1RS = 50000*dutyCycle/100; // Determine OC1RS as a function of "dutyCycle"
} 

void configureAll(){
    TRISBbits.TRISB4 = 1; // RB4 digital output disconnected
    AD1PCFGbits.PCFG4 = 0; // RB4 configured as analog input
    
    AD1CON1bits.SSRC = 7; // Conversion trigger selection bits: in this
                        // mode an internal counter ends sampling and
                        // starts conversion
    AD1CON1bits.CLRASAM = 1; // Stop conversions when the 1st A/D converter
                        // interrupt is generated. At the same time,
                        // hardware clears the ASAM bit
    AD1CON3bits.SAMC = 16; // Sample time is 16 TAD (TAD = 100 ns)
    AD1CON2bits.SMPI = N-1; // Interrupt is generated after N samples
                        // (replace N by the desired number of
                        // consecutive samples)
    AD1CHSbits.CH0SA = 4; // replace x by the desired input
                        // analog channel (0 to 15)
    AD1CON1bits.ON = 1; // Enable A/D converter
                        // This must the last command of the A/D
                        // configuration sequence 

    IPC6bits.AD1IP = 2; // configure priority of A/D interrupts
    IEC1bits.AD1IE = 1; // enable A/D interrupts

    TRISB = TRISB & 0x80FF;
    TRISD = TRISD & 0xFF9F;

    TRISB = TRISB | 0x0003;
    
    T1CONbits.TCKPS = 2;   // 1:32 prescaler (i.e Fout_presc = 625 KHz)
    PR1 = 62499;           // Fout = 20MHz / (32 * (62499 + 1)) = 10 Hz
    TMR1 = 0;              // Reset timer T2 count register
    T1CONbits.TON = 1;     // Enable timer T2 (must be the last command of the
                           // timer configuration sequence)

    IPC1bits.T1IP = 2;  // Interrupt priority (must be in range [1..6])
    IEC0bits.T1IE = 1;  // Enable timer T2 interrupts

    T3CONbits.TCKPS = 2;   // 1:32 prescaler (i.e Fout_presc = 625 KHz)
    PR3 = 49999;           // Fout = 20MHz / (32 * (62499 + 1)) = 10 Hz
    TMR3 = 0;              // Reset timer T2 count register
    T3CONbits.TON = 1;     // Enable timer T2 (must be the last command of the
                           // timer configuration sequence)

    IPC3bits.T3IP = 2; // Interrupt priority (must be in range [1..6])
    IEC0bits.T3IE = 1; // Enable timer T2 interrupts

    OC1CONbits.OCM = 6;     // PWM mode on OCx; fault pin disabled
    OC1CONbits.OCTSEL = 1;  // Use timer T2 as the time base for PWM generation

    OC1CONbits.ON = 1;
}

void send2displays(unsigned char value){
    static const char disp7Scodes[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 
        0x7D, 0x07, 0x7F, 0x6F, 0x77, 0x7C, 0x39, 0x5E, 0x79, 0x71};
    static char displayFlag = 0;
    int dh = value >> 4;
    int dl = value & 0x0F;

    if(displayFlag == 0){
        LATD=(LATD & 0xFF9F) | (0x0020);
        LATB = (LATB & 0x80FF) | (disp7Scodes[dl] << 8); 
    }
    else{
        LATD=(LATD & 0xFF9F) | (0x0040);
        LATB = (LATB & 0x80FF) | (disp7Scodes[dh] << 8);
    }
    displayFlag = !displayFlag;
}

unsigned char toBcd(unsigned char value)
{
    return ((value / 10) << 4) + (value % 10);
} 

