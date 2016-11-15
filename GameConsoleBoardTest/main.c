/*
 * $safeprojectname$.c
 *
 * Created: 22/10/2016 12:15:14
 * Author : IHA
 */ 

#define F_CPU 14745600L

#include <avr/io.h>
#include <avr/sfr_defs.h>
#include <util/delay.h>

void init_board()
{
//uint8_t = unsigned interger of 8 bit type.

	// Pull up on Joystick inputs
	PORTC |= _BV(PORTC0) | _BV(PORTC1) | _BV(PORTC2) | _BV(PORTC3); // portc = 00000001 | 00000010 | 000000100 | 00001000 = 00001111
	PORTD |= _BV(PORTD3);
	
	// Shiftregister control pins to output
	// SER, RCK, SCK, G (enable output)
	DDRD |= _BV(DDD2) | _BV(DDD4) | _BV(DDD5) | _BV(DDD6);
	// G (enable output) high
	PORTD |= _BV(PORTD6);
	
	// Column pins to output
	DDRA |= 0xFF;
	DDRB |= _BV(DDB0) | _BV(DDB1);
}

void prepare_shiftregister()
{
	// Set SER to 1
	PORTD |= _BV(PORTD2);
}

void shift_to_next_row()
{
	// one SCK puls
	PORTD |= _BV(PORTD5);
	//_delay_us(2);
	PORTD &= ~_BV(PORTD5);
	//_delay_us(2);
	
	// one RCK puls
	PORTD |= _BV(PORTD4);
//	_delay_us(2);
	PORTD &= ~_BV(PORTD4);
	//_delay_us(2);
	
	// Set SER to 0
	PORTD &= ~_BV(PORTD2);	
}

void load_col_value(uint16_t col_value)
{
	PORTA = ~(col_value & 0xFF);
	
	// Manipulate only with PB0 and PB1
	PORTB |= 0x03;
	PORTB &= ~((col_value >> 8) & 0x03);
}

int switch_display()
{
	if (PORTC != 0)
	return 1;
	else return 0;

}
int main(void)
{
	
	init_board();
	
	// Shift register Enable output (G=0)
	PORTD &= ~_BV(PORTD6);

	uint16_t col_value[14] = {0, 0, 28, 62, 126, 254, 508, 254, 126, 62, 28, 0, 0, 0};
    while (1) 
    {

		prepare_shiftregister();
		if(switch_display() == 1)
		{
			col_value[14] = {508,254,126,62,28,0,0,0,0,0,28,62,126,254};
		}
		
		for (uint8_t i = 0; i<14; i++)
		{
			load_col_value(col_value[i]);
			shift_to_next_row();
			_delay_us(500);
		}
    }
}

