#include <detpic32.h>

#define N 4

void send2displays(unsigned char value);
void delay(unsigned int ms);
unsigned char toBcd(unsigned char value);
void configureAll();
void putc(char byte);

volatile int voltage = 0; // Global variable
volatile int voltMin = 33;
volatile int voltMax = 0;

int main(void){

    configureAll(); // Function to configure all (digital I/O, analog
                    // input, A/D module, timers T1 and T3, interrupts)
    // Reset AD1IF, T1IF and T3IF flags 
    IFS1bits.AD1IF = 0;
    IFS0bits.T1IF = 0; // Reset timer T1 interrupt flag
    IFS0bits.T3IF = 0; // Reset timer T3 interrupt flag

    EnableInterrupts(); // Global Interrupt Enable

    voltMin = 33;
    voltMax = 0;

    while (1)
    {
        IdleMode();
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

    //printInt(voltage, 10 | 4 << 16); // Print voltage value
    //putChar('V');
    //putChar('\n');

    // Update variables "voltMin" and "voltMax"
    if (voltage > voltMax)
    {
        voltMax = voltage;
    }
    if (voltage < voltMin)
    {
        voltMin = voltage;
    }
     
    
    IFS1bits.AD1IF = 0; // Reset AD1IF flag
} 

void _int_(32) isr_uart2(void)
{
    char c = U2RXREG; // Read character from FIFO
    if(c == 'M'){
        // Send "voltMax" to the serial port UART2
        putc(voltMax/10 + 0x30);
        putc('.');
        putc(voltMax%10 + 0x30);
        putc('V');
        //int voltMaxBCD = toBcd(voltMax);

    }
    else if(c == 'm'){
        putc(voltMin/10 + 0x30);
        putc('.');
        putc(voltMin%10 + 0x30);
        putc('V');
        // Send "voltMin" to the serial port UART2
    }
        // Clear UART2 rx interrupt flag
        IFS1bits.U2RXIF = 0;
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

    // Configure UART2: 115200, N, 8, 1
    U2BRG = (20000000 + 8*115200) / (16*115200) - 1;
    U2MODEbits.BRGH = 0;
    
    U2MODEbits.PDSEL = 0;
    U2MODEbits.STSEL = 0;
    
    U2STAbits.URXEN = 1;
    U2STAbits.UTXEN = 1; 
    
    U2MODEbits.ON = 1;

    // Configure UART2 interrupts, with RX interrupts enabled
    // and TX interrupts disabled:
    // enable U2RXIE, disable U2TXIE (register IEC1)
    // set UART2 priority level (register IPC8)
    // clear Interrupt Flag bit U2RXIF (register IFS1)
    // define RX interrupt mode (URXISEL bits)
    
    IEC1bits.U2RXIE = 1;
    IEC1bits.U2TXIE = 0;
    
    IPC8bits.U2IP = 2;
    
    IFS1bits.U2RXIF = 0;  
    
    U2STAbits.URXISEL = 0;

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

void delay(unsigned int ms)
{
    resetCoreTimer();
    while(readCoreTimer() < 20000 * ms);
}

unsigned char toBcd(unsigned char value)
{
    return ((value / 10) << 4) + (value % 10);
} 

void putc(char byte)
{
    // wait while UART2 UTXBF == 1
    while (U2STAbits.UTXBF == 1);
    // Copy "byte" to the U2TXREG register
    U2TXREG = byte;
} 


