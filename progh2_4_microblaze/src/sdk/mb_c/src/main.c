//AXI GPIO driver
#include "xgpio.h"

//send data over UART
#include "xil_printf.h"

//information about AXI peripherals
#include "xparameters.h"

int main()
{
	XGpio gpio;
	u32 dip;

	XGpio_Initialize(&gpio, 0);

	XGpio_SetDataDirection(&gpio, 2, 0x00000000); // set LED GPIO channel tristates to All Output
	XGpio_SetDataDirection(&gpio, 1, 0xFFFFFFFF); // set DIP GPIO channel tristates to All Input

	while (1)
	{
		dip = XGpio_DiscreteRead(&gpio, 1);

		XGpio_DiscreteWrite(&gpio, 2, dip);

		xil_printf("\rdip-switch state: %08x", dip);
	}
}
